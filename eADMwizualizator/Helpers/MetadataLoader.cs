using eADMwizualizator.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;

namespace eADMwizualizator.Helpers
{
    public static class MetadataLoader
    {
        // Zwraca listê prostych par nazwa/wartoœæ z pliku XML (u¿ywane przy wyœwietlaniu SelectedMetadata)
        public static IEnumerable<MetadataEntry> LoadMetadataEntries(string path)
        {
            var list = new List<MetadataEntry>();
            if (string.IsNullOrEmpty(path) || !File.Exists(path)) return list;

            try
            {
                var root = XElement.Load(path);

                // Pobieramy wszystkie liœciowe elementy (bez pod-elementów) i tworzymy pary "œcie¿ka/element" -> wartoœæ
                var leaves = root.Descendants().Where(x => !x.HasElements);
                foreach (var leaf in leaves)
                {
                    var name = BuildElementPath(leaf);
                    var value = (leaf.Value ?? string.Empty).Trim();
                    list.Add(new MetadataEntry { Name = name, Value = value });
                }
            }
            catch
            {
                // w razie b³êdu zwracamy pust¹ listê (wyœwietlenie b³êdu obs³u¿y wywo³uj¹cy)
            }

            return list;
        }

        // Parsuje plik z folderu "Sprawy" i tworzy obiekt Metadata z wybranymi polami:
        // - grupowanie/kod -> Grupowanie
        // - data/czas -> Data
        // - data/od -> DataOd
        // - data/do -> DataDo
        // - relacja/.../wartoscId -> lista Relacje
        public static Metadata? ParseSprawaMetadata(string path)
        {
            if (string.IsNullOrEmpty(path) || !File.Exists(path)) return null;

            try
            {
                var root = XElement.Load(path);

                // XML Metadane
                // grupowanie/kod
                var kodEl = root.Descendants("grupowanie").Descendants("kod").FirstOrDefault()
                            ?? root.Descendants("kod").FirstOrDefault();
                var kod = kodEl?.Value?.Trim();

                // data/czas
                DateTime? data = null;
                var czasEl = root.Descendants("data").Descendants("czas").FirstOrDefault()
                              ?? root.Descendants("czas").FirstOrDefault();
                if (czasEl != null && DateTime.TryParse(czasEl.Value.Trim(), out var dtC)) data = dtC;

                // XML Sprawy
                // data/od, data/do
                DateTime? dataOd = null, dataDo = null;
                var odEl = root.Descendants("data").Descendants("od").FirstOrDefault() ?? root.Descendants("od").FirstOrDefault();
                var doEl = root.Descendants("data").Descendants("do").FirstOrDefault() ?? root.Descendants("do").FirstOrDefault();
                if (odEl != null && DateTime.TryParse(odEl.Value.Trim(), out var dtOd)) dataOd = dtOd;
                if (doEl != null && DateTime.TryParse(doEl.Value.Trim(), out var dtDo)) dataDo = dtDo;

                

                var fileName = Path.GetFileName(path) ?? path;
                var id = fileName;
                var tytul = fileName;

                // Tworzymy obiekt Metadata z list¹ relacji 
                var meta = new Metadata(path, tytul, data, dataOd, dataDo, kod)
                {
                    Sciezka = path,
                    Tytul = tytul,
                    Data = data,
                    DataOd = dataOd,
                    DataDo = dataDo,
                    Grupowanie = kod,
                };

                return meta;
            }
            catch
            {
                return null;
            }
        }

        // Helper: buduje "œcie¿kê" nazwy elementu (np. "grupowanie/kod")
        private static string BuildElementPath(XElement el)
        {
            var parts = new Stack<string>();
            var cur = el;
            while (cur != null)
            {
                parts.Push(cur.Name.LocalName);
                cur = cur.Parent;
            }
            return string.Join("/", parts);
        }
    }
}
