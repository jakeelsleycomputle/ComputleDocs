# Build Scripts

**This page contains useful build scripts for Computle machines.**

## Remove Shutdown from the Start Menu

```powershell
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Start\HideShutDown") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Start\HideShutDown" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Start\HideShutDown' -Name 'Behavior' -Value 32 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Start\HideShutDown' -Name 'highrange' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Start\HideShutDown' -Name 'lowrange' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Start\HideShutDown' -Name 'mergealgorithm' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Start\HideShutDown' -Name 'policytype' -Value 4 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Start\HideShutDown' -Name 'value' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
```

## Prevent Computle from Sleeping

```bash
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0
```

***

{% hint style="warning" %}
Do not run this script unless requested. This is only to be used under a planned migration.
{% endhint %}

## Set DCV Authentication to None

```
# Copyright Computle.com - Computle Reinstall DCV Server

# ============================================
# SECTION 1: Install DCV Server
# ============================================
Write-Host "Downloading DCV Server installer..." -ForegroundColor Yellow

$fileUrl = "https://d1uj6qtbmh3dt5.cloudfront.net/2024.0/Servers/nice-dcv-server-x64-Release-2024.0-19030.msi"
$savePath = "C:\Windows\Computle"
$installLogFile = "$savePath\dcv_install_msi.log"

if (-not (Test-Path -Path $savePath)) {
    New-Item -ItemType Directory -Path $savePath -Force | Out-Null
}

$msiFile = Join-Path -Path $savePath -ChildPath "nice-dcv-server-x64-Release.msi"

try {
    Invoke-WebRequest -Uri $fileUrl -OutFile $msiFile -ErrorAction Stop
    Write-Host "Download complete." -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to download MSI file: $_" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $msiFile)) {
    Write-Host "ERROR: MSI file not found after download" -ForegroundColor Red
    exit 1
}

Write-Host "Installing DCV Server (this may take a few minutes)..." -ForegroundColor Yellow
$installProcess = Start-Process msiexec.exe -ArgumentList "/i `"$msiFile`" ADDLOCAL=ALL /quiet /norestart /l*v `"$installLogFile`"" -Wait -PassThru

if ($installProcess.ExitCode -ne 0) {
    Write-Host "WARNING: MSI install exited with code $($installProcess.ExitCode). Check log at $installLogFile" -ForegroundColor Yellow
} else {
    Write-Host "DCV Server installation complete." -ForegroundColor Green
}

# ============================================
# SECTION 2: Configure Registry Settings
# ============================================
Write-Host "Configuring registry settings..." -ForegroundColor Yellow

$registryPaths = @(
    "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\license",
    "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity",
    "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\session-management\automatic-console-session",
    "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\security"
)

foreach ($path in $registryPaths) {
    if (!(Test-Path -LiteralPath $path)) {
        New-Item $path -Force -ErrorAction SilentlyContinue | Out-Null
    }
}

New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity' -Name 'enable-quic-frontend' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\session-management\automatic-console-session' -Name 'owner' -Value 'computle' -PropertyType String -Force -ErrorAction SilentlyContinue | Out-Null
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity' -Name 'idle-timeout' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
New-ItemProperty -Path "HKLM:\Software\GSettings\com\nicesoftware\dcv\security" -Name "os-auto-lock" -PropertyType DWord -Value 1 -Force -ErrorAction SilentlyContinue | Out-Null

Write-Host "Registry settings configured." -ForegroundColor Green

# ============================================
# SECTION 3: Resolve License Servers and Update Registry
# ============================================
Write-Host "Configuring license servers..." -ForegroundColor Yellow

$licensingServers = @(
    'dcvlicensing1.computle.net',
    'dcvlicensing2.computle.net'
)

$resolvedIPs = @()

