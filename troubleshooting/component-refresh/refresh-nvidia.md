# Refresh NVIDIA

**Prerequisite**

Ensure that Remote Desktop is enabled and that you can connect to the machine. &#x20;

{% hint style="info" %}
Enable Remote Desktop by navigating to Settings > Remote Desktop Settings
{% endhint %}

***

**Refresh NVIDIA**

{% hint style="info" %}
This script installs NVIDIA RTX Driver Release 550 R550 U8 (552.86). This is the latest version as of August 1st 2024.
{% endhint %}

1. VIa Remote Desktop, connect to your Computle machine.
2. As an Administrator, launch PowerShell ISE.
3. Paste the following code into the PowerShell script pane.

```sh
$nvidiaFileUrl = "https://uk.download.nvidia.com/Windows/Quadro_Certified/552.86/552.86-quadro-rtx-desktop-notebook-win10-win11-64bit-international-dch-whql.exe"
$nvidiaSavePath = "C:\Windows\Computle"
$nvidiaInstallerPath = "$nvidiaSavePath\nvidia_installer.exe"
$nvidiaExtractPath = "C:\NVIDIA\DisplayDriver\552.86\Win11_Win10-DCH_64\International"
$nvidiaLogFilePath = "$nvidiaSavePath\nvidia_install_log.txt"

if (-not (Test-Path -Path $nvidiaSavePath)) {
    New-Item -ItemType Directory -Path $nvidiaSavePath -Force
}

$webClient = New-Object System.Net.WebClient

try {
    $webClient.DownloadFile($nvidiaFileUrl, $nvidiaInstallerPath)
} catch {
    Write-Error "An error occurred during file download: $_"
} finally {
    $webClient.Dispose()
}

Write-Output "NVIDIA installer downloaded to $nvidiaInstallerPath" | Out-File -FilePath $nvidiaLogFilePath -Append

Start-Process -FilePath $nvidiaInstallerPath -ArgumentList "-s", "-noreboot", "-noeula" -Wait -NoNewWindow | Out-Null

if (Test-Path -Path $nvidiaExtractPath) {
    Write-Output "NVIDIA installer extracted to $nvidiaExtractPath" | Out-File -FilePath $nvidiaLogFilePath -Append
} else {
    Write-Error "NVIDIA installer extraction failed."
}

$extractedFiles = Get-ChildItem -Path $nvidiaExtractPath -Recurse
$extractedFiles | ForEach-Object { Write-Output $_.FullName } | Out-File -FilePath $nvidiaLogFilePath -Append

$nvidiaSetupExePath = Get-ChildItem -Path $nvidiaExtractPath -Filter "setup.exe" -Recurse | Select-Object -First 1 -ExpandProperty FullName

if ($nvidiaSetupExePath) {
    Write-Output "Setup.exe found at $nvidiaSetupExePath" | Out-File -FilePath $nvidiaLogFilePath -Append
} else {
    Write-Error "Setup.exe not found in the extracted folder."
}

if ($nvidiaSetupExePath) {
    Start-Process -FilePath $nvidiaSetupExePath -ArgumentList "/s" -Wait -NoNewWindow | Out-Null
    Write-Output "NVIDIA driver installed successfully." | Out-File -FilePath $nvidiaLogFilePath -Append
} else {
    Write-Error "Setup.exe not found in the extracted folder."
}

```

5. Click Run or F5 to start the process.&#x20;
