using eADMwizualizator.Commands;
using eADMwizualizator.Models;
using eADMwizualizator.Helpers;
using SharpCompress.Common;
using SharpCompress.Readers;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using System.Xml.Linq;

namespace eADMwizualizator.ViewModels
{
    public class PlikViewModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        #region Właściwości

        private string? _sciezkaAktywnejPaczki;
        public string? SciezkaAktywnejPaczki
        {
            get => _sciezkaAktywnejPaczki;
            private set
            {
                if (_sciezkaAktywnejPaczki == value) return;
                _sciezkaAktywnejPaczki = value;
                OnPropertyChanged();
            }
        }

        // Gdy true, folder będzie przeglądany rekursywnie
        private bool _czyRekursywnie = true;
        public bool CzyRekursywnie
        {
            get => _czyRekursywnie;
            set
            {
                if (_czyRekursywnie == value) return;
                _czyRekursywnie = value;
                OnPropertyChanged();
            }
        }
        public ObservableCollection<Plik> Dokumenty { get; set; } = new ObservableCollection<Plik>();
        public ObservableCollection<Plik> Sprawy { get; set; } = new ObservableCollection<Plik>();
        public ObservableCollection<Plik> Metadane { get; set; } = new ObservableCollection<Plik>();
        public ObservableCollection<Plik> PlikiWPaczce { get; set; } = new ObservableCollection<Plik>();
        public ObservableCollection<MetadataEntry> SelectedMetadata { get; } = new ObservableCollection<MetadataEntry>();
        public ObservableCollection<SprawaNode> Nodes { get; } = new ObservableCollection<SprawaNode>();

        public ReadOnlyCollection<string>? tempFolderCollection;

        private readonly BackgroundWorker bgGetFilesBackgroundWorker = new BackgroundWorker()
        {
            WorkerReportsProgress = true,
            WorkerSupportsCancellation = true
        };

        internal static readonly List<string> PaczkaEadmRozszerzenia = new List<string> { "tar", "zip" };

        // przełączanie widoku
        public ICommand SelectViewCommand { get; private set; }
        private int _activeTabIndex;
        public int ActiveTabIndex
        {
            get => _activeTabIndex;
            set { if (_activeTabIndex == value) return; _activeTabIndex = value; OnPropertyChanged(); }
        }
        private string? _selectedViewName;
        public string? SelectedViewName
        {
            get => _selectedViewName;
            set { if (_selectedViewName == value) return; _selectedViewName = value; OnPropertyChanged(); }
        }
        // nazwy widoków przypisane w konstruktorze i mapowanie na indeksy
        public IReadOnlyList<string> ViewNames { get; private set; }
        private readonly Dictionary<string, int> _viewIndexes;

        // Widoczność górnego panelu (StackPanel Grid.Row="0")
        private bool _isOpenPackageVisible = true;
        public bool IsOpenPackageVisible
        {
            get => _isOpenPackageVisible;
            set
            {
                if (_isOpenPackageVisible == value)
                    return;
                _isOpenPackageVisible = value;
                OnPropertyChanged();
            }
        }
        // panel "Otwórz paczkę" nie będzie automatycznie zamykany po otwarciu paczki
        private bool _nieZamykajPaneluOtworzPaczke = false;
        public bool NieZamykajPaneluOtworzPaczke
        {
            get => _nieZamykajPaneluOtworzPaczke;
            set
            {
                if (_nieZamykajPaneluOtworzPaczke == value) return;
                _nieZamykajPaneluOtworzPaczke = value;
                OnPropertyChanged();

                // Jeśli użytkownik zaznaczy opcję — upewnij się że panel jest widoczny.
                // Jeśli opcja zostanie odznaczona — nie zamykaj).
                if (_nieZamykajPaneluOtworzPaczke)
                {
                    IsOpenPackageVisible = true;
                }
            }
        }

        // Właściwości do przeglądania dokumentu
        private Plik? _selectedDocumentFile;
        public Plik? SelectedDocumentFile
        {
            get => _selectedDocumentFile;
            set
            {
                if (_selectedDocumentFile == value) return;
                _selectedDocumentFile = value;
                OnPropertyChanged();

                // aktualizuj ścieżkę pliku do łatwego bindowania w widoku
                SelectedFilePath = _selectedDocumentFile?.Sciezka;

                // zaktualizuj wyświetlaną nazwę dokumentu (nagłówek lewy)
                UpdateSelectedDocumentDisplayName();

                // wczytaj powiązane metadane (i zaktualizuj nazwę metadanych jeśli znalezione)
                LoadSelectedDocumentFile();
            }
        }

