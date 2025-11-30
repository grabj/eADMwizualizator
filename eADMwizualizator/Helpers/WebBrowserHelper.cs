using System.Windows;
using System.Windows.Controls;

namespace eADMwizualizator.Helpers
{
    public static class WebBrowserHelper
    {
        public static readonly DependencyProperty HtmlProperty = DependencyProperty.RegisterAttached(
            "Html",
            typeof(string),
            typeof(WebBrowserHelper),
            new PropertyMetadata(null, OnHtmlChanged));

        public static string? GetHtml(DependencyObject obj)
        {
            return (string?)obj.GetValue(HtmlProperty);
        }

        public static void SetHtml(DependencyObject obj, string? value)
        {
            obj.SetValue(HtmlProperty, value);
        }

        private static void OnHtmlChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is WebBrowser browser && e.NewValue is string html && !string.IsNullOrEmpty(html))
            {
                browser.NavigateToString(html);
            }
        }
    }
}