using System;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Xml.Linq;

namespace eADMwizualizator.Helpers
{
    public static class UniversalDocumentViewer
    {
        private static readonly string[] ImageExtensions = { ".jpg", ".jpeg", ".png", ".bmp", ".gif", ".tiff", ".tif", ".ico" };
        private static readonly string[] XmlExtensions = { ".xml", ".xades", ".xsl", ".xslt"};
        private static readonly string[] TextExtensions = { ".txt", ".log", ".md", ".css", ".json" };
        private static readonly string[] OfficeDocumentExtensions = { ".doc", ".docx", ".odt", ".ppt", ".pptx", ".odp", ".xls", ".xlsx", ".csv" };
        private static readonly string[] WebBrowserExtensions = { ".html",".htm" };

        public static readonly DependencyProperty DocumentSourceProperty =
            DependencyProperty.RegisterAttached(
                "DocumentSource",
                typeof(string),
                typeof(UniversalDocumentViewer),
                new PropertyMetadata(null, OnDocumentSourceChanged));

        public static readonly DependencyProperty TextFontSizeProperty =
            DependencyProperty.RegisterAttached(
                "TextFontSize",
                typeof(double),
                typeof(UniversalDocumentViewer),
                new PropertyMetadata(13.0, OnTextFontSizeChanged));

        public static string GetDocumentSource(DependencyObject obj)
        {
            return (string)obj.GetValue(DocumentSourceProperty);
        }

        public static void SetDocumentSource(DependencyObject obj, string value)
        {
            obj.SetValue(DocumentSourceProperty, value);
        }

        public static double GetTextFontSize(DependencyObject obj)
        {
            return (double)obj.GetValue(TextFontSizeProperty);
        }

        public static void SetTextFontSize(DependencyObject obj, double value)
        {
            obj.SetValue(TextFontSizeProperty, value);
        }

