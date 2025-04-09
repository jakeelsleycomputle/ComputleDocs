# Network Requirements

## **Ports and endpoints**

**Computle requires the following network-level access:**

* Unrestricted access to port 8443 on the target machine.
* Unrestricted access to access _\*.computle.net._

**Network speed**

* Each connecting user should have at least 10Mbps of download speed.&#x20;
* For best performance, you should have less than 50ms of latency. This can be checked via the NICE DCV application > Cog > Streaming Mode.

***

## Testing

If you use security solutions such as Zscaler, please ensure that you whitelist these domains.&#x20;

**PowerShell**

To test connectivity, you can run the following PowerShell command, replacing "machine.computle.net" with your machine or network ID:

`Test-NetConnection -ComputerName machine.computle.net -Port 8443`

**Web browser**

On instances where the web client is enabled, you can navigate to the following webpage, replacing "machine.computle.net" with your machine ID. This will present a NICE DCV connection screen.

`https://machine.computle.net:8443`
