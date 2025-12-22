using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;

namespace eADMwizualizator.Helpers
{
    /// <summary>
    /// Klasa walidacji zabezpieczeń - ochrona przed Zip Slip, XXE, walidacja rozszerzeń i magic bytes
    /// </summary>
    public static class SecurityValidator
    {
        #region Konfiguracja list rozszerzeń

        // Biała lista - dozwolone rozszerzenia dla aplikacji eADM
        private static readonly HashSet<string> WhitelistedExtensions = new(StringComparer.OrdinalIgnoreCase)
        {
            // Dokumenty tekstowe i logi
            ".txt", ".pdf", ".doc", ".docx", ".odt", ".rtf", ".log", ".md",
            
            // Arkusze kalkulacyjne
            ".xls", ".xlsx", ".csv", ".ods",
            
            // Prezentacje
            ".ppt", ".pptx", ".odp",
            
            // Obrazy
            ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff", ".tif", ".ico",
            
            // Formaty eADM i XML
            ".xml", ".xades", ".xsl", ".xslt",
            
            // Archiwa
            ".zip", ".tar", ".gz", ".7z",
            
            // Web i tekstowe
            ".html", ".htm", ".css", ".json",
            
        };

        // Czarna lista - potencjalnie niebezpieczne rozszerzenia (zawsze blokowane)
        private static readonly HashSet<string> BlacklistedExtensions = new(StringComparer.OrdinalIgnoreCase)
        {
            ".exe", ".dll", ".bat", ".cmd", ".com", ".scr", ".vbs", ".vbe",
            ".js", ".jse", ".wsf", ".wsh", ".msi", ".msp", ".cpl", ".jar",
            ".ps1", ".psm1", ".psd1", ".inf", ".reg", ".app", ".deb", ".rpm"
        };

        // Magic bytes - sygnatury plików
        private static readonly Dictionary<string, byte[][]> MagicBytes = new()
        {
            { ".pdf", new[] { new byte[] { 0x25, 0x50, 0x44, 0x46 } } }, // %PDF
            { ".zip", new[] { new byte[] { 0x50, 0x4B, 0x03, 0x04 }, new byte[] { 0x50, 0x4B, 0x05, 0x06 } } }, // PK
            { ".tar", new[] { new byte[] { 0x75, 0x73, 0x74, 0x61, 0x72 } } }, // ustar (offset 257)
            { ".jpg", new[] { new byte[] { 0xFF, 0xD8, 0xFF } } }, // JPEG
            { ".jpeg", new[] { new byte[] { 0xFF, 0xD8, 0xFF } } },
            { ".png", new[] { new byte[] { 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A } } },
            { ".gif", new[] { new byte[] { 0x47, 0x49, 0x46, 0x38 } } }, // GIF8
            { ".bmp", new[] { new byte[] { 0x42, 0x4D } } }, // BM
            { ".doc", new[] { new byte[] { 0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1 } } },
            { ".docx", new[] { new byte[] { 0x50, 0x4B, 0x03, 0x04 } } }, // ZIP-based
            { ".xlsx", new[] { new byte[] { 0x50, 0x4B, 0x03, 0x04 } } },
            { ".pptx", new[] { new byte[] { 0x50, 0x4B, 0x03, 0x04 } } },
        };

        // Wymagane katalogi w paczce eADM
        private static readonly HashSet<string> RequiredEadmFolders = new(StringComparer.OrdinalIgnoreCase)
        {
            "dokumenty",
            "sprawy",
            "metadane"
        };

        #endregion

        #region Walidacja struktury paczki eADM

        /// <summary>
        /// Sprawdza czy katalog zawiera prawidłową strukturę paczki eADM (dokumenty, sprawy, metadane)
        /// </summary>
        /// <param name="directoryPath">Ścieżka do katalogu do sprawdzenia</param>
        /// <returns>Wynik walidacji struktury</returns>
        public static EadmStructureValidationResult ValidateEadmStructure(string directoryPath)
        {
            var result = new EadmStructureValidationResult();

            if (string.IsNullOrWhiteSpace(directoryPath))
            {
                result.IsValid = false;
                result.Errors.Add("Ścieżka katalogu jest pusta.");
                return result;
            }

            if (!Directory.Exists(directoryPath))
            {
                result.IsValid = false;
                result.Errors.Add("Katalog nie istnieje.");
                return result;
            }

            try
            {
                var existingFolders = Directory.GetDirectories(directoryPath)
                    .Select(d => Path.GetFileName(d))
                    .ToHashSet(StringComparer.OrdinalIgnoreCase);

                result.FoundFolders = existingFolders.ToList();

                foreach (var requiredFolder in RequiredEadmFolders)
                {
                    if (existingFolders.Contains(requiredFolder))
                    {
                        result.PresentFolders.Add(requiredFolder);
                    }
                    else
                    {
                        result.MissingFolders.Add(requiredFolder);
                    }
                }

                result.IsValid = result.MissingFolders.Count == 0;

                if (!result.IsValid)
                {
                    result.Errors.Add($"Brak wymaganych katalogów: {string.Join(", ", result.MissingFolders)}");
                }
            }
            catch (Exception ex)
            {
                result.IsValid = false;
                result.Errors.Add($"Błąd podczas sprawdzania struktury: {ex.Message}");
            }

            return result;
        }

