using eADMwizualizator.Models;
using eADMwizualizator.ViewModels;
using System;
using System.Windows;
using System.Windows.Controls;

namespace eADMwizualizator.Views
{
    public partial class SprawyListView : UserControl
    {
        private SprawyListViewModel? _vm;
        private PlikViewModel? _mainVm;

        public SprawyListView()
        {
            InitializeComponent();
            DataContextChanged += SprawyListView_DataContextChanged;

            // jeżeli DataContext już jest ustawiony (np. w czasie tworzenia), spróbuj zainicjować
            TryInitialize(DataContext);
        }

        private void SprawyListView_DataContextChanged(object? sender, DependencyPropertyChangedEventArgs e)
        {
            TryInitialize(e.NewValue);
        }

        private void TryInitialize(object? newDataContext)
        {
            // oczekujemy, że rodzic ustawi tutaj instancję PlikViewModel (np. przez dziedziczenie DataContext)
            if (newDataContext is PlikViewModel mainVm)
            {
                // unikaj ponownej inicjalizacji dla tej samej instancji
                if (_mainVm == mainVm && _vm != null) return;

                _mainVm = mainVm;
                _vm = new SprawyListViewModel(_mainVm);
                // ustaw DataContext kontrolki na wewnętrzny ViewModel drzewa (Nodes)
                base.DataContext = _vm;
            }
        }

        private void SprawyTree_SelectedItemChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            var selected = e.NewValue;
            if (_mainVm == null) return;

            if (selected is Plik doc)
            {
                // użytkownik kliknął dokument — ustaw SelectedDocumentFile
                _mainVm.SelectedDocumentFile = doc;
            }
            else if (selected is SprawaNodeViewModel node)
            {
                // ustaw SelectedMetadataFile na plik sprawy
                _mainVm.SelectedMetadataFile = node.Sprawa;
            }
        }
    }
}
