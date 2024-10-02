---
cover: ../.gitbook/assets/iStock-1291584234.jpg
coverY: 1165
layout:
  cover:
    visible: true
    size: full
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# Shared Responsibility Model

When migrating to Computle, it's crucial to understand which responsibilities are handled by Computle and which remain with your internal team or technical support provider. Below, we outline the end-to-end system architecture, from hardware provisioning to end-user support, and clarify the division of responsibilities.

### Division of Responsibility

In traditional computing setups, workstations are physically located in offices or home environments. You or your technical support provider handle hardware procurement, maintenance, upgrades, and disposal. With Computle, these responsibilities are streamlined and shifted to us. We fully manage the provisioning, maintenance, and lifecycle of the workstations in our data centres. However, the workstation service is just one aspect of your overall IT infrastructure.

***

### User and Identity Management

**Computle:**

* Computle can host virtualized domain controllers on Hyper-V. There is no fee for this service.
* Computle can provide virtualized Windows Server X instances which can be provisioned by you or your technical support provider as a Domain Controller. There is no fee for this service.
* Each customer is provided with a self-service portal which allows them to reset the local administrator account on provisioned workstations.

**You or your technical support provider:**

* You or your technical support provider handle all aspects of user management, including account creation, access permissions, password resets, and identity management (Azure AD, Google Workspace, etc.).

***

### Networking

**Computle:**

* Computle manages the network connections within its data centres, ensuring workstations and virtualized infrastructure are connected to the internet.
* Computle provides and operates [Computle Gateway](../reference-architecture/tenant-level-configuration/network-access/tenant-defaults/computle-gateway/) VPN services (excluding user provisioning).
* Manages upstream providers and peering relationships, floating public IP addresses, IP address assignment, public DNS management, and tenant namespaces.

**You or your technical support provider:**

* You are responsible for office network infrastructure, internet connections, firewalls, VPNs and user profiles for Computle Gateway, WiFi, routers, and switches.

***

### Cloud Services

**Computle:**

* Computle provides connectivity for workstations to access cloud environments but does not manage the actual cloud services (e.g., Office 365, Google Workspace, Azure, AWS, GCP).

**You or your technical support provider:**

* You handle cloud service management, including licensing, user access, security configurations, and cloud infrastructure provisioning.

***

### Servers and Storage

**Computle:**

* Computle can host virtualized storage systems, ensuring clients can access their storage and data from a localised environment.
* Computle can host virtualized storage solutions like Panzura.

**You or your technical support provider:**

* You manage data residency, compliance, file management, data integrity, and other storage or caching solutions.

***

### Applications

**Computle:**

* Computle applies software updates to the underlying hypervisors, networking equipment, routers, and firewalls at regular intervals.&#x20;
* Computle maintains vulnerability management across our estate.
* Computle does not manage software installation or updates on the Windows instance.

**You or your technical support provider:**

* You manage the installation, maintenance, and updates of applications (e.g., Office 365, Adobe, custom software) across your infrastructure.

***

### Imaging&#x20;

**Computle:**

* Computle provides each customer with a self-service portal where they can perform machine-level changes such as the deployment of Windows images and the reimaging of the virtual machine.
* Computle provides free image hosting services as required.&#x20;
* Computle provides remote access to the virtual machine during the boot cycle to enable the deployment of custom images.
* Computle can host virtualised environments as required, such as Windows Deployment Services shares and hosts.
* Computle can provide DHCP services for solutions such as Windows Deployment Services.
* Computle can provide a managed image deployment service as part of a professional services agreement.&#x20;

**You or your technical support provider:**

* You manage the installation, maintenance, and updates of the Windows image to your Computle workstations, outside of any professional services agreement.&#x20;

***

### Licensing&#x20;

**Computle:**

* Computle handles Windows 11 Professional licensing for the hosted workstation infrastructure.

**You or your technical support provider:**

* You manage software licensing and subscriptions for productivity suites, antivirus software, Client Access Licenses, and other necessary tools for your business operations.

