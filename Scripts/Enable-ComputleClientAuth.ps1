$securityRegPath = "Registry::HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\security"

if (-not (Test-Path $securityRegPath)) {
    New-Item -Path $securityRegPath -Force | Out-Null
}
New-ItemProperty -Path $securityRegPath -Name "authentication" -Value "none" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $securityRegPath -Name "os-auto-lock" -Value 1 -PropertyType DWORD -Force | Out-Null
Restart-Service -Name "dcvserver" -Force
Clear-Host
"Authentication mode changed to none."
