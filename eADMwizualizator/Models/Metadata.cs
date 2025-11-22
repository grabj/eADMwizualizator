using System;
using System.Data;

namespace eADMwizualizator.Models
{
    public class Metadata : Plik
    {
        public DateTime? Data { get; set; }
        public DateTime? DataOd { get; set; }
        public DateTime? DataDo { get; set; }
        public string? Format { get; set; }
        public string? Dostep { get; set; }
        public string? Typ { get; set; }
        public string? Grupowanie { get; set; }
        public string? Tworca { get; set; }
        public string? Nadawca { get; set; }
        public string? Odbiorca { get; set; }
        public string? Relacja { get; set; }
        public string? WartoscId { get; set; }
        public string? Klasyfikacja { get; set; }
        public string? Jezyk { get; set; }
        public string? Opis { get; set; }
        public string? Tematyka { get; set; }
        public string? Uprawnienia { get; set; }

        // pełny konstruktor - zachowuje kompatybilność
        public Metadata(string sciezka, string tytul, DateTime? data, DateTime? dataOd, DateTime? dataDo, string? grupowanie) : base(sciezka, tytul)
        {
            Sciezka = sciezka;
            Tytul = tytul;
            Data = data;
            DataOd = dataOd;
            DataDo = dataDo;
            Grupowanie = grupowanie;
        }

        // prostszy konstruktor
        public Metadata(string sciezka, string tytul, string? id) : base(sciezka, tytul)
        {
            Sciezka = sciezka;
            Tytul = tytul;
        }

        public string strData()
        {
            return Data?.ToString("yyyy-MM-dd") ?? "brak daty";
        }
    }
}
