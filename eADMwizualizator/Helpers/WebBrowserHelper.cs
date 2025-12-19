using System;
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

        /// <summary>
        /// Wykonuje skrypt JavaScript w WebBrowser.
        /// </summary>
        public static void ExecuteScript(WebBrowser browser, string script)
        {
            try
            {
                browser.InvokeScript("eval", script);
            }
            catch
            {
                // Ignoruj b³êdy
            }
        }

        /// <summary>
        /// Wyœwietla okno podgl¹du wydruku.
        /// </summary>
        public static bool ShowPrintPreview(WebBrowser browser)
        {
            try
            {
                browser.InvokeScript("execScript", "window.print();", "JavaScript");
                return true;
            }
            catch
            {
                return Print(browser);
            }
        }

        /// <summary>
        /// Drukuje zawartoœæ WebBrowser.
        /// </summary>
        public static bool Print(WebBrowser browser)
        {
            try
            {
                browser.InvokeScript("print");
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}