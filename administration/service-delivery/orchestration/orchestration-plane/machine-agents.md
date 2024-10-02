---
hidden: true
---

# Machine Agents

## Active: Qemu-guest-agent

The QEMU Guest Agent is a daemon that runs inside Computle Machine and allows the hypervisor to execute commands and perform operations within the machine.&#x20;

{% hint style="info" %}
We advise that you do not remove the QEMU Guest Agent. Doing so will cause a loss of reporting capabilities, the inability to perform graceful power actions, and limited administrator-level recovery options.
{% endhint %}

### **Data Collection**

The QEMU Guest Agent collects a variety of data from Computle Machine to assist in management and monitoring. Key types of data collected include:

1. **System Information:** Hostname and O/S details.
2. **Memory Usage:** Total, free, and used memory.
3. **CPU Information:** Number of CPUs and their usage.
4. **Disk Information:** Disk partitions and file system usage.
5. **GPU Information:** GPU activity data (not currently visible).
6. **Network Information:** Network interfaces and traffic statistics.
7. **Running Processes:** List of active processes with resource usage.
8. **Filesystem Status:** Health and consistency of file systems.
9. **Resource Configuration:** Details on resource allocation and virtual devices.

All data collected is kept within the tenant's namespace and is only visible to trusted users and administrators.

## Depreciated: VMbus

To enable maintenance, each Computle machine is assigned a unique fingerprint. Automated orchestration tools are then used to provide maintenance services to the machine via the vmbus kernel. Whilst not advised, customers can opt-out by deleting the vmbus user account.

Credentials for the VMbus interface as rotated automatically and stored within supplier-managed vaults. If you have opted out of this service and deleted the vmbus account, these credentials will be rendered unusable
