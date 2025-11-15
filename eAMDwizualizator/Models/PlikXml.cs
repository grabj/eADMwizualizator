using eAMDwizualizator.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAMDwizualizator.Modele
{
    internal class PlikXml : Plik
    {
        public PlikXml(string sciezka, string tytul) : base(sciezka, tytul)
        {
            Sciezka = sciezka;
            Tytul = tytul;
        }

        public int Id { get; set; }

    }
}
