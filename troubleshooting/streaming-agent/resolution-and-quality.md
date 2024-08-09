# Resolution and Quality

## TCP/QUIC-UDP

By default, Computle uses TCP mode to transport display pixels.&#x20;

You can see which mode you are using by clicking the _Cog > Streaming Mode_ and then checking for  TCP/WebSocket mode, or QUIC mode.&#x20;

<figure><img src="../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

On connections with a latency of above 50ms, we recommend enabling UDP/QUIC mode. However, if you core switches and routers do not support Jumbo Frames, this may have a determinantal effect on performance.&#x20;

**To enable UDP/QUIC mode:**

* Open Regedit
* Go to “HKEY\_USERS/S-1-5-18/Software/GSettings/com/nicesoftware/dcv/connectivity”
* Double click “enable-quic-frontend” and change value to 1.&#x20;
* Reboot Computle.
* Within the DCV application, selected QUIC.&#x20;

***

## Low-Frame Rate

On Computle supplied images, the default framerate is set to 60fps.&#x20;

This is managed via the target-fps key under:

`HKEY_USERS/S-1-5-18/Software/GSettings/com/nicesoftware/dcv/display`

If this value is missing, you can recreate it with the following PowerShell command:

```
$RegistryPath = "HKU\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\display"
$Name = "target-fps"
$Value = 60

if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force
}

Set-ItemProperty -Path $RegistryPath -Name $Name -Value $Value
```

***

## Resolution

**Default**

Computle supports quad-4K displays by default with a maximum resolution of 4096\*4096 per monitor.&#x20;

**Ultra-Wide Support (5120x1440)**

Ultra-wide monitor users may be required to amend their display configuration if they are unable to enter full screen mode. To do so, run the following commands from an elevated Command Prompt. &#x20;

1. Set `enable-client-resize` to 0:

```
dcv set-config-param --session session-id enable-client-resize=0
```

2. Set a custom layout for the current session:

```
dcv set-display-layout --session session-id 2560x1440+0+0,2560x1440+2560+0
```

3. Disconnect from Computle.
4. Connect to the session, switch to full screen, and check if the layout is correct.
5. If the layout is satisfactory, make it permanent:

```
dcv set-config-param --session session-id console-session-default-layout=2560x1440+0+0,2560x1440+2560+0
```
