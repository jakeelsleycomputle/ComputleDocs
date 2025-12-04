# Allow Any User to Connect

### Version 2 Machines

```
# Updates NICE DCV default.perm to allow any user to connect

$permFile = "C:\Program Files\NICE\DCV\Server\conf\default.perm"

$content = @"
[permissions]
%any% allow builtin
"@

Set-Content -Path $permFile -Value $content -Force

Write-Host "Updated $permFile with '%any% allow builtin'"

# Restart DCV Server service
Restart-Service -Name "dcvserver" -Force
Write-Host "DCV Server restarted"
```

### Version 3 Machines

Follow [this](../../../computle-client/computle-client-migration-guide-v3.0.8.md) migration guide.
