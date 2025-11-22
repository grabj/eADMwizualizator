using eADMwizualizator.Helpers;
using eADMwizualizator.Models;
using System;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Windows;

namespace eADMwizualizator.ViewModels
{
    public class SprawyListViewModel
    {
        private readonly PlikViewModel _mainVm;

        public ObservableCollection<SprawaNodeViewModel> Nodes { get; } = new ObservableCollection<SprawaNodeViewModel>();

        public SprawyListViewModel(PlikViewModel mainVm)
        {
            _mainVm = mainVm ?? throw new ArgumentNullException(nameof(mainVm));
            // Rebuild gdy kolekcje siê zmieni¹
            _mainVm.Sprawy.CollectionChanged += OnSourceCollectionChanged;
            _mainVm.Dokumenty.CollectionChanged += OnSourceCollectionChanged;
            _mainVm.Metadane.CollectionChanged += OnSourceCollectionChanged;
            _mainVm.PlikiWPaczce.CollectionChanged += OnSourceCollectionChanged;

            BuildNodes();
        }

        private void OnSourceCollectionChanged(object? sender, NotifyCollectionChangedEventArgs e)
        {
            // Zadbaj o UI thread
            Application.Current.Dispatcher.BeginInvoke(new Action(BuildNodes));
        }

        public void BuildNodes()
        {
            Nodes.Clear();

            foreach (var sprawa in _mainVm.Sprawy)
            {
                var sprawaKey = Path.GetFileNameWithoutExtension(sprawa.Tytul ?? Path.GetFileName(sprawa.Sciezka) ?? string.Empty);
                var node = new SprawaNodeViewModel(sprawa, sprawaKey);
                Nodes.Add(node);
            }

            // Przypisz dokumenty do wêz³ów
            foreach (var doc in _mainVm.Dokumenty)
            {
                var docBase = doc.Tytul ?? Path.GetFileName(doc.Sciezka) ?? string.Empty;

                // znajdŸ odpowiadaj¹cy plik metadanych: docBase + ".xml"
                var candidateMeta = _mainVm.Metadane.FirstOrDefault(m =>
                    string.Equals(m.Tytul, docBase + ".xml", StringComparison.OrdinalIgnoreCase))
                    ?? _mainVm.PlikiWPaczce.FirstOrDefault(m =>
                    string.Equals(m.Tytul, docBase + ".xml", StringComparison.OrdinalIgnoreCase));

                if (candidateMeta == null) continue;

                // spróbuj wyci¹gn¹æ wartoœæ "grupowanie" z pliku metadanych
                var grup = ExtractGrupowanieFromMetadataFile(candidateMeta.Sciezka);
                if (string.IsNullOrEmpty(grup)) continue;

                // znajdŸ odpowiadaj¹cy wêze³ sprawy (porównanie bez wielkoœci liter)
                var targetNode = Nodes.FirstOrDefault(n =>
                    string.Equals(n.GrupowanieKey, grup, StringComparison.OrdinalIgnoreCase)
                    || string.Equals(n.GrupowanieKey, Path.GetFileNameWithoutExtension(grup), StringComparison.OrdinalIgnoreCase));

                if (targetNode != null)
                {
                    targetNode.Documents.Add(doc);
                }
            }
        }

        private static string? ExtractGrupowanieFromMetadataFile(string path)
        {
            if (string.IsNullOrEmpty(path) || !File.Exists(path)) return null;
            try
            {
                var entries = MetadataLoader.LoadMetadataEntries(path);
                // szukamy pola, którego nazwa zawiera "grupowanie" (np. "grupowanie/kod")
                var found = entries.FirstOrDefault(e => e.Name?.IndexOf("grupowanie", StringComparison.OrdinalIgnoreCase) >= 0);
                if (found != null)
                    return found.Value?.Trim();
            }
            catch { }
            return null;
        }
    }
}