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
            private set
            {
                if (SetProperty(ref _activePackagePath, value))
                {
                    OnPropertyChanged(nameof(IsPackageLoaded));
                }
            }
        }

        public bool IsPackageLoaded => !string.IsNullOrEmpty(_activePackagePath) && _activePackagePath != @".\temp";

        private string? _packageName;
        public string? PackageName
        {
            get => _packageName;
            set
            {
                if (_packageName != value)
                {
                    _packageName = value;
                    OnPropertyChanged();
                }
            }
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
        public ICommand SortByNameCommand { get; private set; }
        public ICommand SortByDateAscCommand { get; private set; }
        public ICommand SortByDateDescCommand { get; private set; }

        private bool _sortNameAscending = true;

        // Śledzenie aktywnego sortowania dla każdej zakładki
        private SortType _dokumentySortType = SortType.None;
        private SortType _sprawySortType = SortType.None;

        /// <summary>
        /// Aktualny typ sortowania dla aktywnej zakładki.
        /// </summary>
        public SortType ActiveSortType
        {
            get => ActiveTabIndex == 0 ? _dokumentySortType : (ActiveTabIndex == 1 ? _sprawySortType : SortType.None);
        }

        /// <summary>
        /// Tekst informujący o aktywnym sortowaniu.
        /// </summary>
        public string SortingInfoText
        {
            get
            {
                var sortType = ActiveSortType;
                return sortType switch
                {
                    SortType.NameAsc => "Sortowanie: A → Z",
                    SortType.NameDesc => "Sortowanie: Z → A",
                    SortType.DateAsc => "Sortowanie: wcześniej → później",
                    SortType.DateDesc => "Sortowanie: później → wcześniej",
                    _ => string.Empty
                };
            }
        }

        /// <summary>
        /// Czy wyświetlać informację o sortowaniu.
        /// </summary>
        public bool IsSortingActive => ActiveSortType != SortType.None && (ActiveTabIndex == 0 || ActiveTabIndex == 1);

        // Właściwości do bindowania stanu przycisków
        public bool IsSortByNameActive => ActiveSortType == SortType.NameAsc || ActiveSortType == SortType.NameDesc;
        public bool IsSortByDateAscActive => ActiveSortType == SortType.DateAsc;
        public bool IsSortByDateDescActive => ActiveSortType == SortType.DateDesc;

        private int _activeTabIndex = 1; //zakładka sprawy domyślnie
        public int ActiveTabIndex
        {
            get => _activeTabIndex;
            set
            {
                if (SetProperty(ref _activeTabIndex, value))
                {
                    // Powiadom o zmianie stanu sortowania przy zmianie zakładki
                    NotifySortingChanged();
                }
            }
        }

        private string? _selectedViewName;
        public string? SelectedViewName
        {
            get => _selectedViewName;
            set => SetProperty(ref _selectedViewName, value);
        }

        public IReadOnlyList<string>? ViewNames { get; private set; }
        private Dictionary<string, int>? _viewIndexes;

        private Plik? _selectedDocumentFile;
        public Plik? SelectedDocumentFile
        {
            get => _selectedDocumentFile;
            set
            {
                var changed = SetProperty(ref _selectedDocumentFile, value);

                if (value != null)
                {
                    _selectedFilePath = null;
                    OnPropertyChanged(nameof(SelectedFilePath));

                    _selectedFilePath = value.Sciezka;
                    OnPropertyChanged(nameof(SelectedFilePath));

                    UpdateSelectedDocumentDisplayName();

                    _ = LoadSelectedDocumentFile();
                }
                else if (changed)
                {
                    _selectedFilePath = null;
                    OnPropertyChanged(nameof(SelectedFilePath));
                    UpdateSelectedDocumentDisplayName();
                }
            }
        }

        private Plik? _selectedMetadataFile;
        public Plik? SelectedMetadataFile
        {
            get => _selectedMetadataFile;
            set
            {
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

        private SprawaNode? _selectedSprawaNode;
        public SprawaNode? SelectedSprawaNode
        {
            get => _selectedSprawaNode;
            set
            {
                var changed = SetProperty(ref _selectedSprawaNode, value);

                if (value != null)
                {
                    _selectedDocumentFile = null;
                    OnPropertyChanged(nameof(SelectedDocumentFile));

                    _selectedFilePath = "about:blank";
                    OnPropertyChanged(nameof(SelectedFilePath));

                    SelectedDocumentDisplayName = string.Empty;

                    LoadSelectedSprawaMetadata();
                }
                else if (changed)
                {
                    _selectedFilePath = null;
                    OnPropertyChanged(nameof(SelectedFilePath));
                    SelectedDocumentDisplayName = string.Empty;
                }
            }
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
            SortByNameCommand = new RelayCommand(_ => SortByName());
            SortByDateAscCommand = new RelayCommand(_ => SortByDateAscending());
            SortByDateDescCommand = new RelayCommand(_ => SortByDateDescending());
        }

        #endregion

        #region Sortowanie

        /// <summary>
        /// Sortuje aktualną kolekcję alfabetycznie po nazwie. Przełącza między A-Z / Z-A.
        /// </summary>
        public void SortByName()
        {
            if (ActiveTabIndex == 0) // Dokumenty
            {
                var sorted = _sortNameAscending
                    ? Dokumenty.OrderBy(d => GetDisplayName(d), StringComparer.OrdinalIgnoreCase).ToList()
                    : Dokumenty.OrderByDescending(d => GetDisplayName(d), StringComparer.OrdinalIgnoreCase).ToList();
                ApplySortedCollection(Dokumenty, sorted);
                _dokumentySortType = _sortNameAscending ? SortType.NameAsc : SortType.NameDesc;
            }
            else if (ActiveTabIndex == 1) // Sprawy
            {
                var sorted = _sortNameAscending
                    ? Sprawy.OrderBy(s => GetDisplayName(s), StringComparer.OrdinalIgnoreCase).ToList()
                    : Sprawy.OrderByDescending(s => GetDisplayName(s), StringComparer.OrdinalIgnoreCase).ToList();
                ApplySortedCollection(Sprawy, sorted);
                BuildNodes();
                
                // Sortuj dokumenty wewnątrz każdej sprawy
                SortDocumentsInNodes(
                    docs => _sortNameAscending 
                        ? docs.OrderByDescending(d => GetDisplayName(d), StringComparer.OrdinalIgnoreCase).ToList()
                        : docs.OrderBy(d => GetDisplayName(d), StringComparer.OrdinalIgnoreCase).ToList());
                
                _sprawySortType = _sortNameAscending ? SortType.NameAsc : SortType.NameDesc;
            }
            _sortNameAscending = !_sortNameAscending;
            NotifySortingChanged();
        }

        /// <summary>
        /// Sortuje aktualną kolekcję od najwcześniejszej do najpóźniejszej daty.
        /// </summary>
        public void SortByDateAscending()
        {
            if (ActiveTabIndex == 0) // Dokumenty
            {
                var sorted = Dokumenty.OrderBy(d => GetDocumentDate(d) ?? DateTime.MaxValue).ToList();
                ApplySortedCollection(Dokumenty, sorted);
                _dokumentySortType = SortType.DateAsc;
            }
            else if (ActiveTabIndex == 1) // Sprawy
            {
                var sorted = Sprawy.OrderBy(s => GetSprawaDate(s) ?? DateTime.MaxValue).ToList();
                ApplySortedCollection(Sprawy, sorted);
                BuildNodes();
                
                // Sortuj dokumenty wewnątrz każdej sprawy
                SortDocumentsInNodes(
                    docs => docs.OrderBy(d => GetDocumentDate(d) ?? DateTime.MaxValue).ToList());
                
                _sprawySortType = SortType.DateAsc;
            }
            NotifySortingChanged();
        }

        /// <summary>
        /// Sortuje aktualną kolekcję od najpóźniejszej do najwcześniejszej daty.
        /// </summary>
        public void SortByDateDescending()
        {
            if (ActiveTabIndex == 0) // Dokumenty
            {
                var sorted = Dokumenty.OrderByDescending(d => GetDocumentDate(d) ?? DateTime.MinValue).ToList();
                ApplySortedCollection(Dokumenty, sorted);
                _dokumentySortType = SortType.DateDesc;
            }
            else if (ActiveTabIndex == 1) // Sprawy
            {
                var sorted = Sprawy.OrderByDescending(s => GetSprawaDate(s) ?? DateTime.MinValue).ToList();
                ApplySortedCollection(Sprawy, sorted);
                BuildNodes();
                
                // Sortuj dokumenty wewnątrz każdej sprawy
                SortDocumentsInNodes(
                    docs => docs.OrderByDescending(d => GetDocumentDate(d) ?? DateTime.MinValue).ToList());
                
                _sprawySortType = SortType.DateDesc;
            }
            NotifySortingChanged();
        }

        /// <summary>
        /// Sortuje dokumenty wewnątrz każdego węzła sprawy według podanej funkcji sortowania.
        /// </summary>
        private void SortDocumentsInNodes(Func<ObservableCollection<Plik>, List<Plik>> sortFunc)
        {
            Application.Current.Dispatcher.Invoke(() =>
            {
                foreach (var node in Nodes)
                {
                    if (node.Documents.Count <= 1) continue;
                    
                    var sortedDocs = sortFunc(node.Documents);
                    node.Documents.Clear();
                    foreach (var doc in sortedDocs)
                    {
                        node.Documents.Add(doc);
                    }
                }
            });
        }

        /// <summary>
        /// Pomocnicza metoda do aktualizacji ObservableCollection po sortowaniu.
        /// </summary>
        private static void ApplySortedCollection(ObservableCollection<Plik> collection, List<Plik> sorted)
        {
            Application.Current.Dispatcher.Invoke(() =>
            {
                collection.Clear();
                foreach (var item in sorted)
                {
                    collection.Add(item);
                }
            });
        }

        /// <summary>
        /// Pobiera nazwę wyświetlaną pliku (Tytul lub nazwa z ścieżki).
        /// </summary>
        private static string GetDisplayName(Plik plik)
        {
            return Path.GetFileName(plik.Sciezka) ?? string.Empty;
        }

        /// <summary>
        /// Pobiera datę dokumentu z jego metadanych.
        /// </summary>
        private DateTime? GetDocumentDate(Plik doc)
        {
            if (doc is Metadata meta)
                return meta.Data;

            var docFileName = Path.GetFileName(doc.Sciezka);
            if (string.IsNullOrEmpty(docFileName)) return null;

            var metadataFileName = docFileName + ".xml";
            var metaFile = Metadane.FirstOrDefault(m =>
                string.Equals(Path.GetFileName(m.Sciezka), metadataFileName, StringComparison.OrdinalIgnoreCase));

            return (metaFile as Metadata)?.Data;
        }

        /// <summary>
        /// Pobiera datę sprawy (DataOd lub DataDo).
        /// </summary>
        private static DateTime? GetSprawaDate(Plik sprawa)
        {
            if (sprawa is Metadata meta)
                return meta.DataOd ?? meta.DataDo ?? meta.Data;

            return null;
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

            // ZABEZPIECZENIE 1: Walidacja archiwum przed rozpakowaniem
            var archiveValidation = SecurityValidator.ValidateFile(archivePath);
            if (!archiveValidation.IsValid)
            {
                throw new Exception($"Walidacja archiwum nie powiodła się: {archiveValidation.GetErrorMessage()}");
            }

            // Pobierz rozmiar archiwum do walidacji zip bomb
            var archiveFileInfo = new FileInfo(archivePath);
            var compressedSize = archiveFileInfo.Length;

            string targetDir = Helpers.TempDirectoryManager.CreateRunTempDir();

            var extractionResult = await Task.Run(() =>
            {
                var stats = new ExtractionStats();
                long totalUncompressedSize = 0;
                
                using Stream fileStream = File.Open(archivePath, FileMode.Open, FileAccess.Read, FileShare.Read);
                using var reader = ReaderFactory.Open(fileStream);
                
                while (reader.MoveToNextEntry())
                {
                    cancellationToken.ThrowIfCancellationRequested();
                    
                    if (reader.Entry.IsDirectory)
                        continue;

                    var entryName = reader.Entry.Key;
                    var entrySize = reader.Entry.Size;
                    stats.TotalFiles++;

                    // ZABEZPIECZENIE: Ochrona przed zip bomb - sprawdź liczbę plików
                    if (stats.TotalFiles > SecurityValidator.MaxFilesInArchive)
                    {
                        stats.SecurityIssues.Add($"Przekroczono limit plików ({SecurityValidator.MaxFilesInArchive})");
                        break;
                    }

                    // ZABEZPIECZENIE: Ochrona przed zip bomb - sprawdź łączny rozmiar
                    totalUncompressedSize += entrySize;
                    if (totalUncompressedSize > SecurityValidator.MaxTotalUncompressedSize)
                    {
                        stats.SecurityIssues.Add($"Przekroczono limit rozmiaru ({SecurityValidator.MaxTotalUncompressedSize / (1024 * 1024)} MB)");
                        break;
                    }

                    // ZABEZPIECZENIE: Ochrona przed zip bomb - sprawdź współczynnik kompresji wpisu
                    if (reader.Entry.CompressedSize > 0 && 
                        !SecurityValidator.ValidateArchiveEntry(reader.Entry.CompressedSize, entrySize))
                    {
                        stats.SkippedFiles++;
                        stats.SecurityIssues.Add($"Podejrzany współczynnik kompresji: {entryName}");
                        continue;
                    }

                    // Walidacja ścieżki (Zip Slip)
                    if (!SecurityValidator.ValidatePathTraversal(targetDir, entryName))
                    {
                        stats.SkippedFiles++;
                        stats.SecurityIssues.Add($"Zip Slip: {entryName}");
                        continue; // Pomiń niebezpieczny wpis
                    }

                    // ZABEZPIECZENIE 3: Sprawdź rozszerzenie przed wypakowaniem
                    var fileName = Path.GetFileName(entryName);
                    if (SecurityValidator.IsExtensionBlacklisted(fileName))
                    {
                        stats.SkippedFiles++;
                        stats.SecurityIssues.Add($"Czarna lista: {fileName}");
                        continue; // Pomiń plik z czarnej listy
                    }

                    // Wypakuj plik
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
                            
                            stats.ExtractedFiles++;

                            // ZABEZPIECZENIE 4: Walidacja magic bytes po rozpakowaniu
                            var extractedPath = Path.Combine(targetDir, entryName);
                            if (File.Exists(extractedPath))
                            {
                                if (!SecurityValidator.ValidateMagicBytes(extractedPath))
                                {
                                    stats.SecurityIssues.Add($"Niepoprawne magic bytes: {fileName}");
                                    // Można usunąć plik lub pozostawić z ostrzeżeniem
                                }
                            }
                            
                            break;
                        }
                        catch (IOException)
                        {
                            if (i == attempts - 1) throw;
                            Task.Delay(200, cancellationToken).Wait(cancellationToken);
                        }
                    }
                }

                // Końcowa walidacja zip bomb
                var zipBombResult = SecurityValidator.ValidateArchiveForZipBomb(
                    compressedSize, totalUncompressedSize, stats.TotalFiles);
                
                if (!zipBombResult.IsValid)
                {
                    foreach (var error in zipBombResult.Errors)
                    {
                        stats.SecurityIssues.Add(error);
                    }
                }

                return stats;
            }, cancellationToken);

            if (extractionResult.SecurityIssues.Any())
            {
                var message = $"Wypakowano archiwum z ostrzeżeniami:\n" +
                             $"- Wypakowane pliki: {extractionResult.ExtractedFiles}/{extractionResult.TotalFiles}\n" +
                             $"- Pominięte pliki: {extractionResult.SkippedFiles}\n\n" +
                             $"Problemy bezpieczeństwa:\n{string.Join("\n", extractionResult.SecurityIssues.Take(10))}";
                
                Application.Current.Dispatcher.Invoke(() =>
                {
                    MessageBox.Show(message, "Ostrzeżenia bezpieczeństwa", MessageBoxButton.OK, MessageBoxImage.Warning);
                });
            }

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

                foreach (var entry in tempFolderCollection)
                {
                    _scanFolders.Token.ThrowIfCancellationRequested();
                    
                    // ZABEZPIECZENIE 5: Waliduj każdy plik przed dodaniem
                    if (SecurityValidator.IsExtensionAllowed(entry))
                    {
                        AddEntryToCollections(entry);
                    }
                }

                ActivePackagePath = paczka.Sciezka;
                BuildNodes();
            }
            catch (OperationCanceledException)
            {
                // anulowano skanowanie
            }
            catch (System.Exception ex)
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
                    // ZABEZPIECZENIE 6: Użyj bezpiecznego ładowania XML
                    var htmlContent = await Task.Run(() => XslTransformer.TransformXmlToHtml(candidatePath, xslPath));

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
            catch (System.Exception ex)
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
                    var htmlContent = XslTransformer.TransformXmlToHtml(metaFilePath, xslPath);
                    MetadataHtmlContent = htmlContent;
                }
                else
                {
                    // Fallback: załaduj jako proste pary klucz-wartość
                    var entries = MetadataLoader.LoadMetadataEntries(metaFilePath);
                    foreach (var e in entries) SelectedMetadata.Add(e);
                }
            }
            catch (System.Exception ex)
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
            var xslPath = Path.Combine(appDir, "Resources/eADM_styl.xsl");

            if (File.Exists(xslPath))
                return xslPath;

            // Alternatywnie szukaj w katalogu roboczy
            xslPath = Path.Combine(Directory.GetCurrentDirectory(), "Resources/eADM_styl.xsl");
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

        private void LoadSelectedSprawaMetadata()
        {
            SelectedMetadata.Clear();
            MetadataHtmlContent = string.Empty;

            if (_selectedSprawaNode?.Sprawa == null)
            {
                SelectedMetadataDisplayName = string.Empty;
                return;
            }

            var sprawaFile = _selectedSprawaNode.Sprawa;
            var metaFilePath = sprawaFile.Sciezka;

            if (string.IsNullOrEmpty(metaFilePath) || !File.Exists(metaFilePath))
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Info", Value = "Plik metadanych sprawy niedostępny." });
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
                    var htmlContent = XslTransformer.TransformXmlToHtml(metaFilePath, xslPath);
                    MetadataHtmlContent = htmlContent;
                }
                else
                {
                    // Fallback: załaduj jako proste pary klucz-wartość
                    var entries = MetadataLoader.LoadMetadataEntries(metaFilePath);
                    foreach (var e in entries) SelectedMetadata.Add(e);
                }
            }
            catch (System.Exception ex)
            {
                SelectedMetadata.Add(new MetadataEntry { Name = "Błąd", Value = ex.Message });
            }

            SelectedMetadataDisplayName = Path.GetFileName(metaFilePath);
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

        #region Klasa pomocnicza dla statystyk

        private class ExtractionStats
        {
            public int TotalFiles { get; set; }
            public int ExtractedFiles { get; set; }
            public int SkippedFiles { get; set; }
            public List<string> SecurityIssues { get; } = new();
        }

        #endregion

        #region Typy sortowania

        public enum SortType
        {
            None,
            NameAsc,
            NameDesc,
            DateAsc,
            DateDesc
        }

        /// <summary>
        /// Powiadamia UI o zmianie stanu sortowania.
        /// </summary>
        private void NotifySortingChanged()
        {
            OnPropertyChanged(nameof(ActiveSortType));
            OnPropertyChanged(nameof(SortingInfoText));
            OnPropertyChanged(nameof(IsSortingActive));
            OnPropertyChanged(nameof(IsSortByNameActive));
            OnPropertyChanged(nameof(IsSortByDateAscActive));
            OnPropertyChanged(nameof(IsSortByDateDescActive));
        }

        #endregion
    }
}