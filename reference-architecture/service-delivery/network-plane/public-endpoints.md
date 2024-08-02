# Public Endpoints

## tenantPublicIP

Tenants are assigned public IP addresses for each region. Whilst these IPs are dedicated to one customer, they are dynamic and subject to change without warning.&#x20;

## Public Endpoint

{% hint style="info" %}
As of August 2024, we are depreciating public access to tenant-level resources. Going forward, users will be required to access tenant resources via _Computle Gateway_, or another network access product, such as VPN, or Zero Trust solutions. _Computle Gateway_ forms part of our Tenant Defaults offering, enabled for all new deployments, and delivered in phases for existing users.
{% endhint %}

Gateway users will access their resources via `gatewayID.region.tenantID.prd.computle.net` endpoint.&#x20;

***

## Depreciated: Inbound Restrictions and CNAME Configuration

For ease of use, customers can add their own CNAME records to route to the machineID.region.tenantID.prd.computle.net endpoint. This enables you to create entries such as machine1.contoso.com.

Where requested, Computle can disable all inbound public access to the Computle machines. To connect to their machines, customers can instead create outbound tunnels and connect via private network ranges. Public endpoints can also be whitelisted to restrict inbound traffic to certain IP ranges.
