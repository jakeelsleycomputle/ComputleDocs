# No connection to the machine

**Network requirements**

* You must be able to access port 8443.
* You must be able to access _\*.computle.net_ and _\*.computle.com._&#x20;

If you use security solutions such as Zscaler, please ensure that you whitelist these domains.&#x20;

**PowerShell**

To test connectivity, you can run the following PowerShell command, replacing "machine.computle.net" with your machine ID:

`Test-NetConnection -ComputerName machine.computle.net -Port 8443`

**Web browser**

On instances where the web client is enabled, you can navigate to the following webpage, replacing "machine.computle.net" with your machine ID. This will present a NICE DCV connection screen.

`https://machine.computle.net:8443`
