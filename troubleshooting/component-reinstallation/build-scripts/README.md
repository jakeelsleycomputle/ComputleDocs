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
    "You have not passed pre-requisites, please consult your account rep."
    exit 1
}

if (-not (Test-Path $securityRegPath)) {
    New-Item -Path $securityRegPath -Force | Out-Null
}

New-ItemProperty -Path $securityRegPath -Name "authentication" -Value "none" -PropertyType String -Force | Out-Null

New-ItemProperty -Path $securityRegPath -Name "os-auto-lock" -Value 1 -PropertyType DWORD -Force | Out-Null
Restart-Service -Name "dcvserver" -Force
Clear-Host
"Authentication mode changed to none."
```

```
irm "https://raw.githubusercontent.com/jakeelsleycomputle/ComputleDocs/July2024/Scripts/Enable-ComputleClientAuth.ps1" | iex
```

```
irm https://raw.githubusercontent.com/jakeelsleycomputle/ComputleDocs/July2024/Scripts/DCVSetup.ps1 | iex
```
