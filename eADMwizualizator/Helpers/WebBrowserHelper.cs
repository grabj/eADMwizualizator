using System;
using System.Runtime.InteropServices;
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
        /// Pokazuje podgl¹d wydruku dla kontrolki WebBrowser
        /// </summary>
        public static bool ShowPrintPreview(WebBrowser? browser)
        {
            if (browser == null)
            {
                System.Diagnostics.Debug.WriteLine("WebBrowser is null");
                return false;
            }

            if (browser.Document == null)
            {
                System.Diagnostics.Debug.WriteLine("WebBrowser.Document is null");
                return false;
            }

            try
            {
                // Pobierz dokument jako dynamic
                dynamic doc = browser.Document;

                // Metoda 1: IOleCommandTarget (najbardziej niezawodna dla WPF WebBrowser)
                try
                {
                    System.Diagnostics.Debug.WriteLine("Próba metody IOleCommandTarget...");
                    
                    object docObject = doc;
                    if (docObject is IOleCommandTarget cmdTarget)
                    {
                        const int OLECMDID_PRINTPREVIEW = 7;
                        const int OLECMDEXECOPT_DODEFAULT = 0;
                        
                        Guid cmdGroup = Guid.Empty;
                        object? input = null;
                        object? output = null;
                        
                        int result = cmdTarget.Exec(
                            ref cmdGroup,
                            OLECMDID_PRINTPREVIEW,
                            OLECMDEXECOPT_DODEFAULT,
                            ref input,
                            ref output);
                        return true;
                    }
                }
                catch { }

                // Metoda 3: Fallback do standardowego drukowania
                try
                {
                    doc.execCommand("Print", false, null);
                    return true;
                }
                catch { }

                return false;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Wykonuje skrypt JavaScript w kontrolce WebBrowser
        /// </summary>
        public static void ExecuteScript(WebBrowser browser, string script)
        {
            try
            {
                browser?.InvokeScript("execScript", new object[] { script, "JavaScript" });
            }
            catch { }
        }

        #region COM Interop

        [ComImport]
        [Guid("B722BCCB-4E68-101B-A2BC-00AA00404770")]
        [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
        private interface IOleCommandTarget
        {
            [PreserveSig]
            int QueryStatus(
                ref Guid pguidCmdGroup,
                uint cCmds,
                [MarshalAs(UnmanagedType.LPArray)] OLECMD[] prgCmds,
                IntPtr pCmdText);

            [PreserveSig]
            int Exec(
                ref Guid pguidCmdGroup,
                uint nCmdID,
                uint nCmdexecopt,
                ref object? pvaIn,
                ref object? pvaOut);
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct OLECMD
        {
            public uint cmdID;
            public uint cmdf;
        }

        #endregion
    }
}