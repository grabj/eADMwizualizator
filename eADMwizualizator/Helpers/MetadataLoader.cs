using eADMwizualizator.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml;
using System.Xml.Linq;

namespace eADMwizualizator.Helpers
{
    public static class MetadataLoader
    {
        #region Ochrona przed XXE (XML External Entity)

        /// <summary>
        /// Tworzy bezpieczne ustawienia XmlReaderSettings chroni¹ce przed XXE
        /// </summary>
        public static XmlReaderSettings CreateSecureXmlReaderSettings()
        {
            return new XmlReaderSettings
            {
                DtdProcessing = DtdProcessing.Prohibit, // Blokuj DTD
                XmlResolver = null, // Blokuj rozwi¹zywanie zewnêtrznych encji
                MaxCharactersFromEntities = 1024, // Ogranicz znaki z encji
                MaxCharactersInDocument = 10485760, // 10 MB limit
            };
        }

        /// <summary>
        /// Bezpiecznie ³aduje dokument XML chroni¹c przed XXE
        /// </summary>
        public static XmlDocument LoadXmlSecurely(string xmlPath)
        {
            if (!File.Exists(xmlPath))
                throw new FileNotFoundException("Plik XML nie istnieje", xmlPath);

            var doc = new XmlDocument
            {
                XmlResolver = null // Wy³¹cz resolver dla XmlDocument
            };

            using var reader = XmlReader.Create(xmlPath, CreateSecureXmlReaderSettings());
            doc.Load(reader);

            return doc;
        }

        /// <summary>
        /// Bezpiecznie ³aduje dokument XML z strumienia
        /// </summary>
        public static XmlDocument LoadXmlSecurely(Stream stream)
        {
            var doc = new XmlDocument
            {
                XmlResolver = null
            };

            using var reader = XmlReader.Create(stream, CreateSecureXmlReaderSettings());
            doc.Load(reader);

            return doc;
        }

        /// <summary>
        /// Bezpiecznie ³aduje XDocument chroni¹c przed XXE
        /// </summary>
        private static XDocument LoadXDocumentSecurely(string xmlPath)
        {
            using var reader = XmlReader.Create(xmlPath, CreateSecureXmlReaderSettings());
            return XDocument.Load(reader);
        }

        #endregion

        // Zwraca listê prostych par nazwa/wartoœæ z pliku XML (u¿ywane przy wyœwietlaniu SelectedMetadata)
        public static IEnumerable<MetadataEntry> LoadMetadataEntries(string path)
        {
            var list = new List<MetadataEntry>();
            if (string.IsNullOrEmpty(path) || !File.Exists(path)) return list;

            try
            {
                var root = LoadXDocumentSecurely(path).Root;

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
                // w razie b³êdu zwracamy pust¹ listê
            }

            return list;
        }

        // Parsuje plik z folderu "Sprawy" i tworzy obiekt Metadata z wybranymi polami:
        // - data/od -> DataOd
        // - data/do -> DataDo
        // - wartoscId pobieran¹ z dokument/identyfikator/wartosc lub dokument/identyfikator/wartoscId
        public static Metadata? ParseSprawaMetadata(string path)
        {
            if (string.IsNullOrEmpty(path) || !File.Exists(path)) return null;

            try
            {
                var root = LoadXDocumentSecurely(path).Root;
                var ns = root.Name.Namespace; // obs³uga domyœlnego namespace

                // XML Sprawy
                // data/od, data/do
                DateTime? dataOd = null, dataDo = null;
                var odEl = root.Descendants(ns + "data").Descendants(ns + "od").FirstOrDefault() ?? root.Descendants().FirstOrDefault(x => string.Equals(x.Name.LocalName, "od", StringComparison.OrdinalIgnoreCase));
                var doEl = root.Descendants(ns + "data").Descendants(ns + "do").FirstOrDefault() ?? root.Descendants().FirstOrDefault(x => string.Equals(x.Name.LocalName, "do", StringComparison.OrdinalIgnoreCase));
                if (odEl != null && DateTime.TryParse(odEl.Value.Trim(), out var dtOd)) dataOd = dtOd;
                if (doEl != null && DateTime.TryParse(doEl.Value.Trim(), out var dtDo)) dataDo = dtDo;

                // Pobranie wartoœci identyfikatora dokumentu (wartosc / wartoscId)
                string? wartoscId = null;

                // Najpierw spróbuj znaleŸæ element <dokument>/<identyfikator> z namespace
                var identEl = root.Descendants(ns + "dokument").Descendants(ns + "identyfikator").FirstOrDefault();

                // Fallback: wyszukaj element <identyfikator> bez namespace (case-insensitive),
                // preferuj¹c te bêd¹ce w kontekœcie elementu o nazwie "dokument"
                if (identEl == null)
                {
                    identEl = root.Descendants()
                                  .FirstOrDefault(x =>
                                      string.Equals(x.Name.LocalName, "identyfikator", StringComparison.OrdinalIgnoreCase)
                                      && x.Parent != null
                                      && string.Equals(x.Parent.Name.LocalName, "dokument", StringComparison.OrdinalIgnoreCase));
                }

                // Jeœli nadal null, spróbuj znaleŸæ pierwszy element o LocalName == "identyfikator"
                if (identEl == null)
                {
                    identEl = root.Descendants()
                                  .FirstOrDefault(x => string.Equals(x.Name.LocalName, "identyfikator", StringComparison.OrdinalIgnoreCase));
                }

                if (identEl != null)
                {
                    // szukamy pola 'wartosc' lub 'wartoscId' (najpierw z namespace, potem po LocalName)
                    var wartoscEl = identEl.Element(ns + "wartosc") ?? identEl.Element(ns + "wartoscId");
                    if (wartoscEl == null)
                    {
                        wartoscEl = identEl.Elements().FirstOrDefault(e =>
                            string.Equals(e.Name.LocalName, "wartosc", StringComparison.OrdinalIgnoreCase)
                            || string.Equals(e.Name.LocalName, "wartoscId", StringComparison.OrdinalIgnoreCase));
                    }

                    if (wartoscEl != null)
                    {
                        var val = wartoscEl.Value?.Trim();
                        if (!string.IsNullOrWhiteSpace(val)) wartoscId = val;
                    }
                }

                var fileName = Path.GetFileName(path) ?? path;
                var tytul = fileName;

                // Tworzymy obiekt Metadata
                var meta = new Metadata(path, tytul, dataOd, dataDo, wartoscId)
                {
                    Sciezka = path,
                    Tytul = tytul,
                    DataOd = dataOd,
                    DataDo = dataDo,
                    WartoscId = wartoscId
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
                var root = LoadXDocumentSecurely(path).Root;
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