        #endregion

        #region Ochrona przed Zip Bombs - limity

        /// <summary>
        /// Maksymalny akceptowalny współczynnik kompresji dla archiwów ustawowo nieskompresowanych (1.1:1)
        /// Niewielki margines uwzględnia metadane i nagłówki
        /// </summary>
        public const double MaxCompressionRatioForUncompressed = 1.1;

        /// <summary>
        /// Maksymalna liczba plików w archiwum
        /// </summary>
        public const int MaxFilesInArchive = 10000;

        /// <summary>
        /// Maksymalny łączny rozmiar rozpakowanych plików (500 MB)
        /// </summary>
        public const long MaxTotalUncompressedSize = 500 * 1024 * 1024;

        /// <summary>
        /// Waliduje archiwum pod kątem ataku zip bomb
        /// </summary>
        public static ZipBombValidationResult ValidateArchiveForZipBomb(
            long compressedSize,
            long uncompressedSize,
            int fileCount)
        {
            var result = new ZipBombValidationResult();

            // Sprawdź liczbę plików
            if (fileCount > MaxFilesInArchive)
            {
                result.IsValid = false;
                result.Errors.Add($"Zbyt wiele plików w archiwum: {fileCount} (max: {MaxFilesInArchive})");
            }

            // Sprawdź łączny rozmiar
            if (uncompressedSize > MaxTotalUncompressedSize)
            {
                result.IsValid = false;
                result.Errors.Add($"Zbyt duży rozmiar po rozpakowaniu: {uncompressedSize / (1024 * 1024)} MB (max: {MaxTotalUncompressedSize / (1024 * 1024)} MB)");
            }

            // Sprawdź czy archiwum jest właściwie nieskompresowane (1:1)
            if (compressedSize > 0)
            {
                var ratio = (double)uncompressedSize / compressedSize;
                if (ratio > MaxCompressionRatioForUncompressed)
                {
                    result.IsValid = false;
                    result.Errors.Add($"Niewłaściwy współczynnik kompresji: {ratio:F2}:1 (oczekiwano ~1:1 dla archiwum nieskompresowanego)");
                }
                result.CompressionRatio = (long)ratio;
            }

            result.FileCount = fileCount;
            result.TotalUncompressedSize = uncompressedSize;

            return result;
        }

        /// <summary>
        /// Sprawdza pojedynczy wpis archiwum - dla archiwów nieskompresowanych stosunek powinien być ~1:1
        /// </summary>
        public static bool ValidateArchiveEntry(long compressedSize, long uncompressedSize)
        {
            if (compressedSize <= 0)
                return true; // Nie można obliczyć współczynnika

            var ratio = (double)uncompressedSize / compressedSize;
            return ratio <= MaxCompressionRatioForUncompressed;
        }

        #endregion

        #region Bezpieczne ładowanie XML (ochrona przed XXE)

        /// <summary>
        /// Tworzy bezpieczne ustawienia XmlReaderSettings chroniące przed XXE
        /// </summary>
        public static XmlReaderSettings CreateSecureXmlReaderSettings()
        {
            return new XmlReaderSettings
            {
                DtdProcessing = DtdProcessing.Prohibit,  // Blokuj DTD
                XmlResolver = null,                       // Blokuj zewnętrzne encje
                MaxCharactersFromEntities = 1024,         // Limit znaków z encji
                MaxCharactersInDocument = 10 * 1024 * 1024, // 10 MB limit dokumentu
            };
        }

        /// <summary>
        /// Bezpiecznie ładuje XmlDocument chroniąc przed XXE
        /// </summary>
        public static XmlDocument LoadXmlDocumentSecurely(string xmlPath)
        {
            if (!File.Exists(xmlPath))
                throw new FileNotFoundException("Plik XML nie istnieje", xmlPath);

            var doc = new XmlDocument
            {
                XmlResolver = null // Wyłącz resolver
            };

            using var reader = XmlReader.Create(xmlPath, CreateSecureXmlReaderSettings());
            doc.Load(reader);

            return doc;
        }

