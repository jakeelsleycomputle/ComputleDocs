# Reinstall DCV Server

**Prerequisite**

Ensure that Remote Desktop is enabled and that you can connect to the machine. &#x20;

{% hint style="info" %}
Enable Remote Desktop by navigating to Settings > Remote Desktop Settings
{% endhint %}

***

**Refresh DCV Server**

1. Via Remote Desktop, connect to your Computle machine.
2. Search for **PowerShell ISE**; right click and select _Run as Administrator._
3. Paste the following code into the PowerShell script pane and click **F5**.

```mathml
# Copyright Computle.com - Computle Reinstall DCV Server


$fileUrl = "https://d1uj6qtbmh3dt5.cloudfront.net/2024.0/Servers/nice-dcv-server-x64-Release-2024.0-19030.msi"
$savePath = "C:\Windows\Computle"
$installLogFile = "dcv_install_msi.log"

if (-not (Test-Path -Path $savePath)) {
    New-Item -ItemType Directory -Path $savePath -Force
}

Invoke-WebRequest -Uri $fileUrl -OutFile "$savePath\nice-dcv-server-x64-Release.msi"

$msiFile = Join-Path -Path $savePath -ChildPath "nice-dcv-server-x64-Release.msi"
Start-Process msiexec.exe -ArgumentList "/i `"$msiFile`" ADDLOCAL=ALL /quiet /norestart /l*v `"$installLogFile`"" -Wait

if(!(Test-Path -LiteralPath "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\license")) {  
    New-Item "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\license" -Force -ErrorAction SilentlyContinue 
}

if(!(Test-Path -LiteralPath "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity")) {  
    New-Item "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity" -Force -ErrorAction SilentlyContinue 
}

if(!(Test-Path -LiteralPath "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\session-management\automatic-console-session")) {  
    New-Item "Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\session-management\automatic-console-session" -Force -ErrorAction SilentlyContinue 
}

New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\license' -Name 'license-file' -Value '5053@dcvlicensing1.computle.net;5053@dcvlicensing2.computle.net' -PropertyType String -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity' -Name 'enable-quic-frontend' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\session-management\automatic-console-session' -Name 'owner' -Value 'computle' -PropertyType String -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity' -Name 'idle-timeout' -Value 0 -PropertyType DWord -Force -ErrorAction
New-ItemProperty -Path "HKLM:\Software\GSettings\com\nicesoftware\dcv\security" -Name "os-auto-lock" -PropertyType DWord -Value 1 -Force -ErrorAction SilentlyContinue

$sourceKey = "https://certs.computle.net/dcv.key"
$sourcePem = "https://certs.computle.net/dcv.pem"
$destinationFolder = "C:\Windows\System32\config\systemprofile\AppData\Local\NICE\dcv\"

if (-not (Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder -Force
}

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
$registryKey = 'license-file'

New-ItemProperty -LiteralPath $registryPath -Name $registryKey -Value $licenseValue -PropertyType String -Force -ErrorAction SilentlyContinue

Write-Host "Registry updated successfully with license value: $licenseValue" -ForegroundColor Green

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
        $content = $content -replace '(?m)^; %owner% allow builtin', '%owner% allow builtin'
        Set-Content -Path $permissionsFilePath -Value $content -Encoding ASCII -NoNewline
        Write-Host "Successfully updated Computle DCV permissions to allow owner" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to update permissions file: $_"
    }
} else {
    Write-Warning "Computle DCV permissions file not found at: $permissionsFilePath"
}

Clear-Host

Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "Computle DCV Server has been installed and configured with:" -ForegroundColor Cyan
Write-Host "- License servers configured" -ForegroundColor White
Write-Host "- SSL certificates downloaded" -ForegroundColor White
Write-Host "- Permissions set to allow owner (%owner%) to connect" -ForegroundColor White

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



```
