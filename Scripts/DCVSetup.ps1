# Copyright Computle.com - Computle Reinstall DCV Server

# ============================================
# SECTION 1: Install DCV Server
# ============================================
$fileUrl = "https://d1uj6qtbmh3dt5.cloudfront.net/2024.0/Servers/nice-dcv-server-x64-Release-2024.0-19030.msi"
$savePath = "C:\Windows\Computle"
$installLogFile = "dcv_install_msi.log"

if (-not (Test-Path -Path $savePath)) {
    New-Item -ItemType Directory -Path $savePath -Force
}

Invoke-WebRequest -Uri $fileUrl -OutFile "$savePath\nice-dcv-server-x64-Release.msi"

$msiFile = Join-Path -Path $savePath -ChildPath "nice-dcv-server-x64-Release.msi"
Start-Process msiexec.exe -ArgumentList "/i `"$msiFile`" ADDLOCAL=ALL /quiet /norestart /l*v `"$installLogFile`"" -Wait

# ============================================
# SECTION 2: Configure Registry Settings
# ============================================
$registryPaths = @(
    "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\license",
    "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity",
    "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\session-management\automatic-console-session",
    "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\security"
)

foreach ($path in $registryPaths) {
    if (!(Test-Path -LiteralPath $path)) {
        New-Item $path -Force -ErrorAction SilentlyContinue
    }
}

New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity' -Name 'enable-quic-frontend' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\session-management\automatic-console-session' -Name 'owner' -Value 'computle' -PropertyType String -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity' -Name 'idle-timeout' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\Software\GSettings\com\nicesoftware\dcv\security" -Name "os-auto-lock" -PropertyType DWord -Value 1 -Force -ErrorAction SilentlyContinue

# ============================================
# SECTION 3: Resolve License Servers and Update Registry
# ============================================
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
New-ItemProperty -LiteralPath $registryPath -Name 'license-file' -Value $licenseValue -PropertyType String -Force -ErrorAction SilentlyContinue
Write-Host "Registry updated successfully with license value: $licenseValue" -ForegroundColor Green

# ============================================
# SECTION 4: Download Certificates
# ============================================
$sourceKey = "https://certs.computle.net/dcv.key"
$sourcePem = "https://certs.computle.net/dcv.pem"
$destinationFolder = "C:\Windows\System32\config\systemprofile\AppData\Local\NICE\dcv\"

if (-not (Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder -Force
    Write-Output "Created destination folder: $destinationFolder"
}

Write-Output "Downloading certificates..."
try {
    Invoke-WebRequest -Uri $sourceKey -OutFile "$destinationFolder\dcv.key" -UseBasicParsing -ErrorAction Stop
    Write-Output "Successfully downloaded dcv.key"
} catch {
    Write-Error "Failed to download dcv.key: $_"
}

try {
    Invoke-WebRequest -Uri $sourcePem -OutFile "$destinationFolder\dcv.pem" -UseBasicParsing -ErrorAction Stop
    Write-Output "Successfully downloaded dcv.pem"
} catch {
    Write-Error "Failed to download dcv.pem: $_"
}

# ============================================
# SECTION 5: Create Scheduled Task for Daily Certificate Updates
# ============================================
Write-Output "Creating scheduled task for daily certificate updates..."
$script = @"
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

$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -Command `"$script`""
$trigger = New-ScheduledTaskTrigger -Daily -At 3am
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

try {
    Register-ScheduledTask -TaskName "Update DCV Certs" -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest -User "SYSTEM" -ErrorAction Stop
    Write-Output "Successfully created scheduled task 'Update DCV Certs'"
} catch {
    Write-Error "Failed to create scheduled task: $_"
}

# ============================================
# SECTION 6: Configure DCV Permissions
# ============================================
Write-Host "Configuring Computle DCV permissions..." -ForegroundColor Yellow

$permissionsFilePath = "C:\Program Files\NICE\DCV\Server\conf\default.perm"

if (Test-Path $permissionsFilePath) {
    $backupPath = "$permissionsFilePath.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    try {
        Copy-Item $permissionsFilePath $backupPath -Force
        Write-Host "Permissions backup created: $backupPath" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to create permissions backup: $_"
    }

    try {
        $content = Get-Content $permissionsFilePath -Raw
        $content = $content -replace '(?m)^; %owner% allow builtin', '%any% allow builtin'
        Set-Content -Path $permissionsFilePath -Value $content -Encoding ASCII -NoNewline
        Write-Host "Successfully updated Computle DCV permissions to allow owner" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to update permissions file: $_"
    }
} else {
    Write-Warning "Computle DCV permissions file not found at: $permissionsFilePath"
}

# ============================================
# SECTION 7: Port Check and Authentication Configuration
# ============================================
$securityRegPath = "Registry::HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\security"
$publicIP = (Invoke-RestMethod -Uri "https://api.ipify.org").Trim()
$portsOpen = $false

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
    Write-Host "You have not passed pre-requisites, please consult your account rep." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $securityRegPath)) {
    New-Item -Path $securityRegPath -Force | Out-Null
}

New-ItemProperty -Path $securityRegPath -Name "authentication" -Value "none" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $securityRegPath -Name "os-auto-lock" -Value 1 -PropertyType DWORD -Force | Out-Null

# ============================================
# SECTION 8: Configure Service and Final Restart
# ============================================
Clear-Host

Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "Computle DCV Server has been installed and configured with:" -ForegroundColor Cyan
Write-Host "- License servers configured" -ForegroundColor White
Write-Host "- SSL certificates downloaded" -ForegroundColor White
Write-Host "- Daily certificate update task created" -ForegroundColor White
Write-Host "- Permissions set to allow owner (%owner%) to connect" -ForegroundColor White
Write-Host "- Authentication mode set to none" -ForegroundColor White

Write-Host "`nSetting DCV Server to Automatic (Delayed Start)..." -ForegroundColor Yellow
try {
    Set-Service -Name dcvserver -StartupType "Automatic" -ErrorAction Stop
    sc.exe config dcvserver start= delayed-auto
    Write-Host "DCV Server startup type set to Automatic (Delayed Start)" -ForegroundColor Green
} catch {
    Write-Warning "Failed to set DCV Server startup type: $_"
}

Write-Host "`nFinal step: Restarting Computle DCV Server service..." -ForegroundColor Yellow
try {
    Restart-Service -Name dcvserver -Force -ErrorAction Stop
    Write-Host "Computle DCV Server service restarted successfully!" -ForegroundColor Green
} catch {
    Write-Warning "Failed to restart Computle DCV Server service: $_"
    Write-Host "Please manually restart the service using: Restart-Service dcvserver" -ForegroundColor Yellow
}

Write-Host "`nComputle DCV Server setup is now complete and ready for connections!" -ForegroundColor Green