        private static void OnTextFontSizeChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is ContentControl contentControl && e.NewValue is double fontSize)
            {
                UpdateTextControlFontSize(contentControl, fontSize);
            }
        }

        private static void UpdateTextControlFontSize(ContentControl contentControl, double fontSize)
        {
            if (contentControl.Content is TextBox textBox)
            {
                textBox.FontSize = fontSize;
            }
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
            // Obsługa specjalnych wartości dla pustego widoku
            if (string.IsNullOrEmpty(filePath) || filePath == "about:blank")
            {
                ShowBlankDocument(contentControl);
                return;
            }
            
            if (!File.Exists(filePath))
            {
                contentControl.Content = null;
                return;
            }

            string extension = Path.GetExtension(filePath).ToLowerInvariant();

            try
            {
                // Najpierw wyczyść zawartość
                contentControl.Content = null;

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

                // Pliki XML/XAdES (TreeView)
                if (Array.IndexOf(XmlExtensions, extension) >= 0)
                {
                    await LoadXmlFileAsync(contentControl, filePath, extension);
                    return;
                }

                // Pliki PDF
                if (extension == ".pdf")
                {
                    PdfContentControl.SetPdfSource(contentControl, filePath);
                    return;
                }

                // Dokumenty wyświetlane przez WebView2
                if (Array.IndexOf(WebBrowserExtensions, extension) >= 0)
                {
                    await LoadHtmlFileAsync(contentControl, filePath);
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

                // Pobierz aktualny rozmiar czcionki z właściwości zależnej
                double fontSize = GetTextFontSize(contentControl);

                // TextBox z obsługą przewijania i kopiowania
                var textBox = new TextBox
                {
                    Text = content,
                    IsReadOnly = true,
                    VerticalScrollBarVisibility = ScrollBarVisibility.Auto,
                    HorizontalScrollBarVisibility = ScrollBarVisibility.Disabled,
                    TextWrapping = TextWrapping.Wrap,
                    FontFamily = new FontFamily("Tahoma, Consolas, Courier New"),
                    FontSize = fontSize,
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
                PdfContentControl.SetPdfSource(contentControl, pdfPath);
            }
            else
            {
                var message = DocumentConverter.IsLibreOfficeInstalled()
                    ? $"Nie udało się przekonwertować {documentType}"
                    : $"Format {extension.ToUpper()} wymaga zainstalowania LibreOffice.\n\nPobierz ze strony: https://www.libreoffice.org/download";
                
                ShowUnsupportedMessage(contentControl, message);
            }
        }

        #endregion

        #region Obsługa plików XML/XAdES

        private static async Task LoadXmlFileAsync(ContentControl contentControl, string xmlPath, string extension)
        {
            try
            {
                ShowLoadingMessage(contentControl, $"Ładowanie pliku {extension}...");
                // Najpierw sprawdź czy plik jest poprawnym XML
                XDocument? doc = null;
                bool isValidXml = false;

                try
                {
                    // ZABEZPIECZENIE: Bezpieczne ładowanie XML przez SecurityValidator
                    doc = await Task.Run(() => SecurityValidator.LoadXDocumentSecurely(xmlPath));
                    isValidXml = true;
                }
                catch (System.Xml.XmlException)
                {
                    // Fallback - próba naprawy pliku
                    try
                    {
                        var content = await Task.Run(() => File.ReadAllText(xmlPath, Encoding.UTF8));

                        // Usuń BOM i białe znaki na początku
                        content = content.TrimStart('\uFEFF', '\u200B', ' ', '\t', '\r', '\n');

                        // Spróbuj sparsować ponownie
                        doc = XDocument.Parse(content);
                        isValidXml = true;
                    }
                    catch
                    {
                        // Nadal nie można sparsować jako XML
                        isValidXml = false;
                    }
                }

                if (isValidXml && doc?.Root != null)
                {
                    // Wyświetl jako TreeView
                    var treeView = new TreeView
                    {
                        FontFamily = new FontFamily("Consolas, Courier New"),
                    };

                    var rootItem = CreateTreeItem(doc.Root, true);
                    treeView.Items.Add(rootItem);
                    rootItem.IsExpanded = true;

                    var scrollViewer = new ScrollViewer
                    {
                        HorizontalScrollBarVisibility = ScrollBarVisibility.Auto,
                        VerticalScrollBarVisibility = ScrollBarVisibility.Visible,
                        Content = treeView
                    };

                    contentControl.Content = scrollViewer;
                }
                else
                {
                    // Fallback: wyświetl jako zwykły tekst
                    await LoadTextFileAsync(contentControl, xmlPath);
                }
            }
            catch (Exception ex)
            {
                ShowErrorMessage(contentControl, $"Nie można załadować pliku XML: {ex.Message}");
            }
        }

        private static TreeViewItem CreateTreeItem(XElement element, bool expandAll)
        {
            var item = new TreeViewItem
            {
                IsExpanded = expandAll // Rozwiń wszystkie węzły domyślnie
            };

            // Nagłówek z nazwą elementu i atrybutami
            var header = new TextBlock();
            header.Inlines.Add(new Run($"<{element.Name.LocalName}") { Foreground = Brushes.DarkSlateGray, FontWeight = FontWeights.Bold });

            foreach (var attr in element.Attributes())
            {
                if (!attr.IsNamespaceDeclaration)
                {
                    header.Inlines.Add(new Run($" {attr.Name.LocalName}") { Foreground = Brushes.Purple });
                    header.Inlines.Add(new Run("=") { Foreground = Brushes.Black });
                    header.Inlines.Add(new Run($"\"{attr.Value}\"") { Foreground = Brushes.Green });
                }
            }

            header.Inlines.Add(new Run(">") { Foreground = Brushes.DarkSlateGray, FontWeight = FontWeights.Bold });

            item.Header = header;

            // Dzieci
            if (element.HasElements)
            {
                foreach (var child in element.Elements())
                {
                    item.Items.Add(CreateTreeItem(child, expandAll));
                }
            }
            else if (!string.IsNullOrWhiteSpace(element.Value))
            {
                var valueItem = new TreeViewItem
                {
                    Header = new TextBlock
                    {
                        Text = element.Value.Trim(),
                        Foreground = Brushes.DarkBlue,
                        TextWrapping = TextWrapping.Wrap
                    }
                };
                item.Items.Add(valueItem);
            }

            return item;
        }

        #endregion

        #region Obsługa plików HTML

        private static async Task LoadHtmlFileAsync(ContentControl contentControl, string htmlPath)
        {
            try
            {
                var webView = new Microsoft.Web.WebView2.Wpf.WebView2
                {
                    HorizontalAlignment = HorizontalAlignment.Stretch,
                    VerticalAlignment = VerticalAlignment.Stretch
                };

                await webView.EnsureCoreWebView2Async();
                webView.Source = new Uri(htmlPath, UriKind.Absolute);

                contentControl.Content = webView;
            }
            catch (Exception ex)
            {
                ShowErrorMessage(contentControl, $"Nie można załadować pliku HTML: {ex.Message}");
            }
        }

        private static void ShowBlankDocument(ContentControl contentControl)
        {
            var textBox = new TextBox
            {
                Text = null,
                IsReadOnly = true,
                Background = new SolidColorBrush(Color.FromRgb(250, 250, 250)),
                VerticalScrollBarVisibility = ScrollBarVisibility.Hidden,
                HorizontalScrollBarVisibility = ScrollBarVisibility.Hidden,
                BorderThickness = new Thickness(0)
            };

            contentControl.Content = textBox;
        }
        #endregion

        #region Komunikaty

        private static string GetDocumentTypeName(string extension)
        {
            return extension.ToLowerInvariant() switch
            {
                ".doc" or ".docx" => "dokumentu Word",
                ".odt" => "dokumentu ODT",
                ".ppt" or ".pptx" => "prezentacji PowerPoint",
                ".odp" => "prezentacji ODP",
                ".xml" => "pliku XML",
                ".xades" => "pliku XAdES",
                ".xls" or ".xlsx" => "arkusza Excel",
                ".csv" => "pliku CSV",
                _ => "dokumentu"
            };
        }

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