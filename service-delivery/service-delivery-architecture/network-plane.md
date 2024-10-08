---
cover: ../../.gitbook/assets/iStock-1188002056.jpg
coverY: 294.5084745762712
---

# Network Plane

## Core networking

At each of our global locations, Computle leverages a spine-leaf architecture to ensure high-performance networking for tenant workloads. Each machine provisioned within a tenant namespace is assigned its own dedicated 1Gbps interface, ensuring bandwidth consistency and high availability for each user. These dedicated connections extend into the aggregation layer, which is built on 40Gbps and 100Gbps interfaces, allowing for seamless scaling and optimal throughput. The aggregation layer is backed by multiple uplinks to our global carriers, ensuring redundancy, low-latency connections, and high reliability for all tenant traffic.

***

## **Global subnet ranges**

Every Computle Machine is provisioned within a tenant-specific namespace, ensuring strict physical and logical isolation between customers. The provisioning process assigns each machine a private IP address, which is mapped to the tenant's unique identifier (tenantID) and region. This private IP address is part of our Carrier-Grade Network Address Translation (CGNAT) system, operating within the 100.X.X.X/10 range. This structure ensures that Computle Machines and Computle Gateway devices remain isolated from public networks, while seamlessly integrating with the customer's existing infrastructure without causing routing conflicts.

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

***

## **Namespace routing**

Routing within tenant namespaces is tightly controlled. Each tenant operates in a dedicated, isolated network environment, and all routing decisions are made at the namespace level. Traffic between tenant machines and external endpoints is routed through Computle Gateway, providing secure and scalable access for users. Our network topology is designed to ensure minimal latency, with spine-leaf routing architectures optimized for both intra-tenant communication and access to external resources. By utilizing this scalable routing structure, we maintain secure, tenant-specific network boundaries while offering flexible connectivity options for customer environments.

***

## **Security framework**&#x20;

We employ a comprehensive security framework that blocks all inbound access by default, ensuring that tenant machines are never directly exposed to the internet or external threats. Access to tenant resources is only available through the Computle Gateway, our per-tenant VPN service. The Gateway provides secure VPN access, ensuring that only authenticated users can connect to their assigned machines. All traffic passing through the Gateway is subject to access control policies at both the network and application layers.&#x20;

For customers requiring additional control over their network security, there is an option to deploy custom firewall appliances in front of Computle Machines. Customers can configure their firewall appliances to manage intrusion detection, traffic inspection, and logging policies, providing an extra layer of control in addition to Computle’s default security protections. This service is provided as an optional add-on with supported firewall images including Hyper-V and Linux KVM.&#x20;

***

## **Public endpoint**

While tenants are assigned public IP addresses for each region, these IPs are dynamic and can change without notice. Starting in 2024, we are deprecating direct public access to tenant-level resources. Going forward, all access will be funneled through Computle Gateway or another secure network access solution, such as a VPN or Zero Trust platform. The Computle Gateway is part of our Tenant Defaults offering and is enabled by default for all new deployments, with phased rollouts planned for existing users. Accessing resources through the Gateway is as simple as connecting to the endpoint format: `gatewayID.region.tenantID.prd.computle.net`. Customers who wish to use custom CNAME records may do so, although these are purely administrative and do not affect the underlying access.

***

## Carriers

Our global carriers provide the backbone for all tenant communication, ensuring low-latency, high-bandwidth connections. This carrier diversity ensures both reliability and high-performance connectivity, with automatic failover mechanisms to mitigate any potential downtime. These include:

* Lumen Technologies
* NTT Communications
* Telia Carrier
* Tata Communications
* Arelion
* Cogent Communications
* GTT Communications
* PCCW
* Telstra
* Zayo Group

***

## Mesh network

Customers utilising distributed storage solutions like _Panzura_ can leverage Computle’s free **mesh network** infrastructure, which connects multiple sites through a robust, high-performance network. This mesh topology, depicted in the diagram, seamlessly interconnects different locations (such as **UK-A**, **UK-B**, and **SYD-A**) using dedicated **Tenant Routers** and **Public Endpoints**. The green dashed lines in the diagram represent the connections forming the mesh between different regions and data centers.

**Components:**

* **Tenant Routers**: These routers handle traffic specific to a tenant, providing dedicated, secure paths for tenant data within the Computle infrastructure. They ensure high availability and low-latency routing between customer sites.
* **Public Endpoints**: These act as access points for external connectivity, allowing secure connections between on-premises systems (such as those in customer offices) and the distributed storage solutions. Each site is equipped with redundant **Public Endpoint A** and **Public Endpoint B** connections for failover and redundancy.
* **CPE (Customer Premises Equipment)**: This links the customer's on-prem systems to the mesh network, enabling direct access to the tenant routers and public endpoints.
* **Computle Broker**: The broker facilitates and manages network traffic between the customer’s systems and the tenant’s environment, ensuring traffic is routed optimally between locations.

<figure><img src="../../.gitbook/assets/image (7).png" alt=""><figcaption><p>Computle Mesh Network Example</p></figcaption></figure>