        private Plik? _selectedMetadataFile;
        // Gdy użytkownik wybierze plik z folderu metadane — wczytaj go do SelectedMetadata oraz ustaw odpowiadający dokument po lewej (bez końcowego .xml).
        public Plik? SelectedMetadataFile
        {
            get => _selectedMetadataFile;
            set
            {
                if (_selectedMetadataFile == value) return;
                _selectedMetadataFile = value;
                OnPropertyChanged();

                // zaktualizuj wyświetlaną nazwę metadanych (nagłówek prawy)
                UpdateSelectedMetadataDisplayName();

                LoadSelectedMetadataFile();
            }
        }

        private string? _selectedFilePath;
        // To będzie związywane z przyczepną własnością w widoku (DocumentViewer)
        public string? SelectedFilePath
        {
            get => _selectedFilePath;
            private set
            {
                if (_selectedFilePath == value) return;
                _selectedFilePath = value;
                OnPropertyChanged();
            }
        }

        // Nowa właściwość — gotowy do bindowania tekst nagłówka (nazwa pliku z rozszerzeniem)
        private string? _selectedDocumentDisplayName;
        public string SelectedDocumentDisplayName
        {
            get => _selectedDocumentDisplayName ?? string.Empty;
            private set
            {
                if (_selectedDocumentDisplayName == value) return;
                _selectedDocumentDisplayName = value;
                OnPropertyChanged();
            }
        }

        // Nowa właściwość — nazwa pliku metadanych (z rozszereniem)
        private string? _selectedMetadataDisplayName;
        public string SelectedMetadataDisplayName
        {
            get => _selectedMetadataDisplayName ?? string.Empty;
            private set
            {
                if (_selectedMetadataDisplayName == value) return;
                _selectedMetadataDisplayName = value;
                OnPropertyChanged();
            }
        }

        #endregion

        #region Konstruktor

        public PlikViewModel()
        {
            // Domyślna lokalizacja
            SciezkaAktywnejPaczki = @".\temp";

            // USTAWIANIE nazw widoków  
            ViewNames = new List<string>
            {
                "Dokumenty",
                "Sprawy",
                "Metadane"
            }.AsReadOnly();

            _viewIndexes = ViewNames
                .Select((name, idx) => new { name, idx })
                .ToDictionary(x => x.name, x => x.idx, StringComparer.OrdinalIgnoreCase);

            // USTAWIANIE domyślnego widoku
            ActiveTabIndex = 0;
            SelectedViewName = ViewNames.ElementAtOrDefault(ActiveTabIndex);

            // polecenie wybierające widok
            SelectViewCommand = new RelayCommand(param => SelectView(param));

            // listowanie plików
            bgGetFilesBackgroundWorker.DoWork += BgGetFilesBackgroundWorker_DoWork;
            bgGetFilesBackgroundWorker.ProgressChanged += BgGetFilesBackgroundWorker_ProgressChanged;
            bgGetFilesBackgroundWorker.RunWorkerCompleted += BgGetFilesBackgroundWorker_RunWorkerCompleted;
        }

        #endregion

        #region Metody publiczne do pracy z paczką

        // rozpakowuje archiwum do ./temp, ustawia SciezkaAktywnejPaczki i wywołuje LoadDirectory.
        public async Task LoadDirectoryFromArchiveAsync(string archivePath)
        {
            if (string.IsNullOrWhiteSpace(archivePath))
                throw new ArgumentNullException(nameof(archivePath));

            var ext = Path.GetExtension(archivePath).TrimStart('.').ToLowerInvariant();
            if (!PaczkaEadmRozszerzenia.Contains(ext))
                throw new NotSupportedException("Nieobsługiwany format pliku.");

            // stworzenie unikalnego katalogu dla tej sesji/uruchomienia
            string targetDir = Helpers.TempDirectoryManager.CreateRunTempDir();

            await Task.Run(() =>
            {
                // otwieramy archiwum z FileShare.Read, żeby nie blokować innych odczytów
                using (Stream fileStream = File.Open(archivePath, FileMode.Open, FileAccess.Read, FileShare.Read))
                using (var reader = ReaderFactory.Open(fileStream))
                {
                    while (reader.MoveToNextEntry())
                    {
                        if (!reader.Entry.IsDirectory)
                        {
                            // retry per plik
                            var attempts = 3;
                            for (int i = 0; i < attempts; i++)
                            {
                                try
                                {
                                    reader.WriteEntryToDirectory(targetDir, new ExtractionOptions
                                    {
                                        ExtractFullPath = true,
                                        Overwrite = true
                                    });
                                    break;
                                }
                                catch (IOException)
                                {
                                    if (i == attempts - 1) throw;
                                    Thread.Sleep(200);
                                }
                            }
                        }
                    }
                }
            });

            // Po rozpakowaniu wczytaj rozpakowany katalog
            Application.Current.Dispatcher.Invoke(() =>
            {
                LoadDirectory(new Plik(targetDir, Path.GetFileName(targetDir)));
            });
        }

