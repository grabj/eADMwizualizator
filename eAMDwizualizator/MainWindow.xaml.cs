using eAMDwizualizator.ViewModels;
using Microsoft.Win32;
using SharpCompress.Archives;
using SharpCompress.Archives.Tar;
using SharpCompress.Archives.Zip;
using SharpCompress.Common;
using SharpCompress.Readers;
using System.IO;
using System.Runtime.CompilerServices;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;

namespace eAMDwizualizator
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
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

                // po udanym otwarciu schowaj górny panel
                vm.IsOpenPackageVisible = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Błąd: " + ex.Message);
            }
        }
        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }
    }
}