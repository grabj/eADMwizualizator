using System;
using System.IO;
using System.Linq;
using System.Threading;

namespace eAMDwizualizator.Helpers
{
    public static class TempDirectoryManager
    {
        public static readonly string BaseTempDir = Path.Combine(Environment.CurrentDirectory, "temp");

        public static string CreateRunTempDir()
        {
            Directory.CreateDirectory(BaseTempDir);
            var name = DateTime.UtcNow.ToString("yyyyMMdd_HHmmss_fff") + "_" + Guid.NewGuid().ToString("N").Substring(0, 8);
            var dir = Path.Combine(BaseTempDir, name);
            Directory.CreateDirectory(dir);
            return dir;
        }

        public static void CleanupOldRunDirs(TimeSpan maxAge, int attempts = 5, int delayMs = 200)
        {
            try
            {
                if (!Directory.Exists(BaseTempDir)) return;
                var dirs = Directory.GetDirectories(BaseTempDir);
                foreach (var dir in dirs)
                {
                    try
                    {
                        var info = new DirectoryInfo(dir);
                        var age = DateTime.UtcNow - info.CreationTimeUtc;
                        if (age > maxAge)
                        {
                            TryDeleteDirectoryWithRetries(dir, attempts, delayMs);
                        }
                    }
                    catch
                    {
                        // per-dir errors ignored
                    }
                }
            }
            catch
            {
                // global errors ignored to avoid blocking start
            }
        }

        public static void TryDeleteDirectoryWithRetries(string path, int attempts = 5, int delayMs = 200)
        {
            if (string.IsNullOrEmpty(path) || !Directory.Exists(path)) return;
            for (int i = 0; i < attempts; i++)
            {
                try
                {
                    Directory.Delete(path, true);
                    return;
                }
                catch (IOException) { Thread.Sleep(delayMs); }
                catch (UnauthorizedAccessException) { Thread.Sleep(delayMs); }
                catch { Thread.Sleep(delayMs); }
            }
        }
    }
}