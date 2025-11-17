using eADMwizualizator.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eADMwizualizator.Models
{
    public class Plik
    {
        public string Sciezka { get; set; }
        public string Tytul { get; set; }
        public bool? CzyUkryty { get; set; }
        public bool? CzyFolder { get; set; }
        public string? Rozszerzenie { get; set; }
        public FileCategory Category { get; set; } = FileCategory.Unknown;

        public Plik(string sciezka, string tytul)
        {
            Sciezka = sciezka;
            Tytul = tytul;
        }

    }
}
