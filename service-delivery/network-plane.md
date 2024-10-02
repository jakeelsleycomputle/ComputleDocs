# Network Plane

## tenantPublicIP

Tenants are assigned public IP addresses for each region. Whilst these IPs are dedicated to one customer, they are dynamic and subject to change without warning.&#x20;

## Public Endpoint

{% hint style="info" %}
As of August 2024, we are depreciating public access to tenant-level resources. Going forward, users will be required to access tenant resources via [_Computle Gateway_](../onboarding/administrator-guide/gateway-deployment.md), or another network access product, such as VPN, or Zero Trust solutions. _Computle Gateway_ forms part of our Tenant Defaults offering, enabled for all new deployments, and delivered in phases for existing users.
{% endhint %}

Gateway users will access their resources via `gatewayID.region.tenantID.prd.computle.net` endpoint.&#x20;

***

## Depreciated: Inbound Restrictions and CNAME Configuration

For ease of use, customers can add their own CNAME records to route to the machineID.region.tenantID.prd.computle.net endpoint. This enables you to create entries such as machine1.contoso.com.

Where requested, Computle can disable all inbound public access to the Computle machines. To connect to their machines, customers can instead create outbound tunnels and connect via private network ranges. Public endpoints can also be whitelisted to restrict inbound traffic to certain IP ranges.

***

## Global Subnet Ranges

We utilise Carrier-Grade Network Address Translation (CGNAT) for internal IP ranges, covering Computle Machines, and Computle Gateway devices. All devices operate within the 100.X.X.X/10) range. CGNAT ensures that our internal network addresses remain distinct from external or public IP addresses allowing customers to integrate Computle with existing infrastructure without unexpected routing impacts.

&#x20;

| Site  | Compute Machines | Gateway Devices |
| ----- | ---------------- | --------------- |
| UK-A  | 100.64.0.0/19    | 100.64.32.0/19  |
| UK-B  | 100.65.0.0/19    | 100.65.32.0/19  |
| NY-A  | 100.66.0.0/19    | 100.66.32.0/19  |
| NY-B  | 100.67.0.0/19    | 100.67.32.0/19  |
| LA-A  | 100.68.0.0/19    | 100.68.32.0/19  |
| LA-B  | 100.69.0.0/19    | 100.69.32.0/19  |
| HK-A  | 100.74.0.0/19    | 100.74.32.0/19  |
| HK-B  | 100.75.0.0/19    | 100.75.32.0/19  |
| SYD-A | 100.76.0.0/19    | 100.76.32.0/19  |
| SYD-B | 100.77.0.0/19    | 100.77.32.0/19  |
| PL-A  | 100.78.0.0/19    | 100.78.32.0/19  |
| PL-B  | 100.79.0.0/19    | 100.79.32.0/19  |
| DXB-A | 100.80.0.0/19    | 100.80.32.0/19  |
| DXB-B | 100.81.0.0/19    | 100.81.32.0/19  |
| SGP-A | 100.82.0.0/19    | 100.82.32.0/19  |
| SGP-B | 100.83.0.0/19    | 100.83.32.0/19  |
