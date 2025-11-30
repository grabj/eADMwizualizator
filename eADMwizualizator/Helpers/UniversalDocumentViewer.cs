using System;
using System.IO;
using System.Windows;
using System.Windows.Controls;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;
using System.Windows.Media;

namespace eADMwizualizator.Helpers
{
    public static class UniversalDocumentViewer
    {
        private static readonly string[] ImageExtensions = { ".jpg", ".jpeg", ".png", ".bmp", ".gif", ".tiff", ".tif", ".ico" };
        private static readonly string[] TextExtensions = { ".txt", ".log", ".csv", ".json", ".xml", ".html", ".htm", ".css", ".js", ".md"};
        private static readonly string[] OfficeDocumentExtensions = { ".doc", ".docx", ".odt", ".ppt", ".pptx", ".odp" };

        public static readonly DependencyProperty DocumentSourceProperty =
            DependencyProperty.RegisterAttached(
                "DocumentSource",
                typeof(string),
                typeof(UniversalDocumentViewer),
                new PropertyMetadata(null, OnDocumentSourceChanged));

        public static string GetDocumentSource(DependencyObject obj)
        {
            return (string)obj.GetValue(DocumentSourceProperty);
        }

        public static void SetDocumentSource(DependencyObject obj, string value)
        {
            obj.SetValue(DocumentSourceProperty, value);
        }

