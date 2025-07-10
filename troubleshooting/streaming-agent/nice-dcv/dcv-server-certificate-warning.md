# DCV Server Certificate Warning

1. As an Administrator, launch PowerShell ISE.
2. Paste the following code into the PowerShell script pane.

```sh
$sourceKey = "https://certs.computle.net/dcv.key"
$sourcePem = "https://certs.computle.net/dcv.pem"
$destinationFolder = "C:\Windows\System32\config\systemprofile\AppData\Local\NICE\dcv\"

# Ensure destination folder exists
if (-not (Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder -Force
    Write-Output "Created destination folder: $destinationFolder"
}

# Download certificates immediately with error handling
Write-Output "Downloading certificates..."

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

# Create scheduled task for daily certificate updates
Write-Output "Creating scheduled task for daily certificate updates..."

$script = @"
if (-not (Test-Path -Path '$destinationFolder')) {
    New-Item -ItemType Directory -Path '$destinationFolder' -Force
}
try {
    Invoke-WebRequest -Uri '$sourceKey' -OutFile '$destinationFolder\dcv.key' -UseBasicParsing -ErrorAction Stop
} catch {
    Write-EventLog -LogName Application -Source 'DCV Cert Update' -EventId 1001 -EntryType Error -Message "Failed to download dcv.key: `$_"
}
try {
    Invoke-WebRequest -Uri '$sourcePem' -OutFile '$destinationFolder\dcv.pem' -UseBasicParsing -ErrorAction Stop
} catch {
    Write-EventLog -LogName Application -Source 'DCV Cert Update' -EventId 1002 -EntryType Error -Message "Failed to download dcv.pem: `$_"
}
"@

$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -Command `"$script`""
$trigger = New-ScheduledTaskTrigger -Daily -At 3am
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

try {
    Register-ScheduledTask -TaskName "Update DCV Certs" -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest -User "SYSTEM" -ErrorAction Stop
    Write-Output "Successfully created scheduled task 'Update DCV Certs'"
} catch {
    Write-Error "Failed to create scheduled task: $_"
}

```

3. Click Run or F5 to start the process.&#x20;
