using eAMDwizualizator.ViewModels;
using Microsoft.Win32;
using System;
using System.IO;
using System.Windows;

namespace eAMDwizualizator
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private readonly string _baseTitle;
        private static string Tytul = "Twoja paczka eADM";
        public MainWindow()
        {
            InitializeComponent();
            this.Title = Tytul;
            _baseTitle = this.Title; // zachowaj oryginalny tytuł, używany jako prefiks
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