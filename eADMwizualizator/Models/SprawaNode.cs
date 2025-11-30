using System.Collections.ObjectModel;

namespace eADMwizualizator.Models
{
    public class SprawaNode
    {
        public Plik Sprawa { get; }
        // Klucz u¿ywany do grupowania — teraz nazwa ogólna (wartoœæId lub nazwa pliku)
        public string Key { get; }
        public ObservableCollection<Plik> Documents { get; } = new ObservableCollection<Plik>();

        public SprawaNode(Plik sprawa, string key)
        {
            Sprawa = sprawa;
            Key = key ?? string.Empty;
        }

        public string DisplayName => Sprawa?.Tytul ?? Sprawa?.Sciezka ?? Key;
    }
}