        // Wczytywanie dowolnego istniejącego folderu do wyświetlenia w nawigacji
        public void LoadDirectory(Plik paczka)
        {
            PlikiWPaczce.Clear();
            Dokumenty.Clear();
            Sprawy.Clear();
            Metadane.Clear();
            SelectedMetadata.Clear();

            tempFolderCollection = null;

            if (bgGetFilesBackgroundWorker.IsBusy)
                bgGetFilesBackgroundWorker.CancelAsync();

            bgGetFilesBackgroundWorker.RunWorkerAsync(paczka);
        }

        // Wczytuje plik metadanych odpowiadający aktualnie wybranemu dokumentowi.
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

            // Najpierw spróbuj bezpośrednio w folderze {SciezkaAktywnejPaczki}\metadane
            string? root = SciezkaAktywnejPaczki;
            string? candidatePath = null;
            if (!string.IsNullOrEmpty(root))
            {
                var direct = Path.Combine(root, PathHelpers.GetFolderName(FileCategory.Metadane), metadataFileName);
                if (File.Exists(direct))
                {
                    candidatePath = direct;
                }
            }

            // fallback: szukaj w liście PlikiWPaczce
            if (candidatePath == null)
            {
                candidatePath = PathHelpers.FindMetadataInPackage(PlikiWPaczce, metadataFileName);
            }

            // ustaw nazwę pliku metadanych (jeśli znaleziono) — uaktualnia nagłówek bez convertera
            SelectedMetadataDisplayName = string.IsNullOrEmpty(candidatePath) ? string.Empty : Path.GetFileName(candidatePath);

