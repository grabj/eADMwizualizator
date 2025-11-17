using eADMwizualizator.ViewModels;
using eADMwizualizator.Helpers;
using Microsoft.Win32;
using System;
using System.IO;
using System.Windows;

namespace eADMwizualizator
{
    public partial class MainWindow : Window
    {
        private static string Tytul = "Twoja paczka eADM";
 
        private const double DefaultFontSize = 12.0;
        private const double MinFontSize = 8.0;
        private const double MaxFontSize = 24.0;

        public MainWindow()
        {
            InitializeComponent();
            this.Title = Tytul;

        }
        private async void OtworzPaczke_Click(object sender, RoutedEventArgs e)
        {
            var picker = new OpenFileDialog {Filter = "Archive files (*.zip;*.tar)|*.zip;*.tar;|All files (*.*)|*.*"};
            if (picker.ShowDialog() != true) return;

            var vm = (PlikViewModel)this.DataContext;
            if (vm == null) return;

            // rekursywne pokazywanie plików
            vm.CzyRekursywnie = true; 

            try
            {
                await vm.LoadDirectoryFromArchiveAsync(picker.FileName);

                // po udanym otwarciu schowaj górny panel tylko gdy opcja NIEZAMYKAJ jest false
                if (!vm.NieZamykajPaneluOtworzPaczke)
                {
                    vm.IsOpenPackageVisible = false;
                    // ustaw tytuł okna z nazwą otwartego archiwum 
                }

                try
                {
                    var displayName = Path.GetFileName(picker.FileName);
                    this.Title = Tytul + " - " + displayName;
                }
                catch
                {
                        // Nie przerywaj działania aplikacji jeżeli ustawienie tytułu się nie powiedzie
                        this.Title = Tytul;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Błąd: " + ex.Message);
            }
        }
        #region Zmiana rozmiaru czcionki
        private void ResetFont_Click(object sender, RoutedEventArgs e)
        {
            // ustaw zasób aplikacji
            FontSizeManager.SetAppFontSize(DefaultFontSize);

            // wymuś synchronizację suwaka — suwak też wyzwoli ValueChanged, ale ustawiamy bezpiecznie.
            if (FontSizeSlider != null)
            {
                // bezpośrednie ustawienie Value przesunie suwak i zaktualizuje widok
                FontSizeSlider.Value = DefaultFontSize;
            }
        }
        // Jedna definicja SetAppFontSize — przeniesiona do helpera
        private double GetAppFontSize()
        {
            return FontSizeManager.GetAppFontSize(DefaultFontSize);
        }
        // Obsługa suwaka - przy zmianie aktualizuje zasób aplikacji
        private void FontSizeSlider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            // ograniczenie zakresu - dodatkowa ochrona
            var v = Math.Clamp(e.NewValue, MinFontSize, MaxFontSize);
            FontSizeManager.SetAppFontSize(v);
        }
        #endregion
        private void ShowOpenPackage_Click(object sender, RoutedEventArgs e)
        {
            if (this.DataContext is PlikViewModel vm)
            {
                // zawsze przełączaj widoczność panelu niezależnie od ustawienia "NieZamykajPaneluOtworzPaczke"
                vm.IsOpenPackageVisible = !vm.IsOpenPackageVisible;
            }
        }
        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }
    }
}