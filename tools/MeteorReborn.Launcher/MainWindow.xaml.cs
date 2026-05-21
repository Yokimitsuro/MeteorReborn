using System.IO;
using System.Net.Http;
using System.Net.Http.Json;
using System.Text.Json;
using System.Windows;
using System.Windows.Input;
using Microsoft.Win32;

namespace MeteorReborn.Launcher;

public partial class MainWindow : Window
{
    private static readonly HttpClient Http = new() { Timeout = TimeSpan.FromSeconds(10) };
    private static readonly string SettingsPath = Path.Combine(
        Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
        "MeteorReborn", "launcher.json");

    public MainWindow()
    {
        InitializeComponent();
        LoadSettings();
        TxtUsername.Focus();
    }

    private async void OnLoginClick(object sender, RoutedEventArgs e)
    {
        var username = TxtUsername.Text.Trim();
        var password = TxtPassword.Password;

        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
        {
            ShowError("Enter username and password.");
            return;
        }

        var gamePath = TxtGamePath.Text.Trim();
        var gameExe = Path.Combine(gamePath, "ffxivgame.exe");
        if (!File.Exists(gameExe))
        {
            ShowError($"ffxivgame.exe not found in:\n{gamePath}");
            return;
        }

        // FINISH-PM (MR-original): chequeo de versión + patcher antes de lanzar.
        if (!VersionChecker.IsUpToDate(gamePath))
        {
            var current = VersionChecker.ReadGameVersion(gamePath) ?? "(unknown)";
            var msg = $"Your FFXIV client is out of date.\n\n" +
                      $"  Current version: {current}\n" +
                      $"  Required version: {VersionChecker.TargetGameVersion} (1.23b)\n\n" +
                      $"Update now from:\n  {TxtPatchSource.Text.Trim()}\n\nThis can take a while.";
            var choice = MessageBox.Show(this, msg, "Outdated Game Client",
                MessageBoxButton.YesNo, MessageBoxImage.Warning);
            if (choice != MessageBoxResult.Yes)
            {
                ShowError("Cannot launch: game client is out of date.");
                return;
            }

            SaveSettings();
            var patcher = new PatcherWindow(
                gamePath,
                ResolvePatchSource(TxtPatchSource.Text.Trim()),
                string.IsNullOrWhiteSpace(TxtPatchUrl.Text) ? PatchManifest.DefaultUrlBase : TxtPatchUrl.Text.Trim()
            ) { Owner = this };
            patcher.ShowDialog();
            if (!patcher.PatchSucceeded)
            {
                ShowError("Patch process did not complete. Cannot launch.");
                return;
            }
        }

        SetBusy(true, "Connecting to server...");
        SaveSettings();

        try
        {
            var loginUrl = TxtLoginServer.Text.Trim().TrimEnd('/');
            var response = await Http.PostAsJsonAsync($"{loginUrl}/api/auth/login",
                new { Username = username, Password = password });

            if (!response.IsSuccessStatusCode)
            {
                ShowError("Login failed: incorrect username or password.");
                SetBusy(false);
                return;
            }

            var json = await response.Content.ReadFromJsonAsync<JsonElement>();
            var sid = json.GetProperty("sessionId").GetString()!;

            if (sid.Length != 56)
            {
                ShowError($"Server returned a sessionId of {sid.Length} chars (expected 56).");
                SetBusy(false);
                return;
            }

            SetBusy(true, "Launching FINAL FANTASY XIV...");

            var lobbyHost = TxtLobbyServer.Text.Trim().Split(':')[0];
            var (ok, pid, detail) = GameLauncher.Launch(gamePath, lobbyHost, sid);

            if (ok)
            {
                Application.Current.Shutdown();
            }
            else
            {
                ShowError(detail);
                SetBusy(false);
            }
        }
        catch (HttpRequestException)
        {
            ShowError("Could not connect to login server.\nMake sure the server is running.");
            SetBusy(false);
        }
        catch (TaskCanceledException)
        {
            ShowError("Connection to server timed out.");
            SetBusy(false);
        }
        catch (Exception ex)
        {
            ShowError($"Error: {ex.Message}");
            SetBusy(false);
        }
    }

    private async void OnRegisterClick(object sender, RoutedEventArgs e)
    {
        var username = TxtUsername.Text.Trim();
        var password = TxtPassword.Password;

        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
        {
            ShowError("Enter username and password to create an account.");
            return;
        }

        SetBusy(true, "Creating account...");

        try
        {
            var loginUrl = TxtLoginServer.Text.Trim().TrimEnd('/');
            var response = await Http.PostAsJsonAsync($"{loginUrl}/api/account",
                new { Username = username, Password = password });

            if (response.IsSuccessStatusCode)
            {
                TxtError.Visibility = Visibility.Collapsed;
                TxtStatus.Text = "Account created. You can now log in.";
                TxtStatus.Foreground = FindResource("AccentGold") as System.Windows.Media.Brush;
                TxtStatus.Visibility = Visibility.Visible;
            }
            else
            {
                var body = await response.Content.ReadAsStringAsync();
                ShowError(response.StatusCode == System.Net.HttpStatusCode.BadRequest
                    ? "Username already exists."
                    : $"Error creating account: {body}");
            }
        }
        catch (HttpRequestException)
        {
            ShowError("Could not connect to server.");
        }
        catch (Exception ex)
        {
            ShowError($"Error: {ex.Message}");
        }
        finally
        {
            SetBusy(false);
        }
    }

