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

#### Usage

1. Copy the setup script
2. Open PowerShell ISE as Administrator
3. Paste the script into the white window
4. Click the green run button, or press the F5 key

```powershell
# Computle Workstation TGX Microphone Redirection Setup Script
# Run as Administrator

param(
    [switch]$Force,
    [string]$DownloadPath = "$env:TEMP\TeradiciAudio"
)

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator. Please run PowerShell as Administrator and try again."
    exit 1
}

$downloadUrl = "https://downloads.oncomputle.com/Teradici_Virtual_Audio_Driver_x64_1.2.2.zip"
$zipFile = "$DownloadPath\Teradici_Virtual_Audio_Driver_x64_1.2.2.zip"
$extractPath = "$DownloadPath\Extract"
$installerPath = "$extractPath\PCoIP_ComponentInstaller.exe"

Write-Host "Computle Workstation TGX Microphone Redirection Setup" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green

# Create download directory
if (!(Test-Path $DownloadPath)) {
    New-Item -ItemType Directory -Path $DownloadPath -Force | Out-Null
    Write-Host "Created download directory: $DownloadPath" -ForegroundColor Yellow
}

# Create extraction directory
if (!(Test-Path $extractPath)) {
    New-Item -ItemType Directory -Path $extractPath -Force | Out-Null
}

try {
    # Download the audio driver
    Write-Host "Downloading Teradici Virtual Audio Driver..." -ForegroundColor Yellow
    Write-Host "Source: $downloadUrl" -ForegroundColor Cyan
    
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($downloadUrl, $zipFile)
    
    if (!(Test-Path $zipFile)) {
        throw "Download failed - file not found at $zipFile"
    }
    
    Write-Host "Download completed successfully" -ForegroundColor Green
    
    # Extract the ZIP file
    Write-Host "Extracting audio driver package..." -ForegroundColor Yellow
    
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile, $extractPath)
    
    if (!(Test-Path $installerPath)) {
        throw "Installer not found after extraction at $installerPath"
    }
    
    Write-Host "Extraction completed successfully" -ForegroundColor Green
    
    # Run the installer silently
    Write-Host "Installing Teradici Virtual Audio Driver..." -ForegroundColor Yellow
    Write-Host "Running: $installerPath /S" -ForegroundColor Cyan
    
    $installProcess = Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait -PassThru
    
    if ($installProcess.ExitCode -eq 0) {
        Write-Host "Audio driver installation completed successfully" -ForegroundColor Green
    } else {
        throw "Installation failed with exit code: $($installProcess.ExitCode)"
    }
    
    # Cleanup downloaded files
    Write-Host "Cleaning up temporary files..." -ForegroundColor Yellow
    Remove-Item $DownloadPath -Recurse -Force
    Write-Host "Cleanup completed" -ForegroundColor Green
    
    Write-Host "`nComputle workstation microphone redirection setup completed successfully!" -ForegroundColor Green
    Write-Host "The Teradici Virtual Audio Driver has been installed on this Computle workstation." -ForegroundColor Green
    
    if (!$Force) {
        Write-Host "`nIMPORTANT: A system reboot is required to complete the installation." -ForegroundColor Red
        $reboot = Read-Host "Restart computer now? (y/n)"
        if ($reboot -eq 'y' -or $reboot -eq 'Y') {
            Write-Host "Restarting system..." -ForegroundColor Yellow
            Restart-Computer -Force
        } else {
            Write-Host "Please restart the system manually to complete the microphone redirection setup." -ForegroundColor Yellow
        }
    } else {
        Write-Host "System reboot required. Please restart the Computle workstation to complete setup." -ForegroundColor Yellow
    }
    
} catch {
    Write-Error "Setup failed: $($_.Exception.Message)"
    
    # Cleanup on failure
    if (Test-Path $DownloadPath) {
        Write-Host "Cleaning up after failure..." -ForegroundColor Yellow
        Remove-Item $DownloadPath -Recurse -Force -ErrorAction SilentlyContinue
    }
    
    exit 1
}

Write-Host "`nAfter reboot, verify microphone redirection is working by:" -ForegroundColor Cyan
Write-Host "1. Connecting a microphone to the client device" -ForegroundColor Cyan
Write-Host "2. Testing audio input in the remote Computle session" -ForegroundColor Cyan
Write-Host "3. Checking Windows Sound settings for Teradici Virtual Audio devices" -ForegroundColor Cyan
```
