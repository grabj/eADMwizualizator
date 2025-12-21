using eADMwizualizator.ViewModels;
using eADMwizualizator.Helpers;
using eADMwizualizator.Models;
using Microsoft.Win32;
using System;
using System.ComponentModel;
using System.IO;
using System.Windows;

namespace eADMwizualizator
{
    public partial class MainWindow : Window
    {
        private static string Tytul = "Wizualizator paczki eADM";
 
        private const double DefaultFontSize = 13.0;
        private const double MinFontSize = 10.0;
        private const double MaxFontSize = 22.0;
        
        // Próg szerokości po którym ukrywamy tekst w zakładkach (w pikselach)
        private const double TabTextVisibilityThreshold = 220.0; // Zmień szerokość progu

        public MainWindow()
        {
            InitializeComponent();
            this.Title = Tytul;

            // Subskrybuj zmiany w ViewModelu
            if (this.DataContext is PlikViewModel vm)
            {
                vm.PropertyChanged += ViewModel_PropertyChanged;
            }
            
            // Subskrybuj zmiany rozmiaru okna
            this.SizeChanged += MainWindow_SizeChanged;
            this.Loaded += MainWindow_Loaded;
        }

        private void MainWindow_Loaded(object sender, RoutedEventArgs e)
        {
            // Sprawdź widoczność tekstu w zakładkach przy starcie
            UpdateTabTextVisibility();
            
            // WAŻNE: Nasłuchuj na zmiany rozmiaru TabControl
            var tabControl = this.FindName("NavigationTabControl") as System.Windows.Controls.TabControl;
            if (tabControl != null)
            {
                tabControl.SizeChanged += TabControl_SizeChanged;
            }
        }

        private void MainWindow_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            // Aktualizuj widoczność tekstu w zakładkach przy zmianie rozmiaru okna
            UpdateTabTextVisibility();
        }

