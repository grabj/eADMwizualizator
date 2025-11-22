using eADMwizualizator.Models;
using System.Collections.ObjectModel;

namespace eADMwizualizator.ViewModels
{
    public class SprawaNodeViewModel
    {
        public Plik Sprawa { get; }
        public string GrupowanieKey { get; }
        public ObservableCollection<Plik> Documents { get; } = new ObservableCollection<Plik>();

        public SprawaNodeViewModel(Plik sprawa, string grupowanieKey)
        {
            Sprawa = sprawa;
            GrupowanieKey = grupowanieKey ?? string.Empty;
        }

        public string DisplayName => Sprawa?.Tytul ?? Sprawa?.Sciezka ?? GrupowanieKey;
    }
}