# Refresh DCV Server

**Prerequisite**

Ensure that Remote Desktop is enabled and that you can connect to the machine. &#x20;

{% hint style="info" %}
Enable Remote Desktop by navigating to Settings > Remote Desktop Settings
{% endhint %}

***

**Refresh DCV Server**

1. VIa Remote Desktop, connect to your Computle machine.
2. As an **Administrator**, launch **PowerShell ISE**.
3. Paste the following code into the PowerShell script pane.

```sh
$fileUrl = "https://d1uj6qtbmh3dt5.cloudfront.net/2023.1/Servers/nice-dcv-server-x64-Release-2023.1-17701.msi"
$savePath = "C:\Windows\Computle"
$installLogFile = "dcv_install_msi.log"

if (-not (Test-Path -Path $savePath)) {
    New-Item -ItemType Directory -Path $savePath -Force
}

Invoke-WebRequest -Uri $fileUrl -OutFile "$savePath\nice-dcv-server-x64-Release.msi"

$msiFile = Join-Path -Path $savePath -ChildPath "nice-dcv-server-x64-Release.msi"
Start-Process msiexec.exe -ArgumentList "/i `"$msiFile`" ADDLOCAL=ALL /quiet /norestart /l*v `"$installLogFile`"" -Wait

$content = @"
[groups]

[aliases]
file-management=file-upload, file-download, clipboard-management

[permissions]
%any% allow builtin
osgroup:YOUR_GROUP allow builtin
group:mygroup1 allow builtin
"@

Set-Content -Path "C:\Program Files\NICE\DCV\Server\conf\default.perm" -Value $content -Force

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
New-ItemProperty -Path 'Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity' -Name 'idle-timeout' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\display" -Name layout-managers -PropertyType STRING -Value "['nvapi', 'amd', 'dod', 'winapi']" -ErrorAction SilentlyContinue
New-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::\HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\display" -Name framebuffer-readers -PropertyType STRING -Value "['desktopduplication', 'gdi']" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\Software\GSettings\com\nicesoftware\dcv\session-management" -Name "max-concurrent-clients" -PropertyType DWord -Value 1 -Force -ErrorAction SilentlyContinue
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

Restart-Service -Name dcvserver -Force
```

5. Click Run or F5 to start the process.&#x20;