foreach ($server in $licensingServers) {
    try {
        $ipAddresses = [System.Net.Dns]::GetHostAddresses($server)
        foreach ($ip in $ipAddresses) {
            $resolvedIPs += "5053@$($ip.IPAddressToString)"
        }
    } catch {
        Write-Host "Failed to resolve $server" -ForegroundColor Red
    }
}

$licenseValue = $resolvedIPs -join ';'
$registryPath = 'Registry::HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\license'
New-ItemProperty -LiteralPath $registryPath -Name 'license-file' -Value $licenseValue -PropertyType String -Force -ErrorAction SilentlyContinue | Out-Null

Write-Host "License servers configured: $licenseValue" -ForegroundColor Green

# ============================================
# SECTION 4: Download Certificates
# ============================================
Write-Host "Downloading certificates..." -ForegroundColor Yellow

$sourceKey = "https://certs.computle.net/dcv.key"
$sourcePem = "https://certs.computle.net/dcv.pem"
$destinationFolder = "C:\Windows\System32\config\systemprofile\AppData\Local\NICE\dcv\"

if (-not (Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder -Force | Out-Null
    Write-Host "Created destination folder: $destinationFolder" -ForegroundColor Gray
}

try {
    Invoke-WebRequest -Uri $sourceKey -OutFile "$destinationFolder\dcv.key" -UseBasicParsing -ErrorAction Stop
    Write-Host "Downloaded dcv.key" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to download dcv.key: $_" -ForegroundColor Red
}

try {
    Invoke-WebRequest -Uri $sourcePem -OutFile "$destinationFolder\dcv.pem" -UseBasicParsing -ErrorAction Stop
    Write-Host "Downloaded dcv.pem" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to download dcv.pem: $_" -ForegroundColor Red
}

# ============================================
# SECTION 5: Create Scheduled Task for Daily Certificate Updates
# ============================================
Write-Host "Creating scheduled task for daily certificate updates..." -ForegroundColor Yellow

$scriptBlock = @"
if (-not (Test-Path -Path '$destinationFolder')) {
    New-Item -ItemType Directory -Path '$destinationFolder' -Force
}
try {
    Invoke-WebRequest -Uri '$sourceKey' -OutFile '$destinationFolder\dcv.key' -UseBasicParsing -ErrorAction Stop
} catch {
    Write-EventLog -LogName Application -Source 'DCV Cert Update' -EventId 1001 -EntryType Error -Message "Failed to download dcv.key: `$_"
}
try {
    Invoke-WebRequest -Uri '$sourcePem' -OutFile '$destinationFolder\dcv.pem' -UseBasicParsing -ErrorAction Stop
} catch {
    Write-EventLog -LogName Application -Source 'DCV Cert Update' -EventId 1002 -EntryType Error -Message "Failed to download dcv.pem: `$_"
}
"@

$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -Command `"$scriptBlock`""
$trigger = New-ScheduledTaskTrigger -Daily -At 3am
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

try {
    Unregister-ScheduledTask -TaskName "Update DCV Certs" -Confirm:$false -ErrorAction SilentlyContinue
    Register-ScheduledTask -TaskName "Update DCV Certs" -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest -User "SYSTEM" -ErrorAction Stop | Out-Null
    Write-Host "Scheduled task 'Update DCV Certs' created." -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to create scheduled task: $_" -ForegroundColor Red
}

# ============================================
# SECTION 6: Configure DCV Permissions
# ============================================
Write-Host "Configuring DCV permissions..." -ForegroundColor Yellow

$permissionsFilePath = "C:\Program Files\NICE\DCV\Server\conf\default.perm"

if (Test-Path $permissionsFilePath) {
    $backupPath = "$permissionsFilePath.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    try {
        Copy-Item $permissionsFilePath $backupPath -Force
        Write-Host "Permissions backup created: $backupPath" -ForegroundColor Gray
    }
    catch {
        Write-Host "WARNING: Failed to create permissions backup: $_" -ForegroundColor Yellow
    }

    try {
        $content = Get-Content $permissionsFilePath -Raw
        $content = $content -replace '(?m)^; %owner% allow builtin', '%any% allow builtin'
        Set-Content -Path $permissionsFilePath -Value $content -Encoding ASCII -NoNewline
        Write-Host "DCV permissions updated." -ForegroundColor Green
    }
    catch {
        Write-Host "WARNING: Failed to update permissions file: $_" -ForegroundColor Yellow
    }
} else {
    Write-Host "WARNING: DCV permissions file not found at: $permissionsFilePath" -ForegroundColor Yellow
}

