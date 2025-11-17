using eAMDwizualizator.Models;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace eAMDwizualizator.Helpers
{
    internal static class MetadataLoader
    {
        // Parsuje plik XML i zwraca kolekcjê wpisów metadanych.
        // Rzuci wyj¹tek je¿eli za³adowanie XML siê nie powiedzie - caller powinien go obs³u¿yæ.
        public static List<MetadataEntry> LoadMetadataEntries(string filePath)
        {
            var result = new List<MetadataEntry>();

            var xdoc = XDocument.Load(filePath);
            var rootElem = xdoc.Root;
            if (rootElem == null) return result;

            foreach (var attr in rootElem.Attributes())
            {
                result.Add(new MetadataEntry { Name = "@" + attr.Name.LocalName, Value = attr.Value });
            }

            foreach (var elem in rootElem.Elements())
            {
                if (elem.HasElements)
                {
                    var children = string.Join("; ", elem.Elements().Select(e => $"{e.Name.LocalName}={e.Value}"));
                    result.Add(new MetadataEntry { Name = elem.Name.LocalName, Value = children });
                }
                else
                {
                    result.Add(new MetadataEntry { Name = elem.Name.LocalName, Value = elem.Value });
                }
            }

            return result;
        }
    }
}
