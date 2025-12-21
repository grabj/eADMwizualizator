using System;
using System.IO;
using System.Windows;
using System.Windows.Controls;

namespace eADMwizualizator.Helpers
{
    // helper tworzy WebBrowser i nawiguje do pliku.
    public static class PdfContentControl
    {
        public static readonly DependencyProperty PdfSourceProperty =
            DependencyProperty.RegisterAttached(
                "PdfSource",
                typeof(string),
                typeof(PdfContentControl),
                new PropertyMetadata(null, OnPdfSourceChanged));

        public static void SetPdfSource(DependencyObject element, string? value)
            => element.SetValue(PdfSourceProperty, value);

        public static string? GetPdfSource(DependencyObject element)
            => (string?)element.GetValue(PdfSourceProperty);

        private static void OnPdfSourceChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is not ContentControl host)
                return;

            var path = e.NewValue as string;
            if (string.IsNullOrWhiteSpace(path) || !File.Exists(path))
            {
                host.Content = null;
                return;
            }

            var ext = Path.GetExtension(path).TrimStart('.').ToLowerInvariant();

            try
            {
                // absoutna œcie¿ka
                var abs = Path.GetFullPath(path);
                var browser = new WebBrowser();
                browser.Navigate(new Uri(abs, UriKind.Absolute));
                host.Content = browser;
            }
            catch
            {
                host.Content = null;
            }
        }
    }
}