# ============================================
# SECTION 7: Port Check and Authentication Configuration
# ============================================
Write-Host "Checking port configuration..." -ForegroundColor Yellow

$securityRegPath = "Registry::HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\security"

try {
    $publicIP = (Invoke-RestMethod -Uri "https://api.ipify.org" -ErrorAction Stop).Trim()
} catch {
    Write-Host "WARNING: Could not determine public IP, skipping port check" -ForegroundColor Yellow
    $publicIP = $null
}

$portsOpen = $false

if ($publicIP) {
    for ($port = 8443; $port -le 8473; $port++) {
        try {
            $tcpClient = New-Object System.Net.Sockets.TcpClient
            $connect = $tcpClient.BeginConnect($publicIP, $port, $null, $null)
            $wait = $connect.AsyncWaitHandle.WaitOne(1000, $false)
            
            if ($wait -and $tcpClient.Connected) {
                $portsOpen = $true
                $tcpClient.Close()
                break
            }
            $tcpClient.Close()
        }
        catch {
        }
    }

    if ($portsOpen) {
        Write-Host "ERROR: You have not passed pre-requisites, please consult your account rep." -ForegroundColor Red
        exit 1
    }
}

if (-not (Test-Path $securityRegPath)) {
    New-Item -Path $securityRegPath -Force -ErrorAction SilentlyContinue | Out-Null
}

New-ItemProperty -Path $securityRegPath -Name "authentication" -Value "none" -PropertyType String -Force -ErrorAction SilentlyContinue | Out-Null
New-ItemProperty -Path $securityRegPath -Name "os-auto-lock" -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null

Write-Host "Authentication configuration complete." -ForegroundColor Green

# ============================================
# SECTION 8: Configure Service and Final Restart
# ============================================
Write-Host "Configuring DCV Server service..." -ForegroundColor Yellow

try {
    Set-Service -Name dcvserver -StartupType "Automatic" -ErrorAction Stop
    sc.exe config dcvserver start= delayed-auto | Out-Null
    Write-Host "DCV Server set to Automatic (Delayed Start)." -ForegroundColor Green
} catch {
    Write-Host "WARNING: Failed to set DCV Server startup type: $_" -ForegroundColor Yellow
}

Write-Host "Restarting DCV Server service..." -ForegroundColor Yellow

try {
    Restart-Service -Name dcvserver -Force -ErrorAction Stop
    Write-Host "DCV Server service restarted." -ForegroundColor Green
} catch {
    Write-Host "WARNING: Failed to restart DCV Server service: $_" -ForegroundColor Yellow
    Write-Host "Please manually restart: Restart-Service dcvserver" -ForegroundColor Yellow
}

# ============================================
# COMPLETE
# ============================================
Clear-Host

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Computle DCV Server Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Configured:" -ForegroundColor White
Write-Host "  - DCV Server installed" -ForegroundColor Gray
Write-Host "  - License servers configured" -ForegroundColor Gray
Write-Host "  - SSL certificates downloaded" -ForegroundColor Gray
Write-Host "  - Daily certificate update task created" -ForegroundColor Gray
Write-Host "  - Permissions configured" -ForegroundColor Gray
Write-Host "  - Authentication mode set to none" -ForegroundColor Gray
Write-Host "  - Service set to auto-start" -ForegroundColor Gray
Write-Host ""
Write-Host "Ready for connections!" -ForegroundColor Green

```

```
```
