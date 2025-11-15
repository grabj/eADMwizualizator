using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAMDwizualizator.Models
{
    public class Plik
    {
        public string Sciezka { get; set; }
        public string Tytul { get; set; }
        public bool? CzyUkryty { get; set; }
        public bool? CzyFolder { get; set; }
        public string? Rozszerzenie { get; set; }
        public bool? JestObrazem { get; set; }
        public bool? JestVideo { get; set; }

        public Plik(string sciezka, string tytul)
        {
            Sciezka = sciezka;
            Tytul = tytul;
        }

    }
}
