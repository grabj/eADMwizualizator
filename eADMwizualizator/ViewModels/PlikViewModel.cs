using eADMwizualizator.Commands;
using eADMwizualizator.Helpers;
using eADMwizualizator.Models;
using SharpCompress.Readers;
using SharpCompress.Common;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace eADMwizualizator.ViewModels
{
    public class PlikViewModel : BaseViewModel
    {
        private CancellationTokenSource? _scanCts;

        #region Właściwości

        private string? _sciezkaAktywnejPaczki;
        public string? SciezkaAktywnejPaczki
        {
            get => _sciezkaAktywnejPaczki;
            private set => SetProperty(ref _sciezkaAktywnejPaczki, value);
        }

        public ObservableCollection<Plik> Dokumenty { get; } = new ObservableCollection<Plik>();
        public ObservableCollection<Plik> Sprawy { get; } = new ObservableCollection<Plik>();
        public ObservableCollection<Plik> Metadane { get; } = new ObservableCollection<Plik>();
        public ObservableCollection<Plik> PlikiWPaczce { get; } = new ObservableCollection<Plik>();
        public ObservableCollection<MetadataEntry> SelectedMetadata { get; } = new ObservableCollection<MetadataEntry>();
        public ObservableCollection<SprawaNode> Nodes { get; } = new ObservableCollection<SprawaNode>();

        public ReadOnlyCollection<string>? tempFolderCollection;

        internal static readonly List<string> PaczkaEadmRozszerzenia = new List<string> { "tar", "zip" };

        // widoki
        public ICommand SelectViewCommand { get; private set; }
        private int _activeTabIndex;
        public int ActiveTabIndex
        {
            get => _activeTabIndex;
            set => SetProperty(ref _activeTabIndex, value);
        }
        private string? _selectedViewName;
        public string? SelectedViewName
        {
            get => _selectedViewName;
            set => SetProperty(ref _selectedViewName, value);
        }
        public IReadOnlyList<string>? ViewNames { get; private set; }
        private Dictionary<string, int>? _viewIndexes;

        private bool _isOpenPackageVisible = true;
        public bool IsOpenPackageVisible
        {
            get => _isOpenPackageVisible;
            set => SetProperty(ref _isOpenPackageVisible, value);
        }

        private bool _nieZamykajPaneluOtworzPaczke;
        public bool NieZamykajPaneluOtworzPaczke
        {
            get => _nieZamykajPaneluOtworzPaczke;
            set
            {
                if (SetProperty(ref _nieZamykajPaneluOtworzPaczke, value) && value)
                {
                    IsOpenPackageVisible = true;
                }
            }
        }

        private Plik? _selectedDocumentFile;
        public Plik? SelectedDocumentFile
        {
            get => _selectedDocumentFile;
            set
            {
                if (SetProperty(ref _selectedDocumentFile, value))
                {
                    SelectedFilePath = _selectedDocumentFile?.Sciezka;
                    UpdateSelectedDocumentDisplayName();
                    // wczytanie metadanych asynchronicznie (jeżeli kosztowne)
                    LoadSelectedDocumentFile();
                }
            }
        }

        private Plik? _selectedMetadataFile;
        public Plik? SelectedMetadataFile
        {
            get => _selectedMetadataFile;
            set
            {
                if (SetProperty(ref _selectedMetadataFile, value))
                {
                    UpdateSelectedMetadataDisplayName();
                    LoadSelectedMetadataFile();
                }
            }
        }

        private string? _selectedFilePath;
        public string? SelectedFilePath
        {
            get => _selectedFilePath;
            private set => SetProperty(ref _selectedFilePath, value);
        }

        private string? _selectedDocumentDisplayName;
        public string SelectedDocumentDisplayName
        {
            get => _selectedDocumentDisplayName ?? string.Empty;
            private set => SetProperty(ref _selectedDocumentDisplayName, value);
        }

        private string? _selectedMetadataDisplayName;
        public string SelectedMetadataDisplayName
        {
            get => _selectedMetadataDisplayName ?? string.Empty;
            private set => SetProperty(ref _selectedMetadataDisplayName, value);
        }

        #endregion

        #region Konstruktor

        public PlikViewModel()
        {
            SciezkaAktywnejPaczki = @".\temp";

            ViewNames = new List<string> { "Dokumenty", "Sprawy", "Metadane" }.AsReadOnly();
            _viewIndexes = ViewNames.Select((n, i) => new { n, i })
                                    .ToDictionary(x => x.n, x => x.i, StringComparer.OrdinalIgnoreCase);

            ActiveTabIndex = 0;
            SelectedViewName = ViewNames.ElementAtOrDefault(ActiveTabIndex);

            SelectViewCommand = new RelayCommand(param => SelectView(param));
        }

        #endregion

        #region Ładowanie paczki

        public async Task LoadDirectoryFromArchiveAsync(string archivePath, CancellationToken cancellationToken = default)
        {
            if (string.IsNullOrWhiteSpace(archivePath))
                throw new ArgumentNullException(nameof(archivePath));

            var ext = Path.GetExtension(archivePath).TrimStart('.').ToLowerInvariant();
            if (!PaczkaEadmRozszerzenia.Contains(ext))
                throw new NotSupportedException("Nieobsługiwany format pliku.");

            string targetDir = Helpers.TempDirectoryManager.CreateRunTempDir();

            // ekstrakcję wykonujemy w tle, propagujemy cancellation
            await Task.Run(() =>
            {
                using Stream fileStream = File.Open(archivePath, FileMode.Open, FileAccess.Read, FileShare.Read);
                using var reader = ReaderFactory.Open(fileStream);
                while (reader.MoveToNextEntry())
                {
                    cancellationToken.ThrowIfCancellationRequested();
                    if (!reader.Entry.IsDirectory)
                    {
                        var attempts = 3;
                        for (int i = 0; i < attempts; i++)
                        {
                            try
                            {
                                reader.WriteEntryToDirectory(targetDir, new ExtractionOptions { ExtractFullPath = true, Overwrite = true });
                                break;
                            }
                            catch (IOException)
                            {
                                if (i == attempts - 1) throw;
                                Task.Delay(200, cancellationToken).Wait(cancellationToken);
                            }
                        }
                    }
                }
            }, cancellationToken);

            // po rozpakowaniu — załaduj katalog
            await LoadDirectoryAsync(new Plik(targetDir, Path.GetFileName(targetDir)));
        }

        // Aby zachować kompatybilność, udostępniamy obie metody:
        public void LoadDirectory(Plik paczka) => _ = LoadDirectoryAsync(paczka);

        public async Task LoadDirectoryAsync(Plik paczka)
        {
            // anuluj poprzednie skanowanie
            _scanCts?.Cancel();
            _scanCts?.Dispose();
            _scanCts = new CancellationTokenSource();

            // wyczyść stare zbiory (warstwa UI zaktualizuje się automatycznie)
            Application.Current.Dispatcher.Invoke(() =>
            {
                PlikiWPaczce.Clear();
                Dokumenty.Clear();
                Sprawy.Clear();
                Metadane.Clear();
                SelectedMetadata.Clear();
                Nodes.Clear();
            });

            tempFolderCollection = null;

            try
            {
                var entries = await Task.Run(() => EnumerateEntriesSafe(paczka.Sciezka, _scanCts.Token), _scanCts.Token);
                tempFolderCollection = new ReadOnlyCollection<string>(entries);

                // dodawaj elementy stopniowo na wątku UI
                foreach (var entry in tempFolderCollection)
                {
                    _scanCts.Token.ThrowIfCancellationRequested();
                    AddEntryToCollections(entry);
                }

                SciezkaAktywnejPaczki = paczka.Sciezka;
                BuildNodes();
            }
            catch (OperationCanceledException)
            {
                // anulowano skanowanie — nic więcej nie robimy
            }
            catch (Exception ex)
            {
                // logging: w prawdziwym projekcie wyrzuć do loggera
                Application.Current.Dispatcher.Invoke(() =>
                {
                    SelectedMetadata.Clear();
                    SelectedMetadata.Add(new MetadataEntry { Name = "Błąd skanowania", Value = ex.Message });
                });
            }
            finally
            {
                // czyszczenie tokenu zostawiamy do następnego uruchomienia
            }
        }

        private static List<string> EnumerateEntriesSafe(string root, CancellationToken token)
        {
            var result = new List<string>();
            try
            {
                if (!Directory.Exists(root)) return result;

                // Dodaj pliki znajdujące się bezpośrednio w root
                foreach (var f in Directory.GetFiles(root))
                {
                    token.ThrowIfCancellationRequested();
                    result.Add(f);
                }

                // Dla każdego pierwszego poziomu katalogu dodaj pliki w tym katalogu (nie rekursywnie)
                foreach (var d in Directory.GetDirectories(root))
                {
                    token.ThrowIfCancellationRequested();
                    try
                    {
                        foreach (var f in Directory.GetFiles(d))
                        {
                            token.ThrowIfCancellationRequested();
                            result.Add(f);
                        }
                    }
                    catch
                    {
                        // ignorujemy błędy odczytu pojedynczego katalogu
                    }
                }
            }
            catch
            {
                // ignorujemy błędy odczytu katalogów ale w docelowym kodzie loguj
            }
            return result;
        }

        private void AddEntryToCollections(string filePath)
        {
            Application.Current.Dispatcher.Invoke(() =>
            {
                var fileName = Path.GetFileName(filePath);
                var plik = new Plik(filePath, fileName)
                {
                    CzyUkryty = IsFileHidden(filePath),
                    CzyFolder = IsDirectory(filePath),
                    Rozszerzenie = GetFileExtension(filePath)
                };

                var category = PathHelpers.GetFileCategoryFromPath(filePath);

                if (category == FileCategory.Metadane)
                {
                    try
                    {
                        var meta = MetadataLoader.ParseMetadaneMetadata(filePath);
                        if (meta != null)
                        {
                            meta.CzyUkryty = plik.CzyUkryty;
                            meta.CzyFolder = plik.CzyFolder;
                            meta.Rozszerzenie = plik.Rozszerzenie;
                            meta.Category = FileCategory.Metadane;
                            plik = meta;
                        }
                    }
                    catch
                    {
                        // parse error -> użyj zwykłego Plik; wprowadź logowanie w przyszłości
                    }
                }
                else if (category == FileCategory.Sprawy)
                {
                    try
                    {
                        var metaSprawa = MetadataLoader.ParseSprawaMetadata(filePath);
                        if (metaSprawa != null)
                        {
                            metaSprawa.CzyUkryty = plik.CzyUkryty;
                            metaSprawa.CzyFolder = plik.CzyFolder;
                            metaSprawa.Rozszerzenie = plik.Rozszerzenie;
                            metaSprawa.Category = FileCategory.Sprawy;
                            plik = metaSprawa;
                        }
                    }
                    catch
                    {
                        // ignore parse error
                    }
                }

                PlikiWPaczce.Add(plik);

                switch (category)
                {
                    case FileCategory.Dokumenty:
                        Dokumenty.Add(plik);
                        break;
                    case FileCategory.Sprawy:
                        Sprawy.Add(plik);
                        break;
                    case FileCategory.Metadane:
                        Metadane.Add(plik);
                        break;
                    default:
                        break;
                }
            });
        }

        #endregion

        #region Metadane

        private void LoadSelectedDocumentFile()
        {
            SelectedMetadata.Clear();

            if (_selectedDocumentFile == null)
            {
                SelectedMetadataDisplayName = string.Empty;
                return;
            }

            var docFileName = Path.GetFileName(_selectedDocumentFile.Sciezka);
            if (string.IsNullOrEmpty(docFileName))
            {
                SelectedMetadataDisplayName = string.Empty;
                return;
            }

            var metadataFileName = docFileName + ".xml";

            string? candidatePath = null;
            if (!string.IsNullOrEmpty(SciezkaAktywnejPaczki))
            {
                var direct = Path.Combine(SciezkaAktywnejPaczki, PathHelpers.GetFolderName(FileCategory.Metadane), metadataFileName);
                if (File.Exists(direct)) candidatePath = direct;
            }

            if (candidatePath == null)
            {
                candidatePath = PathHelpers.FindMetadataInPackage(PlikiWPaczce, metadataFileName);
            }

            SelectedMetadataDisplayName = string.IsNullOrEmpty(candidatePath) ? string.Empty : Path.GetFileName(candidatePath);

            if (string.IsNullOrEmpty(candidatePath) || !File.Exists(candidatePath))
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Info", Value = $"Brak pliku metadanych: {metadataFileName}" });
                return;
            }

            try
            {
                var entries = MetadataLoader.LoadMetadataEntries(candidatePath);
                foreach (var e in entries) SelectedMetadata.Add(e);
            }
            catch (Exception ex)
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Błąd", Value = ex.Message });
            }
        }

        private void LoadSelectedMetadataFile()
        {
            SelectedMetadata.Clear();
            SelectedDocumentFile = null;

            if (_selectedMetadataFile == null)
            {
                SelectedMetadataDisplayName = string.Empty;
                return;
            }

            var metaFilePath = _selectedMetadataFile.Sciezka;
            if (string.IsNullOrEmpty(metaFilePath) || !File.Exists(metaFilePath))
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Info", Value = "Plik metadanych niedostępny." });
                SelectedMetadataDisplayName = string.Empty;
                return;
            }

            try
            {
                var entries = MetadataLoader.LoadMetadataEntries(metaFilePath);
                foreach (var e in entries) SelectedMetadata.Add(e);
            }
            catch (Exception ex)
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Błąd", Value = ex.Message });
            }

            SelectedMetadataDisplayName = Path.GetFileName(metaFilePath);

            var metaFileName = Path.GetFileName(metaFilePath) ?? string.Empty;
            var docFileName = metaFileName.EndsWith(".xml", StringComparison.OrdinalIgnoreCase)
                ? metaFileName.Substring(0, metaFileName.Length - 4)
                : metaFileName;

            var foundDoc = PathHelpers.FindDocumentInPackage(PlikiWPaczce, docFileName);

            if (foundDoc == null && !string.IsNullOrEmpty(SciezkaAktywnejPaczki))
            {
                var candidate = Path.Combine(SciezkaAktywnejPaczki, "dokumenty", docFileName);
                if (File.Exists(candidate))
                {
                    foundDoc = new Plik(candidate, docFileName)
                    {
                        CzyFolder = false,
                        CzyUkryty = IsFileHidden(candidate),
                        Rozszerzenie = GetFileExtension(candidate),
                        Category = FileCategory.Dokumenty
                    };
                }
            }

            if (foundDoc != null)
            {
                SelectedDocumentFile = foundDoc;
                SelectedFilePath = foundDoc.Sciezka;
            }
            else
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Info", Value = $"Nie znaleziono dokumentu: {docFileName}" });
            }
        }

        #endregion

        #region Sprawy

        public void BuildNodes()
        {
            Nodes.Clear();

            foreach (var sprawa in Sprawy)
            {
                var fileName = Path.GetFileName(sprawa.Tytul ?? Path.GetFileName(sprawa.Sciezka) ?? string.Empty);
                var fallbackKey = Path.GetFileNameWithoutExtension(fileName)?.Trim() ?? string.Empty;

                string? sprawaKeyRaw = null;
                if (sprawa is Metadata ms && !string.IsNullOrWhiteSpace(ms.Grupowanie))
                {
                    sprawaKeyRaw = Path.GetFileName(ms.Grupowanie);
                }

                var sprawaKey = !string.IsNullOrWhiteSpace(sprawaKeyRaw)
                    ? Path.GetFileNameWithoutExtension(sprawaKeyRaw).Trim()
                    : fallbackKey;

                Nodes.Add(new SprawaNode(sprawa, sprawaKey));
            }

            foreach (var doc in Dokumenty)
            {
                var docFileName = Path.GetFileName(doc.Tytul ?? Path.GetFileName(doc.Sciezka) ?? string.Empty);
                if (string.IsNullOrEmpty(docFileName)) continue;

                var expectedMetaFileName = docFileName + ".xml";

                var candidateMeta = Metadane.FirstOrDefault(m =>
                    string.Equals(Path.GetFileName(m.Sciezka), expectedMetaFileName, StringComparison.OrdinalIgnoreCase))
                    ?? PlikiWPaczce.FirstOrDefault(m =>
                    string.Equals(Path.GetFileName(m.Sciezka), expectedMetaFileName, StringComparison.OrdinalIgnoreCase));

                if (candidateMeta == null) continue;

                string? grupRaw = null;
                if (candidateMeta is Metadata m && !string.IsNullOrWhiteSpace(m.Grupowanie)) grupRaw = m.Grupowanie;
                if (string.IsNullOrWhiteSpace(grupRaw)) continue;

                var grupNormalized = Path.GetFileNameWithoutExtension(grupRaw).Trim().ToLowerInvariant();

                var targetNode = Nodes.FirstOrDefault(n =>
                    string.Equals(Path.GetFileNameWithoutExtension(n.GrupowanieKey)?.Trim().ToLowerInvariant(), grupNormalized, StringComparison.OrdinalIgnoreCase));

                if (targetNode != null) targetNode.Documents.Add(doc);
            }
        }

        #endregion

        #region Pomocnicze funkcje

        protected bool IsFileHidden(string fileName)
        {
            try
            {
                var attr = File.GetAttributes(fileName);
                return attr.HasFlag(FileAttributes.Hidden);
            }
            catch { return false; }
        }

        protected bool IsDirectory(string fileName)
        {
            try
            {
                var attr = File.GetAttributes(fileName);
                return attr.HasFlag(FileAttributes.Directory);
            }
            catch { return false; }
        }

        protected string? GetFileExtension(string fileName)
        {
            try
            {
                var ext = Path.GetExtension(fileName);
                if (string.IsNullOrEmpty(ext)) return null;
                return ext.TrimStart('.').ToLowerInvariant();
            }
            catch { return null; }
        }

        private void UpdateSelectedDocumentDisplayName()
        {
            if (_selectedDocumentFile == null)
            {
                SelectedDocumentDisplayName = string.Empty;
                return;
            }

            var tytul = _selectedDocumentFile.Tytul;
            var sciezka = _selectedDocumentFile.Sciezka;

            if (!string.IsNullOrWhiteSpace(tytul) && Path.HasExtension(tytul))
            {
                SelectedDocumentDisplayName = tytul!;
                return;
            }

            if (!string.IsNullOrWhiteSpace(sciezka))
            {
                var fileName = Path.GetFileName(sciezka);
                if (!string.IsNullOrEmpty(fileName))
                {
                    SelectedDocumentDisplayName = fileName;
                    return;
                }
            }

            SelectedDocumentDisplayName = tytul ?? string.Empty;
        }

        private void UpdateSelectedMetadataDisplayName()
        {
            if (_selectedMetadataFile == null)
            {
                SelectedMetadataDisplayName = string.Empty;
                return;
            }

            var tytul = _selectedMetadataFile.Tytul;
            var sciezka = _selectedMetadataFile?.Sciezka;

            if (!string.IsNullOrWhiteSpace(tytul) && Path.HasExtension(tytul))
            {
                SelectedMetadataDisplayName = tytul!;
                return;
            }

            if (!string.IsNullOrWhiteSpace(sciezka))
            {
                var fileName = Path.GetFileName(sciezka);
                if (!string.IsNullOrEmpty(fileName))
                {
                    SelectedMetadataDisplayName = fileName;
                    return;
                }
            }

            SelectedMetadataDisplayName = tytul ?? string.Empty;
        }

        private void SelectView(object? parameter)
        {
            string? name = null;
            if (parameter is SubMenu s) name = s.Name;
            if (string.IsNullOrWhiteSpace(name)) return;

            name = name.Trim();
            SelectedViewName = name;

            if (_view_indexes_try_get(name, out int idx))
            {
                ActiveTabIndex = idx;
            }
            else
            {
                ActiveTabIndex = 1;
                SelectedViewName = ViewNames?.ElementAtOrDefault(ActiveTabIndex);
            }

            // lokalna helper aby uniknąć wielokrotnego dostępu
            bool _view_indexes_try_get(string name, out int index) { index = 0; return _viewIndexes != null && _viewIndexes.TryGetValue(name, out index); }
        }

        #endregion

        #region Commands

        private ICommand? _openSettingsCommand;
        public ICommand OpenSettingsCommand => _openSettingsCommand ??= new Command(() => { /* otwórz okno ustawień */ });

        #endregion
    }
}