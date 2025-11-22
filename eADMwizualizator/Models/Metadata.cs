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

        // konstruktor dla pliku Spraw
        public Metadata(string sciezka, string tytul, DateTime? dataOd, DateTime? dataDo) : base(sciezka, tytul)
        {
            Sciezka = sciezka;
            Tytul = tytul;
            DataOd = dataOd;
            DataDo = dataDo;
        }

        // konstruktor dla pliku Metadane
        public Metadata(string sciezka, string tytul, DateTime? data, string? grupowanie) : base(sciezka, tytul)
        {
            Sciezka = sciezka;
            Tytul = tytul;
            Data = data;
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
