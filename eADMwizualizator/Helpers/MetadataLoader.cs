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
        // - data/od -> DataOd
        // - data/do -> DataDo
        public static Metadata? ParseSprawaMetadata(string path)
        {
            if (string.IsNullOrEmpty(path) || !File.Exists(path)) return null;

            try
            {
                var root = XElement.Load(path);
                var ns = root.Name.Namespace; // obs³uga domyœlnego namespace

                // XML Sprawy
                // data/od, data/do
                DateTime? dataOd = null, dataDo = null;
                var odEl = root.Descendants(ns + "data").Descendants(ns + "od").FirstOrDefault() ?? root.Descendants().FirstOrDefault(x => string.Equals(x.Name.LocalName, "od", StringComparison.OrdinalIgnoreCase));
                var doEl = root.Descendants(ns + "data").Descendants(ns + "do").FirstOrDefault() ?? root.Descendants().FirstOrDefault(x => string.Equals(x.Name.LocalName, "do", StringComparison.OrdinalIgnoreCase));
                if (odEl != null && DateTime.TryParse(odEl.Value.Trim(), out var dtOd)) dataOd = dtOd;
                if (doEl != null && DateTime.TryParse(doEl.Value.Trim(), out var dtDo)) dataDo = dtDo;

                var fileName = Path.GetFileName(path) ?? path;
                var tytul = fileName;

                // Tworzymy obiekt Metadata
                var meta = new Metadata(path, tytul, dataOd, dataDo)
                {
                    Sciezka = path,
                    Tytul = tytul,
                    DataOd = dataOd,
                    DataDo = dataDo,
                };

                return meta;
            }
            catch
            {
                return null;
            }
        }

        // Parsuje plik z folderu "Metadane" i tworzy obiekt Metadata z wybranymi polami:
        // - sprawdza wszystkie elementy <grupowanie> i wewnêtrzne pola kod oraz kodGrupy
        public static Metadata? ParseMetadaneMetadata(string path)
        {
            if (string.IsNullOrEmpty(path) || !File.Exists(path)) return null;

            try
            {
                var root = XElement.Load(path);
                var ns = root.Name.Namespace; // obs³uga domyœlnego namespace

                string? grupowanieValue = null;

                // Pobierz wszystkie elementy <grupowanie> (najpierw z namespace, potem fallback po LocalName)
                var grupowania = root.Descendants(ns + "grupowanie").ToList();
                if (!grupowania.Any())
                {
                    grupowania = root.Descendants().Where(x => string.Equals(x.Name.LocalName, "grupowanie", StringComparison.OrdinalIgnoreCase)).ToList();
                }

                foreach (var g in grupowania)
                {
                    // Szukamy typowych pól wewn¹trz <grupowanie>: kod, kodGrupy
                    XElement? candidate = null;

                    // Najpierw próbujemy z namespace
                    candidate = g.Element(ns + "kod") ?? g.Element(ns + "kodGrupy");

                    // Jeœli nie znaleziono, próbujemy po LocalName (case-insensitive)
                    if (candidate == null)
                    {
                        candidate = g.Elements().FirstOrDefault(e =>
                            string.Equals(e.Name.LocalName, "kod", StringComparison.OrdinalIgnoreCase)
                            || string.Equals(e.Name.LocalName, "kodGrupy", StringComparison.OrdinalIgnoreCase));
                    }

                    if (candidate != null)
                    {
                        var val = candidate.Value?.Trim();
                        if (!string.IsNullOrWhiteSpace(val))
                        {
                            grupowanieValue = val;
                            break;
                        }
                    }
                }

                // data/czas (bez dodatkowych heurystyk)
                DateTime? data = null;
                var czasEl = root.Descendants(ns + "data").Descendants(ns + "czas").FirstOrDefault()
                              ?? root.Descendants().FirstOrDefault(x => string.Equals(x.Name.LocalName, "czas", StringComparison.OrdinalIgnoreCase));
                if (czasEl != null && DateTime.TryParse(czasEl.Value.Trim(), out var dtC)) data = dtC;

                var fileName = Path.GetFileName(path) ?? path;
                var tytul = fileName;

                // Tworzymy obiekt Metadata
                var meta = new Metadata(path, tytul, data, grupowanieValue)
                {
                    Sciezka = path,
                    Tytul = tytul,
                    Data = data,
                    Grupowanie = grupowanieValue
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
