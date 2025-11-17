using Microsoft.Win32;
using System.Configuration;
using System.Data;
using System.IO;
using System.Windows;
using System.Windows.Threading;
using System.Xml.Linq;

namespace eADMwizualizator
{
    public partial class App : Application
    {
        private static readonly string SciezkaAktywnejPaczki = @".\temp";
        private const double DefaultFontSize = 12.0;

        protected override void OnStartup(StartupEventArgs e)
        {
            // Ustaw domyślny rozmiar czcionki globalnie przed inicjalizacją okien, żeby Window/MainWindow mogły od razu odczytać zasób.
            try
            {
                if (!this.Resources.Contains("AppFontSize") || !(this.Resources["AppFontSize"] is double))
                {
                    this.Resources["AppFontSize"] = DefaultFontSize;
                }
            }
            catch
            {
                // Nie przerywamy uruchamiania aplikacji, ale pozostawiamy fallback.
            }

            base.OnStartup(e);

            // Asynchroniczne sprzątanie starych katalogów temp (np. starszych niż dzień)
            System.Threading.ThreadPool.QueueUserWorkItem(_ =>
            {
                Helpers.TempDirectoryManager.CleanupOldRunDirs(TimeSpan.FromDays(1));
            });

            // Subskrybuj różne scenariusze zamknięcia — wszystkie wywołują jedną metodę sprzątającą.
            this.Exit += (object? sender, ExitEventArgs ev) => CleanTemp();
            this.DispatcherUnhandledException += (object? sender, DispatcherUnhandledExceptionEventArgs ev) => CleanTemp();
            AppDomain.CurrentDomain.ProcessExit += (object? sender, EventArgs ev) => CleanTemp();
            SystemEvents.SessionEnding += (object? sender, SessionEndingEventArgs ev) => CleanTemp();
        }

        protected override void OnExit(ExitEventArgs e)
        {
            // Dodatkowe wywołanie przy normalnym zamknięciu
            CleanTemp();
            base.OnExit(e);
        }

        private static void CleanTemp()
        {
            try
            {
                if (!Directory.Exists(SciezkaAktywnejPaczki))
                    return;

                // usunięcie rekursywne
                Directory.Delete(SciezkaAktywnejPaczki, true);
            }
            catch
            {
                // Ignorujemy błędy — nic nie powinno blokować zamknięcia aplikacji.
            }
        }
    }
}
