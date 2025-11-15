using eAMDwizualizator.Commands;
using eAMDwizualizator.Models;
using SharpCompress.Common;
using SharpCompress.Readers;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.IO;
using System.Runtime.CompilerServices;
using System.Windows;
using System.Windows.Input;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace eAMDwizualizator.ViewModels
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
        private bool _czyRekursywnie = false;
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
        public ObservableCollection<Plik> PlikiWPaczce { get; set; } = new ObservableCollection<Plik>();

        public ReadOnlyCollection<string>? tempFolderCollection;

        private readonly BackgroundWorker bgGetFilesBackgroundWorker = new BackgroundWorker()
        {
            WorkerReportsProgress = true,
            WorkerSupportsCancellation = true
        };

        internal static readonly List<string> ImageExtensions = new List<string> { "jpg", "jpeg", "png", "bmp", "tiff" };
        internal static readonly List<string> VideoExtensions = new List<string> { "mp4", "avi", "m4v", "wmv", "webm", "mov" };
        internal static readonly List<string> PaczkaEadmRozszerzenia = new List<string> { "tar", "zip", "tar.gz" };

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
            }
        }

        // Właściwości do przeglądania dokumentu pdf
        private Plik? _selectedPlik;
        public Plik? SelectedPlik
        {
            get => _selectedPlik;
            set
            {
                if (_selectedPlik == value) return;
                _selectedPlik = value;
                OnPropertyChanged();
                // aktualizuj ścieżkę pliku do łatwego bindowania w widoku
                SelectedFilePath = _selectedPlik?.Sciezka;
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

        #endregion

        #region Konstruktor

        public PlikViewModel()
        {
            // Domyślna lokalizacja
            SciezkaAktywnejPaczki = @".\temp";

            // USTAWIANIE nazw widoków  
            ViewNames = new List<string>
            {
                "Wszystkie pliki",
                "Dokumenty",
                "Sprawy"
            }.AsReadOnly();

            _viewIndexes = ViewNames
                .Select((name, idx) => new { name, idx })
                .ToDictionary(x => x.name, x => x.idx, System.StringComparer.OrdinalIgnoreCase);

            // USTAWIANIE domyślnego widoku
            ActiveTabIndex = 1;
            SelectedViewName = ViewNames.ElementAtOrDefault(ActiveTabIndex);

            // polecenie wybierające widok
            SelectViewCommand = new RelayCommand(param => SelectView(param));

            // listowanie plików
            bgGetFilesBackgroundWorker.DoWork += BgGetFilesBackgroundWorker_DoWork;
            bgGetFilesBackgroundWorker.ProgressChanged += BgGetFilesBackgroundWorker_ProgressChanged;
            bgGetFilesBackgroundWorker.RunWorkerCompleted += BgGetFilesBackgroundWorker_RunWorkerCompleted;

            // żeby usunąć poprzednią paczkęprzed otwarciem
            //if (Directory.Exists(SciezkaAktywnejPaczki))
            //    LoadDirectory(new Plik(SciezkaAktywnejPaczki, Path.GetFileName(SciezkaAktywnejPaczki)));
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

            string targetDir = Path.Combine(Environment.CurrentDirectory, "temp");

            try
            {
                if (Directory.Exists(targetDir))
                    Directory.Delete(targetDir, true);
            }
            catch
            {
                // ignoruj błędy
            }

            Directory.CreateDirectory(targetDir);

            await Task.Run(() =>
            {
                using (Stream fileStream = File.OpenRead(archivePath))
                using (var reader = ReaderFactory.Open(fileStream))
                {
                    while (reader.MoveToNextEntry())
                    {
                        if (!reader.Entry.IsDirectory)
                        {
                            reader.WriteEntryToDirectory(targetDir, new ExtractionOptions()
                            {
                                ExtractFullPath = true,
                                Overwrite = true
                            });
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

            tempFolderCollection = null;

            if (bgGetFilesBackgroundWorker.IsBusy)
                bgGetFilesBackgroundWorker.CancelAsync();

            bgGetFilesBackgroundWorker.RunWorkerAsync(paczka);
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
            var plik = new Plik(filePath, fileName)
            {
                CzyUkryty = IsFileHidden(filePath),
                CzyFolder = IsDirectory(filePath),
                Rozszerzenie = GetFileExtension(filePath)
            };

            var ext = plik.Rozszerzenie ?? string.Empty;
            plik.JestObrazem = ImageExtensions.Contains(ext);
            plik.JestVideo = VideoExtensions.Contains(ext);

            PlikiWPaczce.Add(plik);
            OnPropertyChanged(nameof(PlikiWPaczce));

            if(Path.GetFileName(Path.GetDirectoryName(filePath).ToLower()) == ("dokumenty"))
            {
                Dokumenty.Add(plik);
                OnPropertyChanged(nameof(Dokumenty));
            }
            else if(Path.GetFileName(Path.GetDirectoryName(filePath).ToLower()) == "sprawy")
            {
                Sprawy.Add(plik);
                OnPropertyChanged(nameof(Sprawy));

                // dorobić drzewo z metadanymi i dokumentami
            }
            else if (Path.GetFileName(Path.GetDirectoryName(filePath).ToLower()) == "metadane")
            {
                // bez plików metadanych -> wybór przez wybór dokumentu
            }
        }

        private void BgGetFilesBackgroundWorker_RunWorkerCompleted(object? sender, RunWorkerCompletedEventArgs e)
        {
            // sortowanie, odświeżenie widoku
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