using System;
using System.Windows;

namespace eADMwizualizator.Helpers
{
    public static class FontSizeManager
    {
        private const double MinButtonFontSize = 16.0;
        private const double MinSmallButtonFontSize = 13.0;
        public static void SetAppFontSize(double size)
        {
            Application.Current.Resources["AppFontSize"] = size;
            Application.Current.Resources["AppFontSizeLarge"] = size + 4;
            Application.Current.Resources["AppFontSizeBig"] = size + 2;
            Application.Current.Resources["AppFontSizeSmallButton"] = Math.Max(size - 5, MinSmallButtonFontSize);
            Application.Current.Resources["AppFontSizeButton"] = Math.Max(size + 3, MinButtonFontSize);
        }

        public static double GetAppFontSize(double defaultSize)
        {
            if (Application.Current == null) return defaultSize;
            if (Application.Current.Resources.Contains("AppFontSize") && Application.Current.Resources["AppFontSize"] is double value)
            {
                return value;
            }
            return defaultSize;
        }
    }
}
