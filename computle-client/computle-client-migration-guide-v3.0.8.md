# Computle Client: Migration Guide (v3.0.8)

### Overview

This guide outlines the migration process to Computle Client v3.0.8, which introduces automatic Windows login presentation and improved authentication handling. This update eliminates the need for users to enter credentials twice and provides a more seamless connection experience.

### What's Changing?

* **Computle Client v3.0.8** enables automatic presentation of the Windows login screen.
* Users are automatically presented with their Computle machine after sign-in.
* Authentication is handled by the Computle Client instead of DCV web interface.
* Administrators can connect to all Computle machines directly from the portal.
* Web access will be disabled to improve security.

#### Prerequisites Verification

{% hint style="warning" %}
**Critical:** Before changing DCV authentication settings, you **must** disable public web access to prevent security breaches. When authentication is set to "none" to allow Computle Client to handle login, the web interface would load Windows with no password protection if left publicly accessible. This step is performed by Computle at a tenant-router level, but you can optionally perform this step yourself by limiting the DCVServer service in Windows Firewall.
{% endhint %}

The migration script automatically checks that DCV ports are not publicly accessible. If ports are open, the script will fail with:

```
You have not passed pre-requisites, please consult your account rep.
```

This safeguard ensures machines cannot be accessed without authentication via the web interface.

***

### Migration Phases

#### Phase 1: Client Deployment and Testing

**Objective:** Deploy Computle Client v3.0.8 and verify compatibility

**Owner:** Client/MSP/IT

**Steps:**

1. Download Computle Client v3.0.8 installer from [Computle Docs - Installers](https://docs.computle.com/installers/installers).
2. Restart the target machine to close all Computle instances.
3. Deploy to a test machine in your office.
4. Verify installation and basic functionality.
5. Test system access and confirm normal operations.
6. Once confirmed stable, deploy the client update to remaining user machines.

**Installation Command (Silent):**

```powershell
ComputleClientV3_3.0.8_Setup.exe /S
```

_Note: Silent installation takes approximately 15 minutes_

***

#### Phase 2: Authentication Migration (Pilot)

**Objective:** Migrate one test machine to new authentication method

**Steps:**

**2.1 Identify Test User**

IDentify one user for pilot testing.

**2.2 Disable Public Web Access**

**Owner:** Computle\
Ensure the selected Computle machine's DCV ports are not publicly accessible.

**2.3 Run Authentication Migration Script**

**Owner:** Computle/MSP/IT\
Execute the following PowerShell script on the selected Computle machine:

```powershell
$authRegPath = "Registry::HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\security\authentication"
$lockRegPath = "Registry::HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\security"

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

# Create authentication registry path if it doesn't exist
if (-not (Test-Path $authRegPath)) {
    New-Item -Path $authRegPath -Force | Out-Null
}

# Create security registry path if it doesn't exist
if (-not (Test-Path $lockRegPath)) {
    New-Item -Path $lockRegPath -Force | Out-Null
}

# Set authentication to none
Set-ItemProperty -Path $authRegPath -Name "(Default)" -Value "none"

# Set os-auto-lock to enabled (1)
New-ItemProperty -Path $lockRegPath -Name "os-auto-lock" -Value 1 -PropertyType DWORD -Force | Out-Null

Restart-Service -Name "dcvserver" -Force

Clear-Host
"Authentication mode changed to none."
```

**What this script does:**

* Verifies DCV ports are not publicly accessible (safety check).
* Sets DCV authentication to "none" (allows Computle Client to handle auth).
* Enables OS auto-lock for security.
* Restarts DCV server to apply changes.

**2.4 Enable New Login Experience on Tenant**

**Owner:** Computle\
Configure the tenant to enable the new automatic login presentation feature.

{% hint style="warning" %}
Without this step, the Client will default to traditional authentication. The desired state is that clicking "Connect" will present you with a Windows login screen, with no request for the user's password.&#x20;
{% endhint %}

**2.5 Test User Login Experience**

**Owner:** Client/MSP/IT

1. Test user logs out of Computle Client completely
2. Test user logs back into Computle Client
3. Verify automatic presentation of Windows login screen
4. Confirm no double-authentication required
5. Test all normal workflows (file access, applications, etc.)

***

#### Phase 3: Full Deployment

**Objective:** Migrate all remaining Computle machines

**Owner:** Computle/MSP/IT

**Steps:**

**3.1 Schedule Migration Window**

Coordinate with team to identify optimal migration time (e.g., outside business hours or during low-usage period)

**3.2 Migrate Remaining Machines**

**Owner:** Computle

For each remaining Computle machine:

1. Verify public access is disabled
2. Run authentication migration script (see Phase 2.3)
3. Verify successful completion
4. Document any issues

**3.3 User Login Refresh**

**Owner:** Computle/MSP/IT

Communication to all users:

* Users must log out of Computle Client completely
* Log back in to receive the new experience
* First login will present Windows authentication screen
* Subsequent logins will be seamless

***

#### Phase 4: Web Access Decommissioning

**Objective:** Disable legacy web access and confirm stability

**Owner:** Computle&#x20;

**Steps:**

**4.1 Disable Web Access**

**Owner:** Computle

Remove public web access for all Computle machines:

* Update firewall rules at a tenant-level.
* Confirm with telemetry that the ports are unreachable via the public internet.

**4.2 Verification Period**

**Owner:** Computle/MSP/IT

Monitor for 1-2 weeks:

* Verify all users connecting successfully via Computle Client
* Confirm no web access attempts or errors
* Monitor machine performance and stability
* Collect user feedback

***

### Rollback Plan

If issues arise during migration:

#### During Phase 2 (Pilot)

* Re-enable web authentication on test machine
* Revert tenant configuration
* Analyze issues before proceeding

#### During Phase 3 (Full Deployment)

* Pause migration of remaining machines
* Keep migrated machines on new system if stable
* Address issues before continuing
* Consider extended pilot phase with more users

#### Script to Re-enable Authentication (if needed)

```powershell
$authRegPath = "Registry::HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\security\authentication"

# Set authentication back to system
Set-ItemProperty -Path $authRegPath -Name "(Default)" -Value "system"

Restart-Service -Name "dcvserver" -Force

"Authentication mode changed back to system."
```

***

### Computle Portal: Connecting to Machines

Administrators can connect to all machines using the [Computle Portal ](https://portal.computle.com/)> Workstations > DCV.

<figure><img src="../.gitbook/assets/Screenshot 2025-11-18 at 18.08.42.png" alt=""><figcaption></figcaption></figure>

***

### Questions or Concerns?

Contact Jake Elsley or your Computle account representative to discuss or refine any step as required.

***

_This migration guide is based on Computle Client v3.0.8 and DCV authentication configuration scripts. Always refer to official Computle documentation for the latest information._
