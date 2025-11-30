using System;
using System.IO;
using System.Xml;
using System.Xml.Xsl;

namespace eADMwizualizator.Helpers
{
    public static class XsltTransformer
    {
        private static XslCompiledTransform? _cachedTransform;
        private static readonly object _lock = new object();

        /// <summary>
        /// Transformuje plik XML u¿ywaj¹c pliku XSL i zwraca wynikowy HTML
        /// </summary>
        public static string TransformXmlToHtml(string xmlPath, string xslPath)
        {
            if (string.IsNullOrEmpty(xmlPath) || !File.Exists(xmlPath))
                throw new FileNotFoundException("Plik XML nie istnieje", xmlPath);

            if (string.IsNullOrEmpty(xslPath) || !File.Exists(xslPath))
                throw new FileNotFoundException("Plik XSL nie istnieje", xslPath);

            try
            {
                var transform = GetOrCreateTransform(xslPath);

                using var stringWriter = new StringWriter();
                using var xmlWriter = XmlWriter.Create(stringWriter, new XmlWriterSettings
                {
                    OmitXmlDeclaration = false,
                    Indent = true
                });

                transform.Transform(xmlPath, xmlWriter);
                return stringWriter.ToString();
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException($"B³¹d transformacji XML: {ex.Message}", ex);
            }
        }

        private static XslCompiledTransform GetOrCreateTransform(string xslPath)
        {
            lock (_lock)
            {
                if (_cachedTransform == null)
                {
                    _cachedTransform = new XslCompiledTransform();
                    _cachedTransform.Load(xslPath);
                }
                return _cachedTransform;
            }
        }

        /// <summary>
        /// Czyœci cache transformacji (przydatne przy zmianie pliku XSL)
        /// </summary>
        public static void ClearCache()
        {
            lock (_lock)
            {
                _cachedTransform = null;
            }
        }
    }
}