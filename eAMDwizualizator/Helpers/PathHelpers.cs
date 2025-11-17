using eAMDwizualizator.Models;
using System.IO;
using System.Linq;
using System.Collections.ObjectModel;
using System.Collections.Generic;

namespace eAMDwizualizator.Helpers
{
    internal static class PathHelpers
    {
        // Zwraca kategoriê pliku na podstawie nazwy bezpoœredniego katalogu rodzica
        public static FileCategory GetFileCategoryFromPath(string path)
        {
            if (string.IsNullOrEmpty(path)) return FileCategory.Unknown;
            var parentDir = Path.GetFileName(Path.GetDirectoryName(path) ?? string.Empty);
            if (string.IsNullOrEmpty(parentDir)) return FileCategory.Unknown;

            switch (parentDir.ToLowerInvariant())
            {
                case "dokumenty": return FileCategory.Dokumenty;
                case "sprawy": return FileCategory.Sprawy;
                case "metadane": return FileCategory.Metadane;
                default: return FileCategory.Unknown;
            }
        }

        // Zwraca nazwê katalogu odpowiadaj¹c¹ kategorii (u¿yteczne do budowy œcie¿ek)
        public static string GetFolderName(FileCategory category)
        {
            return category switch
            {
                FileCategory.Dokumenty => "dokumenty",
                FileCategory.Sprawy => "sprawy",
                FileCategory.Metadane => "metadane",
                _ => string.Empty
            };
        }

        // ZnajdŸ plik metadanych o danej nazwie w kolekcji plików paczki (sprawdza katalog 'metadane')
        public static string? FindMetadataInPackage(IEnumerable<Plik> filesInPackage, string metadataFileName)
        {
            if (filesInPackage == null) return null;
            var found = filesInPackage.FirstOrDefault(p =>
                !string.IsNullOrEmpty(p.Sciezka) &&
                Path.GetFileName(p.Sciezka).Equals(metadataFileName, System.StringComparison.OrdinalIgnoreCase) &&
                Path.GetFileName(Path.GetDirectoryName(p.Sciezka) ?? string.Empty).Equals("metadane", System.StringComparison.OrdinalIgnoreCase));

            return found?.Sciezka;
        }

        // ZnajdŸ dokument o danej nazwie w kolekcji plików paczki (sprawdza katalog 'dokumenty')
        public static Plik? FindDocumentInPackage(IEnumerable<Plik> filesInPackage, string docFileName)
        {
            if (filesInPackage == null) return null;
            var found = filesInPackage.FirstOrDefault(p =>
                !string.IsNullOrEmpty(p.Sciezka) &&
                Path.GetFileName(p.Sciezka).Equals(docFileName, System.StringComparison.OrdinalIgnoreCase) &&
                Path.GetFileName(Path.GetDirectoryName(p.Sciezka) ?? string.Empty).Equals("dokumenty", System.StringComparison.OrdinalIgnoreCase));

            return found;
        }
    }
}