        /// <summary>
        /// Bezpiecznie ładuje XmlDocument ze strumienia
        /// </summary>
        public static XmlDocument LoadXmlDocumentSecurely(Stream stream)
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
        /// Bezpiecznie ładuje XDocument chroniąc przed XXE
        /// </summary>
        public static XDocument LoadXDocumentSecurely(string xmlPath)
        {
            if (!File.Exists(xmlPath))
                throw new FileNotFoundException("Plik XML nie istnieje", xmlPath);

            using var reader = XmlReader.Create(xmlPath, CreateSecureXmlReaderSettings());
            return XDocument.Load(reader);
        }

        /// <summary>
        /// Bezpiecznie parsuje XML ze stringa
        /// </summary>
        public static XDocument ParseXmlSecurely(string xmlContent)
        {
            using var stringReader = new StringReader(xmlContent);
            using var xmlReader = XmlReader.Create(stringReader, CreateSecureXmlReaderSettings());
            return XDocument.Load(xmlReader);
        }

        #endregion

        #region Walidacja ścieżek - ochrona przed Zip Slip

        /// <summary>
        /// Waliduje ścieżkę przed atakiem Zip Slip
        /// </summary>
        /// <param name="destinationDirectory">Katalog docelowy</param>
        /// <param name="entryName">Nazwa wpisu z archiwum</param>
        /// <returns>True jeśli ścieżka jest bezpieczna</returns>
        public static bool ValidatePathTraversal(string destinationDirectory, string entryName)
        {
            if (string.IsNullOrWhiteSpace(destinationDirectory) || string.IsNullOrWhiteSpace(entryName))
                return false;

            try
            {
                // Normalizuj ścieżki
                var normalizedDestination = Path.GetFullPath(destinationDirectory);
                var fullPath = Path.GetFullPath(Path.Combine(destinationDirectory, entryName));

                // Sprawdź czy wynikowa ścieżka znajduje się w katalogu docelowym
                if (!fullPath.StartsWith(normalizedDestination, StringComparison.OrdinalIgnoreCase))
                {
                    return false;
                }

                // Dodatkowe sprawdzenia
                if (entryName.Contains("..") || 
                    entryName.Contains("./") || 
                    entryName.Contains(".\\") ||
                    Path.IsPathRooted(entryName))
                {
                    return false;
                }

                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Zwraca bezpieczną ścieżkę dla wpisu z archiwum
        /// </summary>
        public static string? GetSafePath(string destinationDirectory, string entryName)
        {
            if (!ValidatePathTraversal(destinationDirectory, entryName))
                return null;

            return Path.Combine(destinationDirectory, entryName);
        }

        #endregion

        #region Walidacja rozszerzeń plików

        /// <summary>
        /// Sprawdza czy rozszerzenie pliku jest dozwolone
        /// </summary>
        public static bool IsExtensionAllowed(string fileName)
        {
            if (string.IsNullOrWhiteSpace(fileName))
                return false;

            var extension = Path.GetExtension(fileName);
            if (string.IsNullOrEmpty(extension))
                return false;

            // Najpierw sprawdź czarną listę
            if (BlacklistedExtensions.Contains(extension))
                return false;

            // Następnie sprawdź białą listę
            return WhitelistedExtensions.Contains(extension);
        }

        /// <summary>
        /// Sprawdza czy plik znajduje się na czarnej liście
        /// </summary>
        public static bool IsExtensionBlacklisted(string fileName)
        {
            if (string.IsNullOrWhiteSpace(fileName))
                return true;

            var extension = Path.GetExtension(fileName);
            return BlacklistedExtensions.Contains(extension);
        }

        /// <summary>
        /// Pobiera informację o statusie rozszerzenia
        /// </summary>
        public static ExtensionStatus GetExtensionStatus(string fileName)
        {
            if (string.IsNullOrWhiteSpace(fileName))
                return ExtensionStatus.Invalid;

            var extension = Path.GetExtension(fileName);
            if (string.IsNullOrEmpty(extension))
                return ExtensionStatus.NoExtension;

            if (BlacklistedExtensions.Contains(extension))
                return ExtensionStatus.Blacklisted;

            if (WhitelistedExtensions.Contains(extension))
                return ExtensionStatus.Allowed;

            return ExtensionStatus.NotWhitelisted;
        }

        #endregion

        #region Walidacja Magic Bytes

        /// <summary>
        /// Waliduje plik na podstawie magic bytes (sygnatury pliku)
        /// </summary>
        public static bool ValidateMagicBytes(string filePath)
        {
            if (!File.Exists(filePath))
                return false;

            var extension = Path.GetExtension(filePath).ToLowerInvariant();
            
            // Jeśli nie mamy zdefiniowanych magic bytes dla tego rozszerzenia, uznajemy za poprawne
            // (pliki tekstowe, XML itp. nie mają jednoznacznych sygnatur)
            if (!MagicBytes.ContainsKey(extension))
                return true;

            try
            {
                var signatures = MagicBytes[extension];
                var buffer = new byte[8]; // większość sygnatur mieści się w 8 bajtach

                using var fs = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read);
                var bytesRead = fs.Read(buffer, 0, buffer.Length);

                if (bytesRead == 0)
                    return false;

                // Sprawdź czy któraś z sygnatur pasuje
                foreach (var signature in signatures)
                {
                    if (bytesRead >= signature.Length)
                    {
                        bool matches = true;
                        for (int i = 0; i < signature.Length; i++)
                        {
                            if (buffer[i] != signature[i])
                            {
                                matches = false;
                                break;
                            }
                        }

                        if (matches)
                            return true;
                    }
                }

                // Specjalny przypadek dla TAR - sygnatura jest na offsetcie 257
                if (extension == ".tar")
                {
                    fs.Seek(257, SeekOrigin.Begin);
                    var tarBuffer = new byte[5];
                    if (fs.Read(tarBuffer, 0, 5) == 5)
                    {
                        var tarSignature = Encoding.ASCII.GetBytes("ustar");
                        if (tarBuffer.SequenceEqual(tarSignature))
                            return true;
                    }
                }

                return false;
            }
            catch
            {
                return false;
            }
        }

        #endregion

        #region Kompleksowa walidacja pliku

        /// <summary>
        /// Przeprowadza kompleksową walidację bezpieczeństwa pliku
        /// </summary>
        public static FileValidationResult ValidateFile(string filePath, string? destinationDirectory = null)
        {
            var result = new FileValidationResult { FilePath = filePath };

            // 1. Sprawdź czy plik istnieje
            if (!File.Exists(filePath))
            {
                result.IsValid = false;
                result.Errors.Add("Plik nie istnieje");
                return result;
            }

            var fileName = Path.GetFileName(filePath);

            // 2. Walidacja rozszerzenia
            var extensionStatus = GetExtensionStatus(fileName);
            result.ExtensionStatus = extensionStatus;

            if (extensionStatus == ExtensionStatus.Blacklisted)
            {
                result.IsValid = false;
                result.Errors.Add($"Rozszerzenie pliku znajduje się na czarnej liście: {Path.GetExtension(fileName)}");
                return result;
            }

            if (extensionStatus != ExtensionStatus.Allowed)
            {
                result.Warnings.Add($"Rozszerzenie pliku nie znajduje się na białej liście: {Path.GetExtension(fileName)}");
            }

            // 3. Walidacja magic bytes
            if (!ValidateMagicBytes(filePath))
            {
                result.IsValid = false;
                result.Errors.Add("Sygnatura pliku (magic bytes) nie odpowiada deklarowanemu rozszerzeniu");
                return result;
            }

            // 4. Walidacja ścieżki (jeśli podano katalog docelowy)
            if (!string.IsNullOrEmpty(destinationDirectory))
            {
                if (!ValidatePathTraversal(destinationDirectory, fileName))
                {
                    result.IsValid = false;
                    result.Errors.Add("Wykryto próbę ataku Zip Slip - ścieżka zawiera niedozwolone elementy");
                    return result;
                }
            }

            result.IsValid = true;
            return result;
        }

        #endregion
    }

