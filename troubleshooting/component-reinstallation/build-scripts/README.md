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
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls13; (New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/jakeelsleycomputle/ComputleDocs/July2024/Scripts/DCVSetup.ps1") | iex
```

```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}; (New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/jakeelsleycomputle/ComputleDocs/July2024/Scripts/DCVSetup.ps1") | iex
```

```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $wc = New-Object System.Net.WebClient; $wc.Headers.Add("User-Agent", "Mozilla/5.0"); $wc.DownloadString("https://raw.githubusercontent.com/jakeelsleycomputle/ComputleDocs/July2024/Scripts/DCVSetup.ps1") | iex
```
