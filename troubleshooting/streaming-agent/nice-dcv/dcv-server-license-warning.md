# License Warning

Some network security devices can interfere with Computle Licensing. Common issues include DNS resolution and port blocking. By default, Computle Licensing is checked every five minutes.&#x20;

***

**Network Resolution**

Ensure that Computle Machine can resolve the following DNS records:

```
dcvlicensing1.computle.net
dcvlicensing2.computle.net
```

***

**Overwrite DNS Records with IPs**

If the DNS resolution is working as expected, and you are unable to obtain a license, you can modify the registry entries to use direct IPs instead.&#x20;

1. As an Administrator, launch PowerShell ISE.
2. Paste the following code into the PowerShell script pane.

```sh
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
```

3. Click Run or F5 to start the process.&#x20;