    #region Klasy pomocnicze

    public enum ExtensionStatus
    {
        Invalid,
        NoExtension,
        Blacklisted,
        NotWhitelisted,
        Allowed
    }

    public class FileValidationResult
    {
        public string? FilePath { get; set; }
        public bool IsValid { get; set; }
        public ExtensionStatus ExtensionStatus { get; set; }
        public List<string> Errors { get; } = new();
        public List<string> Warnings { get; } = new();

        public string GetErrorMessage() => string.Join(Environment.NewLine, Errors);
        public string GetWarningMessage() => string.Join(Environment.NewLine, Warnings);
    }

    public class ZipBombValidationResult
    {
        public bool IsValid { get; set; } = true;
        public long CompressionRatio { get; set; }
        public int FileCount { get; set; }
        public long TotalUncompressedSize { get; set; }
        public List<string> Errors { get; } = new();

        public string GetErrorMessage() => string.Join(Environment.NewLine, Errors);
    }

    /// <summary>
    /// Wynik walidacji struktury paczki eADM
    /// </summary>
    public class EadmStructureValidationResult
    {
        public bool IsValid { get; set; }
        public List<string> MissingFolders { get; } = new();
        public List<string> PresentFolders { get; } = new();
        public List<string> FoundFolders { get; set; } = new();
        public List<string> Errors { get; } = new();

        public string GetErrorMessage() => string.Join(Environment.NewLine, Errors);
    }

    #endregion
}
