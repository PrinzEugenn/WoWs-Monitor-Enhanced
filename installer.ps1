param([ValidateSet('install','restore','check','')][string]$Action = '', [string]$Target = "$env:LOCALAPPDATA\Programs\wows-monitor")
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$node = Join-Path $root 'runtime\node.exe'
$patch = Join-Path $root 'scripts\patch.js'
function Invoke-Patch([string]$operation, [string]$folder) {
    if (!(Test-Path -LiteralPath $node)) { throw 'Bundled Node.js runtime is missing. Extract all files from the ZIP first.' }
    if (!(Test-Path -LiteralPath $patch)) { throw 'Patch files are missing. Extract all files from the ZIP first.' }
    $output = & $node $patch $operation $folder 2>&1 | Out-String
    if ($LASTEXITCODE -ne 0) { throw $output.Trim() }
    return $output.Trim()
}
if ($Action) { try { Invoke-Patch $Action $Target; exit 0 } catch { [Console]::Error.WriteLine($_.Exception.Message); exit 1 } }
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()
$form = New-Object System.Windows.Forms.Form
$form.Text = 'WoWs Monitor Enhanced'; $form.Size = New-Object System.Drawing.Size(620,240); $form.StartPosition = 'CenterScreen'; $form.FormBorderStyle = 'FixedDialog'; $form.MaximizeBox = $false
$label = New-Object System.Windows.Forms.Label; $label.Text = 'WoWs Monitor folder / 原版安装目录:'; $label.SetBounds(18,16,550,22); $form.Controls.Add($label)
$path = New-Object System.Windows.Forms.TextBox; $path.Text = $Target; $path.SetBounds(20,43,460,25); $form.Controls.Add($path)
$browse = New-Object System.Windows.Forms.Button; $browse.Text = 'Browse / 浏览'; $browse.SetBounds(485,41,105,28); $form.Controls.Add($browse)
$browse.Add_Click({ $dialog = New-Object System.Windows.Forms.FolderBrowserDialog; if ($dialog.ShowDialog() -eq 'OK') { $path.Text = $dialog.SelectedPath }; $dialog.Dispose() })
$help = New-Object System.Windows.Forms.Label; $help.Text = 'Close WoWs Monitor, including its tray icon, before installing or restoring.`r`n请先完全退出 WoWs Monitor（包括系统托盘）。'.Replace('`r`n',"`r`n"); $help.SetBounds(20,80,570,40); $form.Controls.Add($help)
foreach ($spec in @(@('Install / 安装','install',20),@('Restore / 恢复原版','restore',200),@('Check / 检查','check',380))) {
    $button = New-Object System.Windows.Forms.Button; $button.Text = $spec[0]; $button.SetBounds([int]$spec[2],132,170,34); $button.Tag = $spec[1]; $form.Controls.Add($button)
    $button.Add_Click({ try { $form.Cursor = [System.Windows.Forms.Cursors]::WaitCursor; $message = Invoke-Patch $this.Tag $path.Text; [System.Windows.Forms.MessageBox]::Show($message,'WoWs Monitor Enhanced','OK','Information') | Out-Null } catch { [System.Windows.Forms.MessageBox]::Show($_.Exception.Message,'WoWs Monitor Enhanced','OK','Error') | Out-Null } finally { $form.Cursor = [System.Windows.Forms.Cursors]::Default } })
}
[void]$form.ShowDialog()