***

### Printers&#x20;

**Computle:**

* Computle does not manage printers.
* Computle can support the implementation of VPN solutions to enable access to network based devices.

**You or your technical support provider:**

* You are responsible for managing printers, scanners, copiers, and other peripherals, including print servers, drivers, and troubleshooting.

***

### Security

**Computle:**

* Computle ensures the security of the Computle infrastructure as defined [here](shared-responsibility-model.md#security). &#x20;
* Computle ensures basic security for hosted workstations, such as firewall rules and optional encryption within its data centres.

**You or your technical support provider:**

* You handle endpoint protection, network firewalls, VPN setups, email filtering, and compliance with data security regulations.

***

### Data Integrity and Availability&#x20;

**Computle:**

* Computle ensures stable operation of the virtualized environment and ensures that Computle services meet the defined [SLA](shared-responsibility-model.md#contracts-and-slas) requirements.&#x20;
* Computle does not routinely manage backups of client data or disaster recovery solutions unless otherwise agreed.

**You or your technical support provider:**

* You manage data backup solutions (cloud, on-prem, or hybrid) and implement disaster recovery plans to ensure data recovery, unless otherwise agreed.&#x20;

***

### Email

**Computle:**

* Computle does not manage email systems.

**You or your technical support provider:**

* You manage email platforms like Microsoft Exchange, Office 365, Gmail, or other email systems, including user provisioning, security, spam filtering, and email backup.

***

### Compliance

**Computle:**

* Computle ensures hosted workstations and virtualized resources comply with ISO27001 security standards at a compute-level and data-centre level.&#x20;

**You or your technical support provider:**

* You are responsible for ensuring compliance with industry regulations (e.g., GDPR, HIPAA) across your IT infrastructure, including data storage, encryption, and access controls.

***

### Monitoring&#x20;

**Computle:**

* Computle monitors the health and performance of hosted workstations and virtualized systems.
* Computle collects telemetric data from Computle applications and from the virtual machines.&#x20;
* Computle identifies bugs and fixes to operational issues.&#x20;

**You or your technical support provider:**

* You manage broader monitoring tools for your entire IT environment, including network performance, cloud service uptime, server health, and security monitoring.

***

### Support

**Computle:**

* Computle ensures workstations in its data centres are functioning properly and provides support connecting to your Computle workstation.&#x20;
* Computle does not provide end-user support for other matters unless covered under a professional services agreement.&#x20;

**You or your technical support provider:**

* You handle day-to-day end-user support, including software issues, password resets and general troubleshooting.

***

### Hardware

**Computle:**

* Computle manages the physical infrastructure in its data centres, including hypervisors, storage infrastructure, networking devices, and other required hardware.&#x20;
* Computle remotely manages Computle Devices that exist in client locations, such as offices, or homes. For the lifetime of the device, we provide diagnostics and repairs as required.

**You or your technical support provider:**

* You manage office hardware like printers, network equipment, monitors, and peripherals.

***

### SLAs&#x20;

**Computle:**

* Computle maintains [SLAs](shared-responsibility-model.md#slas) covering the availability and uptime of hosted workstations in its data centres.

**You or your technical support provider:**

* You manage contracts and SLAs with other service providers like internet providers, cloud platforms, and software vendors.

***

### Automation

**Computle:**

* Computle routinely implements automation within the Computle estate but does not manage scripting for broader IT needs.&#x20;
* Computle provides scripts for the provision and repair of self-service [Computle components](broken-reference), such as our streaming applications, for use by you or your technical support provider.&#x20;

**You or your technical support provider:**

* You manage automation scripts for system backups, software updates, and network monitoring.

***

### Telephony

**Computle:**

* Computle does not manage telephony systems or VoIP infrastructure.

**You or your technical support provider:**

* You are responsible for telephony, including managing VoIP services, phone systems, and platform integration like Microsoft Teams or Google Meet.

