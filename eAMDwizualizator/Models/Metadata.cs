using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAMDwizualizator.Models
{
    class Metadata : Models.Plik
    {
        public string? Id { get; set; }
        public DateTime? Data { get; set; }
        public string? Format { get; set; }
        public string? Dostep { get; set; }
        public string? Typ { get; set; }
        public string? Grupowanie { get; set; }
        public string? Tworca { get; set; }
        public string? Nadawca { get; set; }
        public string? Odbiorca { get; set; }
        public string? Relacja { get; set; }
        public string? Klasyfikacja { get; set; }
        public string? Jezyk { get; set; }
        public string? Opis { get; set; }
        public string? Tematyka { get; set; }
        public string? Uprawnienia { get; set; }

        public Metadata(string id, string sciezka, string tytul, DateTime? data, string? format, string? dostep, string? typ, string? grupowanie, string? tworca, string? nadawca, string? odbiorca, string? relacja, string? klasyfikacja, string? jezyk, string? opis, string? tematyka, string? uprawnienia) : base(sciezka, tytul)
        {
            Id = id;
            Sciezka = sciezka;
            Tytul = tytul;
            Data = data;
            Format = format;
            Dostep = dostep;
            Typ = typ;
            Grupowanie = grupowanie;
            Tworca = tworca;
            Nadawca = nadawca;
            Odbiorca = odbiorca;
            Relacja = relacja;
            Klasyfikacja = klasyfikacja;
            Jezyk = jezyk;
            Opis = opis;
            Tematyka = tematyka;
            Uprawnienia = uprawnienia;
        }

        public Metadata(string sciezka, string tytul, string? id) : base(sciezka, tytul)
        {
            Id = id;
            Sciezka = sciezka;
            Tytul = tytul;
        }

        public string strData()
        {
            return Data?.ToString("yyyy-MM-dd") ?? "brak daty";
        }
    }
}
