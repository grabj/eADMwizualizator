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
        private CancellationTokenSource? _scanFolders;

        #region Właściwości

        private string? _activePackagePath;
        public string? ActivePackagePath
        {
            get => _activePackagePath;
            private set => SetProperty(ref _activePackagePath, value);
        }

        public ObservableCollection<Plik> Dokumenty { get; } = new ObservableCollection<Plik>();
        public ObservableCollection<Plik> Sprawy { get; } = new ObservableCollection<Plik>();
        public ObservableCollection<Plik> Metadane { get; } = new ObservableCollection<Plik>();
        public ObservableCollection<Plik> PlikiWPaczce { get; } = new ObservableCollection<Plik>();
        public ObservableCollection<MetadataEntry> SelectedMetadata { get; } = new ObservableCollection<MetadataEntry>();
        public ObservableCollection<SprawaNode> Nodes { get; } = new ObservableCollection<SprawaNode>();

        public ReadOnlyCollection<string>? tempFolderCollection;

        internal static readonly List<string> eadmPackageExtensions = new List<string> { "tar", "zip" };

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

        private bool _isKeepOpenPackagePanelVisible = true;
        public bool IsKeepOpenPackagePanelVisible
        {
            get => _isKeepOpenPackagePanelVisible;
            set => SetProperty(ref _isKeepOpenPackagePanelVisible, value);
        }

        private bool _keepOpenPackagePanelVisible;
        public bool KeepOpenPackagePanelVisible
        {
            get => _keepOpenPackagePanelVisible;
            set
            {
                if (SetProperty(ref _keepOpenPackagePanelVisible, value) && value)
                {
                    IsKeepOpenPackagePanelVisible = true;
                }
            }
        }

        private Plik? _selectedDocumentFile;
        public Plik? SelectedDocumentFile
        {
            get => _selectedDocumentFile;
            set
            {
                // SetProperty zwróci false gdy referencja się nie zmieni.
                // W takim przypadku wymuszamy odświeżenie szczegółów jeśli wartość nie jest null.
                var changed = SetProperty(ref _selectedDocumentFile, value);
                if (!changed)
                {
                    if (value != null)
                    {
                        SelectedFilePath = value.Sciezka;
                        UpdateSelectedDocumentDisplayName();
                        // Wywołanie asynchroniczne żeby nie blokować UI
                        _ = LoadSelectedDocumentFile();
                    }
                    else
                    {
                        SelectedFilePath = null;
                        UpdateSelectedDocumentDisplayName();
                    }
                    return;
                }

                SelectedFilePath = _selectedDocumentFile?.Sciezka;
                UpdateSelectedDocumentDisplayName();
                // Wywołanie asynchroniczne żeby nie blokować UI
                _ = LoadSelectedDocumentFile();
            }
        }

        private Plik? _selectedMetadataFile;    
        public Plik? SelectedMetadataFile
        {
            get => _selectedMetadataFile;
            set
            {
                // SetProperty zwróci false gdy referencja się nie zmieni.
                // W takim przypadku wymuszamy odświeżenie metadanych jeśli wartość nie jest null.
                var changed = SetProperty(ref _selectedMetadataFile, value);
                if (!changed)
                {
                    if (value != null)
                    {
                        UpdateSelectedMetadataDisplayName();
                        LoadSelectedMetadataFile();
                    }
                    else
                    {
                        UpdateSelectedMetadataDisplayName();
                        SelectedMetadata.Clear();
                        MetadataHtmlContent = string.Empty;
                    }
                    return;
                }

                UpdateSelectedMetadataDisplayName();
                LoadSelectedMetadataFile();
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

        private string _metadataHtmlContent = string.Empty;
        public string MetadataHtmlContent
        {
            get => _metadataHtmlContent;
            private set => SetProperty(ref _metadataHtmlContent, value ?? string.Empty);
        }

        #endregion

        #region Konstruktor

        public PlikViewModel()
        {
            ActivePackagePath = @".\temp";

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
            if (!eadmPackageExtensions.Contains(ext))
                throw new NotSupportedException("Nieobsługiwany format pliku.");

            string targetDir = Helpers.TempDirectoryManager.CreateRunTempDir();

            // rozpakowywanie w tle
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

        public async Task LoadDirectoryAsync(Plik paczka)
        {
            // anuluj poprzednie skanowanie
            _scanFolders?.Cancel();
            _scanFolders?.Dispose();
            _scanFolders = new CancellationTokenSource();

            // wyczyść stare dane na UI
            Application.Current.Dispatcher.Invoke(() =>
            {
                PlikiWPaczce.Clear();
                Dokumenty.Clear();
                Sprawy.Clear();
                Metadane.Clear();
                SelectedMetadata.Clear();
                MetadataHtmlContent = string.Empty;
                Nodes.Clear();
            });

            tempFolderCollection = null;

            try
            {
                var entries = await Task.Run(() => EnumerateEntriesSafe(paczka.Sciezka, _scanFolders.Token), _scanFolders.Token);
                tempFolderCollection = new ReadOnlyCollection<string>(entries);

                // dodawaj elementy stopniowo na wątku UI
                foreach (var entry in tempFolderCollection)
                {
                    _scanFolders.Token.ThrowIfCancellationRequested();
                    AddEntryToCollections(entry);
                }

                ActivePackagePath = paczka.Sciezka;
                BuildNodes();
            }
            catch (OperationCanceledException)
            {
                // anulowano skanowanie
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
                // czyszczenie tokenu do następnego uruchomienia
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
                        // ignoruj
                    }
                }
            }
            catch
            {
                // ignoruj
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
                        // parse error 
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

        private async Task LoadSelectedDocumentFile()
        {
            SelectedMetadata.Clear();
            MetadataHtmlContent = string.Empty;

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
            if (!string.IsNullOrEmpty(ActivePackagePath))
            {
                var direct = Path.Combine(ActivePackagePath, PathHelpers.GetFolderName(FileCategory.Metadane), metadataFileName);
                if (File.Exists(direct)) candidatePath = direct;
            }

            if (candidatePath == null)
            {
                candidatePath = PathHelpers.FindMetadataInPackage(PlikiWPaczce, metadataFileName);
            }

            SelectedMetadataDisplayName = string.IsNullOrEmpty(candidatePath) ? string.Empty : Path.GetFileName(candidatePath);

            if (string.IsNullOrEmpty(candidatePath) || !File.Exists(candidatePath))
            {
                Application.Current.Dispatcher.Invoke(() =>
                {
                    SelectedMetadata.Add(new MetadataEntry { Name = "Info", Value = $"Brak pliku metadanych: {metadataFileName}" });
                });
                return;
            }

            try
            {
                // Znajdź plik XSL w katalogu aplikacji
                var xslPath = FindXslFile();

                if (!string.IsNullOrEmpty(xslPath) && File.Exists(xslPath))
                {
                    // Wykonanie transformacji poza wątkiem UI
                    var htmlContent = await Task.Run(() => XsltTransformer.TransformXmlToHtml(candidatePath, xslPath));

                    // Aktualizacja na wątku UI
                    Application.Current.Dispatcher.Invoke(() =>
                    {
                        MetadataHtmlContent = htmlContent;
                    });
                }
                else
                {
                    // Fallback: załaduj jako proste pary klucz-wartość
                    var entries = await Task.Run(() => MetadataLoader.LoadMetadataEntries(candidatePath));

                    Application.Current.Dispatcher.Invoke(() =>
                    {
                        foreach (var e in entries) SelectedMetadata.Add(e);
                    });
                }
            }
            catch (Exception ex)
            {
                Application.Current.Dispatcher.Invoke(() =>
                {
                    SelectedMetadata.Add(new MetadataEntry { Name = "Błąd", Value = ex.Message });
                });
            }
        }

        private void LoadSelectedMetadataFile()
        {
            SelectedMetadata.Clear();
            SelectedDocumentFile = null;
            MetadataHtmlContent = string.Empty;

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
                // Znajdź plik XSL
                var xslPath = FindXslFile();

                if (!string.IsNullOrEmpty(xslPath) && File.Exists(xslPath))
                {
                    // Wykonaj transformację
                    var htmlContent = XsltTransformer.TransformXmlToHtml(metaFilePath, xslPath);
                    MetadataHtmlContent = htmlContent;
                }
                else
                {
                    // Fallback: załaduj jako proste pary klucz-wartość
                    var entries = MetadataLoader.LoadMetadataEntries(metaFilePath);
                    foreach (var e in entries) SelectedMetadata.Add(e);
                }
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

            if (foundDoc == null && !string.IsNullOrEmpty(ActivePackagePath))
            {
                var candidate = Path.Combine(ActivePackagePath, "dokumenty", docFileName);
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

        private string? FindXslFile()
        {
            // Szukaj pliku eADM_styl.xsl w katalogu aplikacji
            var appDir = AppDomain.CurrentDomain.BaseDirectory;
            var xslPath = Path.Combine(appDir, "eADM_styl.xsl");

            if (File.Exists(xslPath))
                return xslPath;

            // Alternatywnie szukaj w katalogu roboczy
            xslPath = Path.Combine(Directory.GetCurrentDirectory(), "eADM_styl.xsl");
            if (File.Exists(xslPath))
                return xslPath;

            return null;
        }

        #endregion

        #region Sprawy

        public void BuildNodes()
        {
            Nodes.Clear();

            // helper lokalny do normalizacji kluczy (usuwa ścieżki, rozszerzenia, trim, lowercase)
            static string? NormalizeKey(string? raw)
            {
                if (string.IsNullOrWhiteSpace(raw)) return null;
                try
                {
                    var last = Path.GetFileName(raw.Trim());
                    var noExt = Path.GetFileNameWithoutExtension(last);
                    return noExt?.Trim().ToLowerInvariant();
                }
                catch
                {
                    return raw.Trim().ToLowerInvariant();
                }
            }

            // Lista węzłów razem z ich możliwymi kluczami (WartoscId, nazwa pliku bez ext)
            var nodeKeyMap = new List<(SprawaNode Node, HashSet<string> Keys)>();

            foreach (var sprawa in Sprawy)
            {
                var fileName = Path.GetFileName(sprawa.Tytul ?? Path.GetFileName(sprawa.Sciezka) ?? string.Empty);
                var fallbackKey = Path.GetFileNameWithoutExtension(fileName)?.Trim() ?? string.Empty;

                var keys = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

                if (sprawa is Metadata ms && !string.IsNullOrWhiteSpace(ms.WartoscId))
                {
                    var k = NormalizeKey(ms.WartoscId);
                    if (!string.IsNullOrWhiteSpace(k)) keys.Add(k);
                }

                // zawsze dodajemy fallback — nazwa pliku bez rozszerzenia
                var fb = NormalizeKey(fallbackKey);
                if (!string.IsNullOrWhiteSpace(fb)) keys.Add(fb);

                // wybieramy reprezentatywny klucz do wyświetlenia (pierwszy z zestawu lub fallback)
                var primaryKey = keys.FirstOrDefault() ?? (fallbackKey ?? string.Empty);

                var node = new SprawaNode(sprawa, primaryKey);
                Nodes.Add(node);
                nodeKeyMap.Add((node, keys));
            }

            // Przypisujemy dokumenty do węzłów — tworzymy zbiór kluczy dokumentu na podstawie jego metadanych (Grupowanie)
            foreach (var doc in Dokumenty)
            {
                // lepsze źródło nazwy pliku: użyj rzeczywistej ścieżki jeśli dostępna
                var docBaseName = Path.GetFileName(doc.Tytul ?? Path.GetFileName(doc.Sciezka) ?? string.Empty);
                if (string.IsNullOrEmpty(docBaseName)) continue;

                var expectedMetaFileName = docBaseName + ".xml";

                var candidateMeta = Metadane.FirstOrDefault(m =>
                    string.Equals(Path.GetFileName(m.Sciezka), expectedMetaFileName, StringComparison.OrdinalIgnoreCase))
                    ?? PlikiWPaczce.FirstOrDefault(m =>
                    string.Equals(Path.GetFileName(m.Sciezka), expectedMetaFileName, StringComparison.OrdinalIgnoreCase));

                if (candidateMeta == null) continue;

                var docKeys = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

                if (candidateMeta is Metadata md)
                {
                    var g = NormalizeKey(md.Grupowanie);
                    if (!string.IsNullOrWhiteSpace(g)) docKeys.Add(g);
                }
                else
                {
                    // fallback: jeśli candidateMeta nie był sparsowany jako Metadata, spróbuj sparsować teraz
                    try
                    {
                        var parsed = MetadataLoader.ParseMetadaneMetadata(candidateMeta.Sciezka);
                        if (parsed != null)
                        {
                            var g = NormalizeKey(parsed.Grupowanie);
                            if (!string.IsNullOrWhiteSpace(g)) docKeys.Add(g);
                        }
                    }
                    catch
                    {
                        // ignoruj błędy parsowania tutaj
                    }
                }

                if (docKeys.Count == 0) continue;

                // znajdź pierwszy węzeł, którego klucze przecinają się ze zbiorami dokumentu
                foreach (var (node, keys) in nodeKeyMap)
                {
                    if (keys.Overlaps(docKeys))
                    {
                        node.Documents.Add(doc);
                        break; // przypisz dokument tylko do jednego węzła
                    }
                }
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
            // obsłuż różne typy parametrów (string, obiekty z Name/Header, fallback do ToString())
            string? name = null;

            if (parameter == null)
            {
                return;
            }
            else if (parameter is string sStr)
            {
                name = sStr;
            }
            else
            {
                var type = parameter.GetType();
                var prop = type.GetProperty("Name") ?? type.GetProperty("Header");
                if (prop != null)
                {
                    var val = prop.GetValue(parameter) as string;
                    if (!string.IsNullOrWhiteSpace(val)) name = val;
                }

                if (string.IsNullOrWhiteSpace(name))
                {
                    name = parameter.ToString();
                }
            }

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
    }
}