        private static async void OnDocumentSourceChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is ContentControl contentControl && e.NewValue is string filePath)
            {
                await LoadDocumentAsync(contentControl, filePath);
            }
        }

        private static async Task LoadDocumentAsync(ContentControl contentControl, string filePath)
        {
            if (string.IsNullOrEmpty(filePath) || !File.Exists(filePath))
            {
                contentControl.Content = null;
                return;
            }

            string extension = Path.GetExtension(filePath).ToLowerInvariant();

            try
            {
                // Obrazy
                if (Array.IndexOf(ImageExtensions, extension) >= 0)
                {
                    LoadImage(contentControl, filePath);
                    return;
                }

                // Pliki tekstowe
                if (Array.IndexOf(TextExtensions, extension) >= 0)
                {
                    await LoadTextFileAsync(contentControl, filePath);
                    return;
                }

                // Dokumenty Office (wymagające konwersji)
                if (Array.IndexOf(OfficeDocumentExtensions, extension) >= 0)
                {
                    await HandleOfficeDocumentAsync(contentControl, filePath, extension);
                    return;
                }

                // Dokumenty PDF
                else
                {
                    PdfContentControlExtensions.SetPdfSource(contentControl, filePath);
                    return;
                }

                ShowUnsupportedMessage(contentControl, $"Nieobsługiwany format: {extension}");
            }
            catch (Exception ex)
            {
                ShowErrorMessage(contentControl, $"Błąd ładowania dokumentu: {ex.Message}");
            }
        }

        #region Obsługa obrazów

        private static void LoadImage(ContentControl contentControl, string imagePath)
        {
            try
            {
                var bitmap = new BitmapImage();
                bitmap.BeginInit();
                bitmap.CacheOption = BitmapCacheOption.OnLoad;
                bitmap.UriSource = new Uri(imagePath, UriKind.Absolute);
                bitmap.EndInit();
                bitmap.Freeze(); // Umożliwia użycie w różnych wątkach

                var image = new Image
                {
                    Source = bitmap,
                    Stretch = Stretch.Uniform,
                    StretchDirection = StretchDirection.DownOnly
                };

                // ScrollViewer dla dużych obrazów
                var scrollViewer = new ScrollViewer
                {
                    HorizontalScrollBarVisibility = ScrollBarVisibility.Auto,
                    VerticalScrollBarVisibility = ScrollBarVisibility.Auto,
                    Content = image
                };

                contentControl.Content = scrollViewer;
            }
            catch (Exception ex)
            {
                ShowErrorMessage(contentControl, $"Nie można załadować obrazu: {ex.Message}");
            }
        }

        #endregion

        #region Obsługa plików tekstowych

        private static async Task LoadTextFileAsync(ContentControl contentControl, string textFilePath)
        {
            try
            {
                // Odczyt pliku asynchronicznie
                string content = await Task.Run(() => File.ReadAllText(textFilePath, DetectEncoding(textFilePath)));

                // TextBox z obsługą przewijania i kopiowania
                var textBox = new TextBox
                {
                    Text = content,
                    IsReadOnly = true,
                    VerticalScrollBarVisibility = ScrollBarVisibility.Auto,
                    HorizontalScrollBarVisibility = ScrollBarVisibility.Auto,
                    TextWrapping = TextWrapping.Wrap,
                    FontFamily = new FontFamily("Tahoma, Consolas, Courier New"),
                    Padding = new Thickness(10),
                    BorderThickness = new Thickness(0)
                };

                contentControl.Content = textBox;
            }
            catch (Exception ex)
            {
                ShowErrorMessage(contentControl, $"Nie można załadować pliku tekstowego: {ex.Message}");
            }
        }

        private static Encoding DetectEncoding(string filePath)
        {
            // Prosta detekcja kodowania - sprawdź BOM
            byte[] bom = new byte[4];
            using (var file = new FileStream(filePath, FileMode.Open, FileAccess.Read))
            {
                file.Read(bom, 0, 4);
            }

            // UTF-8 BOM
            if (bom[0] == 0xEF && bom[1] == 0xBB && bom[2] == 0xBF)
                return Encoding.UTF8;

            // UTF-16 LE BOM
            if (bom[0] == 0xFF && bom[1] == 0xFE)
                return Encoding.Unicode;

            // UTF-16 BE BOM
            if (bom[0] == 0xFE && bom[1] == 0xFF)
                return Encoding.BigEndianUnicode;

            // UTF-32 LE BOM
            if (bom[0] == 0xFF && bom[1] == 0xFE && bom[2] == 0x00 && bom[3] == 0x00)
                return Encoding.UTF32;

            // Domyślnie UTF-8 bez BOM
            return new UTF8Encoding(false);
        }

        #endregion

        #region Obsługa dokumentów Office

        private static async Task HandleOfficeDocumentAsync(ContentControl contentControl, string filePath, string extension)
        {
            string documentType = GetDocumentTypeName(extension);
            ShowLoadingMessage(contentControl, $"Konwertowanie {documentType} do PDF...");

            var pdfPath = await DocumentConverter.ConvertToPdfAsync(filePath);

            if (!string.IsNullOrEmpty(pdfPath) && File.Exists(pdfPath))
            {
                PdfContentControlExtensions.SetPdfSource(contentControl, pdfPath);
            }
            else
            {
                var message = DocumentConverter.IsLibreOfficeInstalled()
                    ? $"Nie udało się przekonwertować {documentType}"
                    : $"Format {extension.ToUpper()} wymaga zainstalowania LibreOffice.\n\nPobierz ze strony: https://www.libreoffice.org/download";
                
                ShowUnsupportedMessage(contentControl, message);
            }
        }

        private static string GetDocumentTypeName(string extension)
        {
            return extension.ToLowerInvariant() switch
            {
                ".doc" or ".docx" => "dokumentu Word",
                ".odt" => "dokumentu ODT",
                ".ppt" or ".pptx" => "prezentacji PowerPoint",
                ".odp" => "prezentacji ODP",
                _ => "dokumentu"
            };
        }

        #endregion

        #region Komunikaty

        private static void ShowLoadingMessage(ContentControl contentControl, string message)
        {
            var stackPanel = new StackPanel
            {
                VerticalAlignment = VerticalAlignment.Center,
                HorizontalAlignment = HorizontalAlignment.Center
            };

            stackPanel.Children.Add(new TextBlock
            {
                Text = message,
                TextWrapping = TextWrapping.Wrap,
                HorizontalAlignment = HorizontalAlignment.Center,
                Margin = new Thickness(20),
                FontSize = 14
            });

            contentControl.Content = stackPanel;
        }

        private static void ShowUnsupportedMessage(ContentControl contentControl, string message)
        {
            var textBlock = new TextBlock
            {
                Text = message,
                TextWrapping = TextWrapping.Wrap,
                VerticalAlignment = VerticalAlignment.Center,
                HorizontalAlignment = HorizontalAlignment.Center,
                Margin = new Thickness(20),
                FontSize = 14
            };
            contentControl.Content = textBlock;
        }

        private static void ShowErrorMessage(ContentControl contentControl, string message)
        {
            ShowUnsupportedMessage(contentControl, message);
        }

        #endregion
    }
}