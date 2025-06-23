---
description: >-
  This guide explains how to enable USB redirection on Compute workstations
  using Mechdyne TGX.
---

# Enable USB Redirection

### Automated Setup

For easier deployment, use the PowerShell script below to automatically configure USB redirection.

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
param([switch]$Force)

Write-Host "Computle Workstation TGX USB Redirection Setup" -ForegroundColor Green

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

$configPath = "C:\ProgramData\Mechdyne\TGX\usbConfig.ini"
$backupPath = "$configPath.backup"

if (!(Test-Path "C:\ProgramData\Mechdyne\TGX")) {
    Write-Error "TGX installation directory not found on this Computle workstation."
    exit 1
}

if (Test-Path $configPath) {
    if (!$Force) {
        $backup = Read-Host "Create backup? (y/n)"
        if ($backup -eq 'y' -or $backup -eq 'Y') {
            Copy-Item $configPath $backupPath
        }
    } else {
        Copy-Item $configPath $backupPath
    }
}

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

$configContent | Out-File -FilePath $configPath -Encoding ASCII

$tgxServices = Get-Service | Where-Object { $_.Name -like "*TGX*" -or $_.DisplayName -like "*TGX*" }
if ($tgxServices) {
    foreach ($service in $tgxServices) {
        Restart-Service $service.Name -Force
    }
}

Write-Host "Computle workstation USB redirection setup completed successfully!" -ForegroundColor Green

if (!$Force) {
    $reboot = Read-Host "Restart computer now to complete setup? (y/n)"
    if ($reboot -eq 'y' -or $reboot -eq 'Y') {
        Restart-Computer -Force
    } else {
        Write-Host "Please restart your computer manually to complete the USB redirection setup." -ForegroundColor Yellow
    }
} else {
    Write-Host "Setup complete. Please restart your computer manually to complete the USB redirection setup." -ForegroundColor Yellow
}
```

***

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

###
