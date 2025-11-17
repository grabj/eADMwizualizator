using System;
using System.Windows;

namespace eAMDwizualizator.Helpers
{
    internal static class FontSizeManager
    {
        public static void SetAppFontSize(double size)
        {
            if (Application.Current == null) return;
            Application.Current.Resources["AppFontSize"] = size;
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
