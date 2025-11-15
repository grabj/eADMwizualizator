using System;
using System.IO;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Threading;

namespace eAMDwizualizator.Helpers
{
    // Przyczepna w³asnoœæ do prostego wczytywania pliku PDF do DocumentViewer.
    // Mechanizm dzia³a przez utworzenie FlowDocument z BlockUIContainer zawieraj¹cym WebBrowser,
    // dziêki czemu nie umieszczamy logiki UI w ViewModel (MVVM).
    public static class DocumentViewerExtensions
    {
        public static readonly DependencyProperty PdfSourceProperty =
            DependencyProperty.RegisterAttached(
                "PdfSource",
                typeof(string),
                typeof(DocumentViewerExtensions),
                new PropertyMetadata(null, OnPdfSourceChanged));

        public static void SetPdfSource(DependencyObject element, string? value)
            => element.SetValue(PdfSourceProperty, value);

        public static string? GetPdfSource(DependencyObject element)
            => (string?)element.GetValue(PdfSourceProperty);

        private static void OnPdfSourceChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is not DocumentViewer viewer)
                return;

            var path = e.NewValue as string;
            if (string.IsNullOrEmpty(path) || !File.Exists(path))
            {
                viewer.Document = null;
                return;
            }

            var ext = Path.GetExtension(path).TrimStart('.').ToLowerInvariant();
            if (ext != "pdf")
            {
                // dla nie-pdfów - wyczyœæ lub mo¿na dodaæ inn¹ obs³ugê
                viewer.Document = null;
                return;
            }

            // Utwórz FlowDocument z WebBrowser osadzonym wewn¹trz BlockUIContainer.
            // Navigacja musi odbyæ siê na w¹tku UI - u¿yjemy Dispatcher.
            viewer.Dispatcher.BeginInvoke(DispatcherPriority.Normal, new Action(() =>
            {
                try
                {
                    var browser = new WebBrowser();
                    // U¿ywamy file:// URI - systemowy podgl¹d PDF (Edge / plugin) powinien to obs³u¿yæ.
                    browser.Navigate(new Uri(path));

                    var flow = new FlowDocument
                    {
                        PageWidth = viewer.ActualWidth > 0 ? viewer.ActualWidth : 800,
                        ColumnWidth = double.PositiveInfinity
                    };

                    var block = new BlockUIContainer(browser)
                    {
                        Padding = new Thickness(0)
                    };

                    flow.Blocks.Clear();
                    flow.Blocks.Add(block);

                    viewer.Document = flow;
                }
                catch
                {
                    viewer.Document = null;
                }
            }));
        }
    }
}