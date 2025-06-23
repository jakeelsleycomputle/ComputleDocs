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
#
# If you get "execution of scripts is disabled" error, run this first:
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#
# Or run the script directly with:
# PowerShell -ExecutionPolicy Bypass -File "Setup-TGX-Microphone.ps1"

param(
    [switch]$Force,
    [string]$DownloadPath = "$env:TEMP\TeradiciAudio"
)

# Function to handle execution policy issues
function Test-ExecutionPolicy {
    try {
        $policy = Get-ExecutionPolicy -Scope CurrentUser
        if ($policy -eq "Restricted" -or $policy -eq "AllSigned") {
            Write-Host "Current execution policy is restrictive: $policy" -ForegroundColor Yellow
            Write-Host "To fix this, run one of the following commands:" -ForegroundColor Yellow
            Write-Host "  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser" -ForegroundColor Cyan
            Write-Host "  OR restart PowerShell and run:" -ForegroundColor Yellow
            Write-Host "  PowerShell -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -ForegroundColor Cyan
            
            if (!$Force) {
                $fix = Read-Host "Would you like to automatically set the execution policy to RemoteSigned for current user? (y/n)"
                if ($fix -eq 'y' -or $fix -eq 'Y') {
                    try {
                        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
                        Write-Host "Execution policy updated successfully" -ForegroundColor Green
                        return $true
                    }
                    catch {
                        Write-Error "Failed to update execution policy: $($_.Exception.Message)"
                        return $false
                    }
                }
            }
            return $false
        }
        return $true
    }
    catch {
        Write-Warning "Could not check execution policy: $($_.Exception.Message)"
        return $true
    }
}

# Check execution policy first
if (!(Test-ExecutionPolicy)) {
    Write-Host "Please fix the execution policy and run the script again." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    Write-Host "Please right-click PowerShell and select 'Run as Administrator', then try again." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
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
    
    try {
        # Use Invoke-WebRequest with better error handling
        $progressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFile -UseBasicParsing
        $progressPreference = 'Continue'
    }
    catch {
        Write-Host "Primary download method failed, trying alternative..." -ForegroundColor Yellow
        try {
            $webClient = New-Object System.Net.WebClient
            $webClient.DownloadFile($downloadUrl, $zipFile)
        }
        catch {
            throw "Both download methods failed. Error: $($_.Exception.Message)"
        }
    }
    
    if (!(Test-Path $zipFile) -or (Get-Item $zipFile).Length -eq 0) {
        throw "Download failed - file not found or empty at $zipFile"
    }
    
    $fileSize = [math]::Round((Get-Item $zipFile).Length / 1MB, 2)
    Write-Host "Download completed successfully ($fileSize MB)" -ForegroundColor Green
    
    # Extract the ZIP file
    Write-Host "Extracting audio driver package..." -ForegroundColor Yellow
    
    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile, $extractPath)
    }
    catch {
        # Try alternative extraction method
        Write-Host "Primary extraction failed, trying COM object method..." -ForegroundColor Yellow
        try {
            $shell = New-Object -ComObject Shell.Application
            $zip = $shell.NameSpace($zipFile)
            $dest = $shell.NameSpace($extractPath)
            $dest.CopyHere($zip.Items(), 4)
        }
        catch {
            throw "Both extraction methods failed. Error: $($_.Exception.Message)"
        }
    }
    
    # Find the installer (it might be in a subdirectory)
    $installerFile = Get-ChildItem -Path $extractPath -Name "PCoIP_ComponentInstaller.exe" -Recurse | Select-Object -First 1
    if (!$installerFile) {
        $availableFiles = Get-ChildItem -Path $extractPath -Recurse | Select-Object -ExpandProperty Name
        throw "PCoIP_ComponentInstaller.exe not found after extraction. Available files: $($availableFiles -join ', ')"
    }
    
    $installerPath = Join-Path $extractPath $installerFile.FullName
    Write-Host "Extraction completed successfully" -ForegroundColor Green
    Write-Host "Installer found at: $installerPath" -ForegroundColor Cyan
    
    # Run the installer silently
    Write-Host "Installing Teradici Virtual Audio Driver..." -ForegroundColor Yellow
    Write-Host "Running: $installerPath /S" -ForegroundColor Cyan
    
    try {
        $installProcess = Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait -PassThru -NoNewWindow
        
        if ($installProcess.ExitCode -eq 0) {
            Write-Host "Audio driver installation completed successfully" -ForegroundColor Green
        } elseif ($installProcess.ExitCode -eq 3010) {
            Write-Host "Audio driver installation completed (reboot required)" -ForegroundColor Green
        } else {
            # Try to provide more specific error information
            $errorMessage = switch ($installProcess.ExitCode) {
                1603 { "Fatal error during installation" }
                1605 { "This action is only valid for products that are currently installed" }
                1619 { "Installation package could not be opened" }
                1633 { "Installation package is not supported on this platform" }
                default { "Installation failed with exit code: $($installProcess.ExitCode)" }
            }
            throw $errorMessage
        }
    }
    catch {
        throw "Failed to run installer: $($_.Exception.Message)"
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
    Write-Host "`nSetup failed with error:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    
    # Provide specific troubleshooting advice
    if ($_.Exception.Message -like "*download*") {
        Write-Host "`nTroubleshooting suggestions:" -ForegroundColor Yellow
        Write-Host "- Check internet connectivity" -ForegroundColor Yellow
        Write-Host "- Verify the download URL is accessible" -ForegroundColor Yellow
        Write-Host "- Try running with different network settings" -ForegroundColor Yellow
    }
    elseif ($_.Exception.Message -like "*extraction*") {
        Write-Host "`nTroubleshooting suggestions:" -ForegroundColor Yellow
        Write-Host "- Ensure sufficient disk space" -ForegroundColor Yellow
        Write-Host "- Check if antivirus is blocking extraction" -ForegroundColor Yellow
        Write-Host "- Try manual extraction" -ForegroundColor Yellow
    }
    elseif ($_.Exception.Message -like "*installation*") {
        Write-Host "`nTroubleshooting suggestions:" -ForegroundColor Yellow
        Write-Host "- Ensure no other audio drivers are installing" -ForegroundColor Yellow
        Write-Host "- Try running the installer manually as Administrator" -ForegroundColor Yellow
        Write-Host "- Check Windows Event Logs for detailed error information" -ForegroundColor Yellow
    }
    
    Write-Host "`nFor manual installation:" -ForegroundColor Cyan
    Write-Host "1. Download: $downloadUrl" -ForegroundColor Cyan
    Write-Host "2. Extract the ZIP file" -ForegroundColor Cyan
    Write-Host "3. Run as Administrator: PCoIP_ComponentInstaller.exe /S" -ForegroundColor Cyan
    
    # Cleanup on failure
    if (Test-Path $DownloadPath) {
        Write-Host "`nCleaning up temporary files..." -ForegroundColor Yellow
        try {
            Remove-Item $DownloadPath -Recurse -Force -ErrorAction SilentlyContinue
        }
        catch {
            Write-Warning "Could not clean up temporary files at $DownloadPath"
        }
    }
    
    Read-Host "`nPress Enter to exit"
    exit 1
}

Write-Host "`nAfter reboot, verify microphone redirection is working by:" -ForegroundColor Cyan
Write-Host "1. Connecting a microphone to the client device" -ForegroundColor Cyan
Write-Host "2. Testing audio input in the remote Computle session" -ForegroundColor Cyan
Write-Host "3. Checking Windows Sound settings for Teradici Virtual Audio devices" -ForegroundColor Cyan
```
