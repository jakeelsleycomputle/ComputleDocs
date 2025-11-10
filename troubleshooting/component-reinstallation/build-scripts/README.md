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
$regPath = "Registry::HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\security\authentication"

# Get public IP
$publicIP = (Invoke-RestMethod -Uri "https://api.ipify.org").Trim()

# Check if DCV ports are publicly accessible
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
        # Port not accessible, continue
    }
}

if ($portsOpen) {
    "You have not passed pre-requisites, please consult your account rep."
    exit 1
}

if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

Set-ItemProperty -Path $regPath -Name "(Default)" -Value "none"

Restart-Service -Name "dcvserver" -Force

"Authentication mode changed to none."
```
