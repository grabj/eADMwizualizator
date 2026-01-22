using System;
using System.Threading.Tasks;
using System.Windows;
using Microsoft.Web.WebView2.Wpf;
using Microsoft.Web.WebView2.Core;

namespace eADMwizualizator.Helpers
{
    public static class WebView2Helper
    {
        public static readonly DependencyProperty HtmlProperty = DependencyProperty.RegisterAttached(
            "Html",
            typeof(string),
            typeof(WebView2Helper),
            new PropertyMetadata(null, OnHtmlChanged));

        public static string? GetHtml(DependencyObject obj)
        {
            return (string?)obj.GetValue(HtmlProperty);
        }

        public static void SetHtml(DependencyObject obj, string? value)
        {
            obj.SetValue(HtmlProperty, value);
        }

        private static async void OnHtmlChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is WebView2 webView && e.NewValue is string html && !string.IsNullOrEmpty(html))
            {
                await EnsureWebView2Async(webView);
                webView.NavigateToString(html);
            }
        }

        private static async Task EnsureWebView2Async(WebView2 webView)
        {
            if (webView.CoreWebView2 == null)
            {
                await webView.EnsureCoreWebView2Async();
            }
        }

        /// <summary>
        /// Wykonuje skrypt JavaScript w WebView2.
        /// </summary>
        public static async Task ExecuteScriptAsync(WebView2 webView, string script)
        {
            try
            {
                await EnsureWebView2Async(webView);
                await webView.ExecuteScriptAsync(script);
            }
            catch
            {
                // Ignoruj b³êdy
            }
        }

        /// <summary>
        /// Wyœwietla okno podgl¹du wydruku.
        /// </summary>
        public static async Task<bool> ShowPrintPreviewAsync(WebView2 webView)
        {
            try
            {
                await EnsureWebView2Async(webView);
                webView.CoreWebView2.ShowPrintUI();
                return true;
            }
            catch
            {
                return await PrintAsync(webView);
            }
        }

        /// <summary>
        /// Drukuje zawartoœæ WebView2.
        /// </summary>
        public static async Task<bool> PrintAsync(WebView2 webView)
        {
            try
            {
                await EnsureWebView2Async(webView);
                await webView.CoreWebView2.PrintAsync(null);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}