        // DODAJ: Nasłuchuj zmian rozmiaru TabControl (gdy GridSplitter się porusza)
        private void TabControl_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            UpdateTabTextVisibility();
        }

        private void ViewModel_PropertyChanged(object? sender, PropertyChangedEventArgs e)
        {
            if (e.PropertyName == nameof(PlikViewModel.MetadataHtmlContent))
            {
                if (sender is PlikViewModel vm)
                {
                    bool hasHtml = !string.IsNullOrEmpty(vm.MetadataHtmlContent);
                    
                    MetadataWebBrowser.Visibility = hasHtml ? Visibility.Visible : Visibility.Collapsed;
                    Metadata_List.Visibility = hasHtml ? Visibility.Collapsed : Visibility.Visible;
                    
                    // WAŻNE: Włącz/wyłącz przycisk drukowania
                    PrintMetadataButton.IsEnabled = hasHtml;
                    
                    // Ustaw HTML bezpośrednio
                    if (hasHtml)
                    {
                        WebBrowserHelper.SetHtml(MetadataWebBrowser, vm.MetadataHtmlContent);
                    }
                }
            }
            else if (e.PropertyName == nameof(PlikViewModel.PackageName))
            {
                if (sender is PlikViewModel vm)
                {
                    UpdateWindowTitle(vm.PackageName);
                }
            }
        }

        private void UpdateWindowTitle(string? packageName)
        {
            if (string.IsNullOrEmpty(packageName))
            {
                this.Title = Tytul;
            }
            else
            {
                this.Title = $"{Tytul} - {packageName}";
            }
        }

        /// <summary>
        /// Adaptacyjnie ukrywa/pokazuje tekst w zakładkach i nagłówku w zależności od szerokości panelu i rozmiaru czcionki
        /// </summary>
        private void UpdateTabTextVisibility()
        {
            try
            {
                // Pobierz TabControl
                var navigationPanel = this.FindName("NavigationTabControl") as System.Windows.Controls.TabControl;
                if (navigationPanel == null || !navigationPanel.IsLoaded) return;

                double availableWidth = navigationPanel.ActualWidth;
                
                // Pobierz aktualny rozmiar czcionki AppFontSizeLarge
                double fontSizeLarge = DefaultFontSize + 4; // Fallback
                if (Application.Current.Resources.Contains("AppFontSizeLarge") &&
                    Application.Current.Resources["AppFontSizeLarge"] is double fsl)
                {
                    fontSizeLarge = fsl;
                }

                // Oblicz czy powinien być widoczny tekst
                // Formuła: szerokość < próg LUB rozmiar czcionki > 20
                bool shouldHideText = availableWidth < TabTextVisibilityThreshold || fontSizeLarge > 20;

                // Znajdź TextBlocki z tekstem w nagłówkach zakładek
                var dokumentyText = this.FindName("DokumentyText") as System.Windows.Controls.TextBlock;
                var sprawyText = this.FindName("SprawyText") as System.Windows.Controls.TextBlock;
                var metadaneText = this.FindName("MetadaneText") as System.Windows.Controls.TextBlock;

                // Ustaw widoczność
                var visibility = shouldHideText ? Visibility.Collapsed : Visibility.Visible;
                
                if (dokumentyText != null) dokumentyText.Visibility = visibility;
                if (sprawyText != null) sprawyText.Visibility = visibility;
                if (metadaneText != null) metadaneText.Visibility = visibility;
            }
            catch (System.Exception ex)
            {
                // Debug - pokaż błąd
                System.Diagnostics.Debug.WriteLine($"UpdateTabTextVisibility Error: {ex.Message}");
            }
        }

        private async void OtworzPaczke_Click(object sender, RoutedEventArgs e)
        {
            var picker = new OpenFileDialog {Filter = "Archive files (*.zip;*.tar)|*.zip;*.tar;|All files (*.*)|*.*"};
            if (picker.ShowDialog() != true) return;

            var vm = (PlikViewModel)this.DataContext;
            if (vm == null) return;

            try
            {
                await vm.LoadDirectoryFromArchiveAsync(picker.FileName);
                vm.PackageName = Path.GetFileNameWithoutExtension(picker.FileName);
            }
            catch (System.Exception ex)
            {
                MessageBox.Show("Błąd: " + ex.Message);
            }
        }
        
        #region Zmiana rozmiaru czcionki
        private void ResetFont_Click(object sender, RoutedEventArgs e)
        {
            // ustaw zasób aplikacji
            FontSizeManager.SetAppFontSize(DefaultFontSize);

            // wymuś synchronizację suwaka
            if (FontSizeSlider != null)
            {
                FontSizeSlider.Value = DefaultFontSize;
            }
            
            // Zaktualizuj widoczność tekstu w zakładkach
            UpdateTabTextVisibility();
        }
        
        // Obsługa suwaka - przy zmianie aktualizuje zasób aplikacji
        private void FontSizeSlider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            // ograniczenie zakresu - dodatkowa ochrona
            var v = Math.Clamp(e.NewValue, MinFontSize, MaxFontSize);
            FontSizeManager.SetAppFontSize(v);
            
            // Zaktualizuj widoczność tekstu w zakładkach po zmianie rozmiaru czcionki
            UpdateTabTextVisibility();
        }
        #endregion

        // Obsługa wyboru w drzewie spraw - korzysta z PlikViewModel jako pośrednika
        private void SprawyTree_SelectedItemChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            var selected = e.NewValue;
            if (this.DataContext is not PlikViewModel mainVm) return;

            // Jeżeli kliknięto węzeł sprawy (SprawaNode) — wyczyść dokument, pokaż metadane sprawy
            if (selected is SprawaNode sprawaNode)
            {
                mainVm.SelectedSprawaNode = sprawaNode;
            }
            // Jeżeli kliknięto dokument (Plik) — ustaw SelectedDocumentFile w ViewModel
            else if (selected is Plik doc)
            {
                mainVm.SelectedDocumentFile = doc;
            }
        }

        #region Drukowanie metadanych
        
        private void PrintMetadata_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (MetadataWebBrowser.Visibility == Visibility.Visible)
                {
                    // Rozwiń zaawansowane metadane
                    ExpandAdvancedMetadata();
                    System.Threading.Thread.Sleep(300);
                    
                    // Wywołaj podgląd wydruku przez WebBrowserHelper
                    if (!WebBrowserHelper.ShowPrintPreview(MetadataWebBrowser))
                    {
                        MessageBox.Show(
                            "Nie można uruchomić podglądu wydruku.\n\nSpróbuj użyć prawego przycisku myszy na dokumencie.", 
                            "Informacja",
                            MessageBoxButton.OK,
                            MessageBoxImage.Information);
                    }
                }
            }
            catch (System.Exception ex)
            {
                MessageBox.Show($"Błąd podglądu wydruku: {ex.Message}", "Błąd",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void ExpandAdvancedMetadata()
        {
            var script = @"
                var buttons = document.getElementsByClassName('collapsible');
                for (var i = 0; i < buttons.length; i++) {
                    var content = buttons[i].nextElementSibling;
                    if (content && !content.classList.contains('show')) {
                        content.classList.add('show');
                        buttons[i].classList.add('active');
                    }
                }
            ";
            WebBrowserHelper.ExecuteScript(MetadataWebBrowser, script);
        }

        #endregion
    }
}