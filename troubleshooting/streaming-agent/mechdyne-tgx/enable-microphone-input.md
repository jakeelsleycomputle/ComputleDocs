---
description: >-
  This guide explains how to enable microphone redirection on Computle
  workstations using Mechdyne TGX and the Teradici Virtual Audio Driver.
---

# Enable Microphone Input

### Automated Setup

#### Prerequisites

* Run PowerShell as Administrator
* Ensure TGX is installed on the workstation

{% hint style="info" %}
**To enable script execution, run:**

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
{% endhint %}

#### Usage

1. Copy the setup script
2. Open PowerShell ISE as Administrator
3. Paste the script into the white window
4. Click the green run button, or press the F5 key

```powershell
param(
    [switch]$Force,
    [string]$DownloadPath = "$env:TEMP\ComputleAudio"
)

Write-Host "Computle Workstation TGX Microphone Redirection Setup" -ForegroundColor Green

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

$downloadUrl = "https://downloads.oncomputle.com/virtual-audio-driver.exe"
$exeFile = "$DownloadPath\virtual-audio-driver.exe"

if (!(Test-Path $DownloadPath)) {
    New-Item -ItemType Directory -Path $DownloadPath -Force | Out-Null
}

Invoke-WebRequest -Uri $downloadUrl -OutFile $exeFile -UseBasicParsing

$installProcess = Start-Process -FilePath $exeFile -ArgumentList "/S" -Wait -PassThru

if ($installProcess.ExitCode -ne 0 -and $installProcess.ExitCode -ne 3010) {
    Write-Error "Installation failed on this Computle workstation with exit code: $($installProcess.ExitCode)"
    exit 1
}

Remove-Item $DownloadPath -Recurse -Force

if (!$Force) {
    Write-Host "Computle workstation microphone redirection setup completed successfully!" -ForegroundColor Green
    $reboot = Read-Host "Restart computer? (y/n)"
    if ($reboot -eq 'y' -or $reboot -eq 'Y') {
        Restart-Computer -Force
    }
}
```