            if (string.IsNullOrEmpty(candidatePath) || !File.Exists(candidatePath))
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Info", Value = $"Brak pliku metadanych: {metadataFileName}" });
                return;
            }

            try
            {
                var entries = MetadataLoader.LoadMetadataEntries(candidatePath);
                foreach (var e in entries)
                {
                    SelectedMetadata.Add(e);
                }
            }
            catch (System.Exception ex)
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Błąd", Value = ex.Message });
            }

            OnPropertyChanged(nameof(SelectedMetadata));
        }

        // Wczytuje plik metadanych wybrany w kolekcji Metadane.
        // Ustawia SelectedMetadata (prawe okno) oraz próbuje znaleźć odpowiadający dokument
        // (ta sama nazwa bez końcowego ".xml") i ustawić go jako SelectedPlik / SelectedFilePath (lewe okno).
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

            // Parsowanie XML metadanych
            try
            {
                var entries = MetadataLoader.LoadMetadataEntries(metaFilePath);
                foreach (var e in entries)
                {
                    SelectedMetadata.Add(e);
                }
            }
            catch (Exception ex)
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Błąd", Value = ex.Message });
            }

            // Ustaw nazwę metadanych w nagłówku
            SelectedMetadataDisplayName = Path.GetFileName(metaFilePath);

            // Znajdź odpowiadający dokument — usuń tylko ostatnie ".xml"
            var metaFileName = Path.GetFileName(metaFilePath) ?? string.Empty;
            var docFileName = metaFileName.EndsWith(".xml", StringComparison.OrdinalIgnoreCase)
                ? metaFileName.Substring(0, metaFileName.Length - 4)
                : metaFileName;

            // Spróbuj znaleźć w liście plików paczki
            var foundDoc = PathHelpers.FindDocumentInPackage(PlikiWPaczce, docFileName);

            // Jeżeli nie znaleziono, spróbuj w {SciezkaAktywnejPaczki}\dokumenty\docFileName
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
                try
                {
                    SelectedDocumentFile = foundDoc;
                    SelectedFilePath = foundDoc.Sciezka;
                }
                finally
                {
                }
            }
            else
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Info", Value = $"Nie znaleziono dokumentu: {docFileName}" });
            }

            OnPropertyChanged(nameof(SelectedMetadata));
        }

        private void SelectView(object? parameter)
        {
            string? name = null;
            if (parameter is SubMenu s) name = s.Name;
            if (string.IsNullOrWhiteSpace(name)) return;

            name = name.Trim();
            SelectedViewName = name;

            if (_viewIndexes.TryGetValue(name, out var index))
            {
                ActiveTabIndex = index;
            }
            else
            {
                // fallback na domyślny widok
                ActiveTabIndex = 1;
                SelectedViewName = ViewNames.ElementAtOrDefault(ActiveTabIndex);
            }
        }

        #endregion

        public void BuildNodes()
        {
            Nodes.Clear();

            // Tworzymy węzły spraw — klucz normalizowany (bez rozszerzenia, lower, trim)
            foreach (var sprawa in Sprawy)
            {
                var fileName = Path.GetFileName(sprawa.Tytul ?? Path.GetFileName(sprawa.Sciezka) ?? string.Empty);
                var fallbackKey = Path.GetFileNameWithoutExtension(fileName)?.Trim() ?? string.Empty;

                // Jeśli plik sprawy został sparsowany do Metadata i ma Grupowanie — użyjemy tego (może zawierać ścieżkę/rozszerzenie)
                string sprawaKeyRaw = null;
                if (sprawa is Metadata ms && !string.IsNullOrWhiteSpace(ms.Grupowanie))
                {
                    sprawaKeyRaw = Path.GetFileName(ms.Grupowanie);
                }

                var sprawaKey = !string.IsNullOrWhiteSpace(sprawaKeyRaw)
                    ? Path.GetFileNameWithoutExtension(sprawaKeyRaw).Trim()
                    : fallbackKey;

                Nodes.Add(new SprawaNode(sprawa, sprawaKey));
            }

            // Przypisanie dokumentów do węzłów — porównanie normalizowanych kluczy (bez rozszerzeń, lower)
            foreach (var doc in Dokumenty)
            {
                var docFileName = Path.GetFileName(doc.Tytul ?? Path.GetFileName(doc.Sciezka) ?? string.Empty);
                if (string.IsNullOrEmpty(docFileName)) continue;

                var expectedMetaFileName = docFileName + ".xml";

                var candidateMeta = Metadane.FirstOrDefault(m =>
                    string.Equals(Path.GetFileName(m.Sciezka), expectedMetaFileName, StringComparison.OrdinalIgnoreCase))
                    ?? PlikiWPaczce.FirstOrDefault(m =>
                    string.Equals(Path.GetFileName(m.Sciezka), expectedMetaFileName, StringComparison.OrdinalIgnoreCase));

                if (candidateMeta == null)
                    continue;

                // Pobierz wartość grupowania z obiektu Metadata (jeśli dostępne)
                string grupRaw = null;
                if (candidateMeta is Metadata m && !string.IsNullOrWhiteSpace(m.Grupowanie))
                {
                    grupRaw = m.Grupowanie;
                }

                if (string.IsNullOrWhiteSpace(grupRaw))
                    continue;

                var grupNormalized = Path.GetFileNameWithoutExtension(grupRaw).Trim().ToLowerInvariant();

                // Szukamy węzła porównując z normalizowanym kluczem węzła
                var targetNode = Nodes.FirstOrDefault(n =>
                    string.Equals(Path.GetFileNameWithoutExtension(n.GrupowanieKey)?.Trim().ToLowerInvariant(), grupNormalized, StringComparison.OrdinalIgnoreCase));

                if (targetNode != null)
                {
                    targetNode.Documents.Add(doc);
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"BuildNodes: brak dopasowania dla dokumentu '{docFileName}' grup='{grupRaw}' (norm='{grupNormalized}'). CandidateMeta='{candidateMeta.Sciezka}'");
                }
            }

            OnPropertyChanged(nameof(Nodes));
        }

        #region BackgroundWorker - pobieranie listy plików

        private void BgGetFilesBackgroundWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            var file = e.Argument as Plik;
            if (file == null) return;

            List<string> entries = new List<string>();
            try
            {
                if (Directory.Exists(file.Sciezka))
                {
                    if (CzyRekursywnie)
                    {
                        // Rekursywne przeglądanie (pliki i katalogi)
                        entries.AddRange(Directory.EnumerateFileSystemEntries(file.Sciezka, "*", SearchOption.AllDirectories));
                    }
                    else
                    {
                        // Tylko pierwszy poziom
                        entries.AddRange(Directory.GetDirectories(file.Sciezka));
                        entries.AddRange(Directory.GetFiles(file.Sciezka));
                    }
                }
            }
            catch { }

            tempFolderCollection = new ReadOnlyCollection<string>(entries);

            foreach (var entry in tempFolderCollection)
            {
                if (bgGetFilesBackgroundWorker.CancellationPending)
                {
                    e.Cancel = true;
                    return;
                }
                bgGetFilesBackgroundWorker.ReportProgress(1, entry);
            }

            SciezkaAktywnejPaczki = file.Sciezka;

            OnPropertyChanged(nameof(SciezkaAktywnejPaczki));
        }

        private void BgGetFilesBackgroundWorker_ProgressChanged(object? sender, ProgressChangedEventArgs e)
        {
            var filePath = e.UserState?.ToString() ?? string.Empty;
            var fileName = Path.GetFileName(filePath);

            // Domyślny obiekt Plik
            Plik plik = new Plik(filePath, fileName)
            {
                CzyUkryty = IsFileHidden(filePath),
                CzyFolder = IsDirectory(filePath),
                Rozszerzenie = GetFileExtension(filePath)
            };

            // określ kategorię przy pomocy jednej funkcji
            var category = PathHelpers.GetFileCategoryFromPath(filePath);

            // Jeśli plik to metadane — spróbuj sparsować go do obiektu Metadata (z pola Grupowanie)
            if (category == FileCategory.Metadane)
            {
                try
                {
                    var meta = MetadataLoader.ParseMetadaneMetadata(filePath);
                    if (meta != null)
                    {
                        // zachowaj atrybuty pliku i użyj obiektu Metadata zamiast zwykłego Plik
                        meta.CzyUkryty = plik.CzyUkryty;
                        meta.CzyFolder = plik.CzyFolder;
                        meta.Rozszerzenie = plik.Rozszerzenie;
                        meta.Category = FileCategory.Metadane;
                        plik = meta;
                    }
                }
                catch
                {
                    // w razie błędu zostanie użyty zwykły Plik (bez Grupowanie)
                }
            }
            else if (category == FileCategory.Sprawy)
            {
                // opcjonalnie: parsuj pliki sprawy do Metadata, żeby mieć dodatkowe pola (DataOd/DataDo)
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
                    // fallback do zwykłego Plik
                }
            }

            PlikiWPaczce.Add(plik);
            OnPropertyChanged(nameof(PlikiWPaczce));

            switch (category)
            {
                case FileCategory.Dokumenty:
                    Dokumenty.Add(plik);
                    OnPropertyChanged(nameof(Dokumenty));
                    break;
                case FileCategory.Sprawy:
                    Sprawy.Add(plik);
                    OnPropertyChanged(nameof(Sprawy));
                    break;
                case FileCategory.Metadane:
                    Metadane.Add(plik);
                    OnPropertyChanged(nameof(Metadane));
                    break;
                default:
                    break;
            }
        }

        private void BgGetFilesBackgroundWorker_RunWorkerCompleted(object? sender, RunWorkerCompletedEventArgs e)
        {
            // sortowanie, odświeżenie widoku


            BuildNodes();

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
                if (string.IsNullOrEmpty(ext))
                    return null;
                return ext.TrimStart('.').ToLowerInvariant();
            }
            catch { return null; }
        }

        // Ustawia SelectedDocumentDisplayName
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

        // Ustawia SelectedMetadataDisplayName
        private void UpdateSelectedMetadataDisplayName()
        {
            if (_selectedMetadataFile == null)
            {
                SelectedMetadataDisplayName = string.Empty;
                return;
            }

            var tytul = _selectedMetadataFile.Tytul;
            var sciezka = _selected_metadata_filePath();
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

        private string? _selected_metadata_filePath()
        {
            return _selectedMetadataFile?.Sciezka;
        }

        #endregion

        #region Commands

        private ICommand _openSettingsCommand;
        public ICommand openSettingsCommand
        {
            get
            {
                return _openSettingsCommand ??
                    (_openSettingsCommand = new Command(() => { }));
            }
        }

        #endregion
    }
}