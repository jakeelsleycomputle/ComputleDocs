---
description: >-
  This guide explains how to enable USB redirection on Compute workstations
  using Mechdyne TGX.
---

# Enable USB Redirection

### Manual Configuration

#### Step 1: Open Configuration File

Open PowerShell as Administrator and edit the USB configuration file:

```powershell
notepad C:\ProgramData\Mechdyne\TGX\usbConfig.ini
```

#### Step 2: Configure USB Classes

Replace the contents with the following configuration to enable all USB device classes:

```ini
[Class]
Unspecified=true
Audio=true
Communications=true
Hid=true
Pid=true
Image=true
Printer=true
MassStorage=true
Hub=true
CdcData=true
SmartCard=true
Security=true
Video=true
Phdc=true
Av=true
Billboard=true
UsbCBridge=true
Diagnostic=true
Wireless=true
Miscellaneous=true
Application=true
Vendor=true

[Whitelist]

[Blacklist]
```

#### Step 3: Save and Restart

1. Save the file.
2. Restart your Computle workstation.

***

### Automated Setup

For easier deployment, use the PowerShell script below to automatically configure USB redirection.

#### Prerequisites

* Run PowerShell as Administrator
* Ensure TGX is installed on the workstation

#### Usage

1. Download the setup script
2. Right-click and "Run with PowerShell" as Administrator
3. Follow any prompts to restart services

```powershell
# Computle Workstation TGX USB Redirection Setup Script
# Run as Administrator

param(
    [switch]$Force
)

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator. Please run PowerShell as Administrator and try again."
    exit 1
}

$configPath = "C:\ProgramData\Mechdyne\TGX\usbConfig.ini"
$backupPath = "$configPath.backup"

Write-Host "Computle Workstation TGX USB Redirection Setup" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

# Check if TGX directory exists
if (!(Test-Path "C:\ProgramData\Mechdyne\TGX")) {
    Write-Error "TGX installation directory not found. Please ensure Mechdyne TGX is installed on this Computle workstation."
    exit 1
}

# Backup existing config if it exists
if (Test-Path $configPath) {
    if (!$Force) {
        $backup = Read-Host "Existing configuration found. Create backup? (y/n)"
        if ($backup -eq 'y' -or $backup -eq 'Y') {
            Copy-Item $configPath $backupPath
            Write-Host "Backup created: $backupPath" -ForegroundColor Yellow
        }
    } else {
        Copy-Item $configPath $backupPath
        Write-Host "Backup created: $backupPath" -ForegroundColor Yellow
    }
}

# USB Configuration content
$configContent = @"
[Class]
Unspecified=true
Audio=true
Communications=true
Hid=true
Pid=true
Image=true
Printer=true
MassStorage=true
Hub=true
CdcData=true
SmartCard=true
Security=true
Video=true
Phdc=true
Av=true
Billboard=true
UsbCBridge=true
Diagnostic=true
Wireless=true
Miscellaneous=true
Application=true
Vendor=true

[Whitelist]

[Blacklist]
"@

try {
    # Write configuration to file
    $configContent | Out-File -FilePath $configPath -Encoding ASCII
    Write-Host "Configuration written successfully to: $configPath" -ForegroundColor Green
    
    # Try to restart TGX services
    Write-Host "Attempting to restart TGX services..." -ForegroundColor Yellow
    
    $tgxServices = Get-Service | Where-Object { $_.Name -like "*TGX*" -or $_.DisplayName -like "*TGX*" }
    
    if ($tgxServices) {
        foreach ($service in $tgxServices) {
            try {
                Write-Host "Restarting service: $($service.DisplayName)" -ForegroundColor Yellow
                Restart-Service $service.Name -Force
                Write-Host "Service restarted successfully: $($service.DisplayName)" -ForegroundColor Green
            }
            catch {
                Write-Warning "Failed to restart service $($service.DisplayName): $($_.Exception.Message)"
            }
        }
    } else {
        Write-Warning "No TGX services found. You may need to restart the system or manually restart TGX services."
    }
    
    Write-Host "`nComputle workstation setup completed successfully!" -ForegroundColor Green
    Write-Host "USB redirection is now enabled for all device classes on this Computle workstation." -ForegroundColor Green
    
    if (!$Force) {
        $reboot = Read-Host "`nRestart computer now to ensure changes take effect? (y/n)"
        if ($reboot -eq 'y' -or $reboot -eq 'Y') {
            Restart-Computer -Force
        }
    }
    
} catch {
    Write-Error "Failed to write configuration: $($_.Exception.Message)"
    exit 1
}

Write-Host "`nIf you experience issues, you can restore the original configuration from: $backupPath" -ForegroundColor Cyan
```
