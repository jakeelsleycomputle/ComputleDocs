# Refresh DCV Server

**Prerequisite**

Ensure that Remote Desktop is enabled and that you can connect to the machine. &#x20;

{% hint style="info" %}
Enable Remote Desktop by navigating to Settings > Remote Desktop Settings
{% endhint %}

***

**Refresh DCV Server**

1. VIa Remote Desktop, connect to your Computle machine.
2. As an Administrator, launch PowerShell ISE.
3. Paste the following code into the PowerShell script pane.

```sh
$fileUrl = "https://d1uj6qtbmh3dt5.cloudfront.net/nice-dcv-server-x64-Release.msi"
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

Restart-Service -Name dcvserver -Force
```

5. Click Run or F5 to start the process.&#x20;