    private void OnBrowseClick(object sender, RoutedEventArgs e)
    {
        var dialog = new OpenFileDialog
        {
            Title = "Select ffxivgame.exe",
            Filter = "ffxivgame.exe|ffxivgame.exe|All files|*.*",
            InitialDirectory = TxtGamePath.Text.Trim(),
        };

        if (dialog.ShowDialog() == true)
        {
            TxtGamePath.Text = Path.GetDirectoryName(dialog.FileName) ?? "";
        }
    }

    private void OnInputKeyDown(object sender, KeyEventArgs e)
    {
        if (e.Key == Key.Enter)
            OnLoginClick(sender, e);
    }

    private void ShowError(string message)
    {
        TxtStatus.Visibility = Visibility.Collapsed;
        TxtError.Text = message;
        TxtError.Visibility = Visibility.Visible;
    }

    private void SetBusy(bool busy, string? status = null)
    {
        BtnLogin.IsEnabled = !busy;
        if (busy && status != null)
        {
            TxtError.Visibility = Visibility.Collapsed;
            TxtStatus.Text = status;
            TxtStatus.Foreground = FindResource("TextSecondary") as System.Windows.Media.Brush;
            TxtStatus.Visibility = Visibility.Visible;
        }
        else if (!busy)
        {
            TxtStatus.Visibility = Visibility.Collapsed;
        }
    }

    private void LoadSettings()
    {
        TxtGamePath.Text = @"E:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV";
        TxtPatchSource.Text = DefaultPatchSource();
        TxtPatchUrl.Text = PatchManifest.DefaultUrlBase;

        if (!File.Exists(SettingsPath)) return;

        try
        {
            var json = JsonSerializer.Deserialize<LauncherSettings>(File.ReadAllText(SettingsPath));
            if (json == null) return;
            if (!string.IsNullOrEmpty(json.GamePath)) TxtGamePath.Text = json.GamePath;
            if (!string.IsNullOrEmpty(json.LoginServer)) TxtLoginServer.Text = json.LoginServer;
            if (!string.IsNullOrEmpty(json.LobbyServer)) TxtLobbyServer.Text = json.LobbyServer;
            if (!string.IsNullOrEmpty(json.Language)) TxtLanguage.Text = json.Language;
            if (!string.IsNullOrEmpty(json.Username)) TxtUsername.Text = json.Username;
            if (!string.IsNullOrEmpty(json.PatchSource)) TxtPatchSource.Text = json.PatchSource;
            if (!string.IsNullOrEmpty(json.PatchUrlBase)) TxtPatchUrl.Text = json.PatchUrlBase;
        }
        catch { /* ignore corrupted settings */ }
    }

    private void SaveSettings()
    {
        try
        {
            var dir = Path.GetDirectoryName(SettingsPath)!;
            Directory.CreateDirectory(dir);
            var json = JsonSerializer.Serialize(new LauncherSettings
            {
                GamePath = TxtGamePath.Text.Trim(),
                LoginServer = TxtLoginServer.Text.Trim(),
                LobbyServer = TxtLobbyServer.Text.Trim(),
                Language = TxtLanguage.Text.Trim(),
                Username = TxtUsername.Text.Trim(),
                PatchSource = TxtPatchSource.Text.Trim(),
                PatchUrlBase = TxtPatchUrl.Text.Trim(),
            }, new JsonSerializerOptions { WriteIndented = true });
            File.WriteAllText(SettingsPath, json);
        }
        catch { /* non-critical */ }
    }

    // Default patch source: <repo>/data/clientPatch al lado del launcher.exe (debug:
    // tools/MeteorReborn.Launcher/bin/... → sube hasta Meteor Reborn/data/clientPatch).
    private static string DefaultPatchSource()
    {
        var exeDir = AppContext.BaseDirectory;
        // Busca hasta 6 niveles arriba un `data/clientPatch`.
        var dir = new DirectoryInfo(exeDir);
        for (int i = 0; i < 6 && dir != null; i++, dir = dir.Parent)
        {
            var candidate = Path.Combine(dir.FullName, "data", "clientPatch");
            if (Directory.Exists(candidate)) return candidate;
        }
        return @".\data\clientPatch";
    }

    // Resuelve la ruta del patch source relativa al exeDir si es relativa.
    private static string ResolvePatchSource(string input)
    {
        if (Path.IsPathRooted(input)) return input;
        return Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, input));
    }
}

internal sealed class LauncherSettings
{
    public string? GamePath { get; set; }
    public string? LoginServer { get; set; }
    public string? LobbyServer { get; set; }
    public string? Language { get; set; }
    public string? Username { get; set; }
    public string? PatchSource { get; set; }
    public string? PatchUrlBase { get; set; }
}
