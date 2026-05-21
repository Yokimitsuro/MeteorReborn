// PM-MISSING (MR-original infrastructure). Diálogo de progreso del patcher con 2 fases:
//   1. Download: barra acumula bytes descargados / total.
//   2. Apply: barra acumula patches aplicados / total.

using System;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;

namespace MeteorReborn.Launcher;

public partial class PatcherWindow : Window
{
    private readonly string _gamePath;
    private readonly string _patchSourcePath;
    private readonly string _patchUrlBase;
    private readonly CancellationTokenSource _cts = new();
    private bool _processComplete;
    private int _lastApplyIdx = -1;

    public bool PatchSucceeded { get; private set; }

    public PatcherWindow(string gamePath, string patchSourcePath, string patchUrlBase)
    {
        _gamePath = gamePath;
        _patchSourcePath = patchSourcePath;
        _patchUrlBase = patchUrlBase;
        InitializeComponent();
        Loaded += async (_, _) => await RunAsync();
    }

    private async Task RunAsync()
    {
        var totalCount = PatchManifest.Entries.Length;
        ApProgress.Maximum = totalCount;

        var progress = new Progress<PatcherProgress>(p =>
        {
            // Download progress
            if (p.DownloadTotalBytes > 0)
            {
                DlProgress.Maximum = p.DownloadTotalBytes;
                DlProgress.Value = p.DownloadedBytes;
                int pct = (int)((double)p.DownloadedBytes / p.DownloadTotalBytes * 100);
                TxtDlPercent.Text = $"{pct}%  ({p.DownloadedBytes / 1024 / 1024} / {p.DownloadTotalBytes / 1024 / 1024} MB)";
            }

            // Apply progress: si el status arranca por "Applying" → incrementar idx
            if (p.Status.StartsWith("Applying") && p.CurrentIndex != _lastApplyIdx)
            {
                _lastApplyIdx = p.CurrentIndex;
                ApProgress.Value = p.CurrentIndex;
                int pct = (int)((double)p.CurrentIndex / totalCount * 100);
                TxtApPercent.Text = $"{pct}%  ({p.CurrentIndex}/{totalCount})";
            }

            // Status labels
            if (p.Status.StartsWith("Download"))
                TxtDlStatus.Text = p.Status.Length > 80 ? p.Status[..80] + "..." : p.Status;
            else if (p.Status.StartsWith("Already"))
                TxtDlStatus.Text = p.Status;
            else if (p.Status.StartsWith("Applying"))
                TxtApStatus.Text = p.Status;

            TxtCurrent.Text = p.CurrentFileName;

            if (p.IsComplete)
            {
                _processComplete = true;
                BtnCancel.Content = "Close";
                if (p.HasError)
                {
                    TxtCurrent.Text = "Failed.";
                    MessageBox.Show(this, p.ErrorMessage ?? "Unknown error.",
                        "Patch error", MessageBoxButton.OK, MessageBoxImage.Error);
                    PatchSucceeded = false;
                }
                else
                {
                    DlProgress.Value = DlProgress.Maximum;
                    TxtDlPercent.Text = "100%";
                    ApProgress.Value = ApProgress.Maximum;
                    TxtApPercent.Text = "100%";
                    TxtDlStatus.Text = "Download complete.";
                    TxtApStatus.Text = p.Status;
                    PatchSucceeded = true;
                }
            }
        });

        try
        {
            await Patcher.ApplyAsync(_gamePath, _patchSourcePath, _patchUrlBase, progress, _cts.Token);
        }
        catch (OperationCanceledException)
        {
            _processComplete = true;
            TxtCurrent.Text = "Cancelled.";
            BtnCancel.Content = "Close";
        }
        catch (Exception ex)
        {
            _processComplete = true;
            TxtCurrent.Text = "Failed.";
            BtnCancel.Content = "Close";
            MessageBox.Show(this, ex.Message, "Patch error",
                MessageBoxButton.OK, MessageBoxImage.Error);
            PatchSucceeded = false;
        }
    }

    private void OnCancelClick(object sender, RoutedEventArgs e)
    {
        if (_processComplete) { Close(); return; }
        if (MessageBox.Show(this, "Cancel the update?", "Cancel",
                MessageBoxButton.YesNo, MessageBoxImage.Warning) == MessageBoxResult.Yes)
        {
            TxtCurrent.Text = "Cancelling, please wait...";
            _cts.Cancel();
        }
    }
}
