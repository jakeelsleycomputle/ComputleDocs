# NICE DCV Client

This PowerShell script will automatically download and install the latest version of the NICE DCV client.

```sh
$dcvProcess = Get-Process -Name dcvviewer -ErrorAction SilentlyContinue
if ($dcvProcess) {
    Write-Host "DCV Viewer is running. Closing it..."
    Stop-Process -Name dcvviewer -Force
}

$dcvUrl = "https://d1uj6qtbmh3dt5.cloudfront.net/nice-dcv-client-Release.msi"
$dcvOutputFile = "$env:TEMP\nice-dcv-client-Release.msi"

Write-Host "Downloading the file. This may take some time..."
$dcvWebClient = New-Object System.Net.WebClient
$dcvWebClient.DownloadFile($dcvUrl, $dcvOutputFile)
Write-Host "Download completed."

Write-Host "Installing the MSI package..."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $dcvOutputFile /quiet /norestart" -Wait
Write-Host "Installation completed."

Write-Host "Setup completed successfully."

$vsRuntimeUrl = "https://download.visualstudio.microsoft.com/download/pr/0ff148e7-bbf6-48ed-bdb6-367f4c8ea14f/bd35d787171a1f0de7da6b57cc900ef5/windowsdesktop-runtime-8.0.5-win-x64.exe"
$vsRuntimeOutputFile = "C:\Windows\Computle\installers\windowsdesktop-runtime-8.0.5-win-x64.exe"

$vsRuntimeOutputDir = [System.IO.Path]::GetDirectoryName($vsRuntimeOutputFile)
if (-not (Test-Path $vsRuntimeOutputDir)) {
    New-Item -Path $vsRuntimeOutputDir -ItemType Directory | Out-Null
}

$vsRuntimeDownloadScript = {
    param (
        [string]$downloadUrl,
        [string]$outputFile
    )

    $outputDir = [System.IO.Path]::GetDirectoryName($outputFile)
    if (-not (Test-Path $outputDir)) {
        New-Item -Path $outputDir -ItemType Directory | Out-Null
    }

    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($downloadUrl, $outputFile)
}

$vsRuntimeJob = Start-Job -ScriptBlock $vsRuntimeDownloadScript -ArgumentList $vsRuntimeUrl, $vsRuntimeOutputFile

Wait-Job -Job $vsRuntimeJob
Receive-Job -Job $vsRuntimeJob

Write-Host "Download completed."

Start-Process -FilePath $vsRuntimeOutputFile -ArgumentList "/quiet" -NoNewWindow -Wait
Write-Host "Installation completed."

```
