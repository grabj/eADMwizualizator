using System;
using System.Diagnostics;
using System.IO;
using System.Threading.Tasks;

namespace eADMwizualizator.Helpers
{
    public static class DocumentConverter
    {
        private static readonly string[] LibreOfficePaths = new[]
        {
            @"C:\Program Files\LibreOffice\program\soffice.exe",
            @"C:\Program Files (x86)\LibreOffice\program\soffice.exe",
            Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles) + @"\LibreOffice\program\soffice.exe"
        };

        public static async Task<string?> ConvertDocToPdfAsync(string docPath)
        {
            return await ConvertToPdfAsync(docPath);
        }

        // Uniwersalna metoda konwersji dla wszystkich formatów obsługiwanych przez LibreOffice
        public static async Task<string?> ConvertToPdfAsync(string filePath)
        {
            if (string.IsNullOrEmpty(filePath) || !File.Exists(filePath))
                return null;

            var libreOfficePath = FindLibreOffice();
            if (libreOfficePath == null)
                return null;

            var outputDir = Path.GetDirectoryName(filePath);
            var pdfPath = Path.ChangeExtension(filePath, ".pdf");

            try
            {
                var process = new Process
                {
                    StartInfo = new ProcessStartInfo
                    {
                        FileName = libreOfficePath,
                        Arguments = $"--headless --convert-to pdf --outdir \"{outputDir}\" \"{filePath}\"",
                        UseShellExecute = false,
                        CreateNoWindow = true,
                        RedirectStandardOutput = true,
                        RedirectStandardError = true
                    }
                };

                process.Start();
                await process.WaitForExitAsync();

                // Sprawdź czy PDF został utworzony
                if (File.Exists(pdfPath))
                    return pdfPath;
            }
            catch
            {
                // Konwersja nie powiodła się
            }

            return null;
        }

        private static string? FindLibreOffice()
        {
            foreach (var path in LibreOfficePaths)
            {
                if (File.Exists(path))
                    return path;
            }
            return null;
        }

        public static bool IsLibreOfficeInstalled()
        {
            return FindLibreOffice() != null;
        }
    }
}