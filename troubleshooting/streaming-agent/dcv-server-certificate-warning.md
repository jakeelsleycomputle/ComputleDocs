# DCV Server Certificate Warning

1. As an Administrator, launch PowerShell ISE.
2. Paste the following code into the PowerShell script pane.

```sh
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

```

3. Click Run or F5 to start the process.&#x20;
