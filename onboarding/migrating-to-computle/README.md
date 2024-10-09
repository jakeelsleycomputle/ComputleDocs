---
cover: ../../.gitbook/assets/IT-professionals.jpg
coverY: 455
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
    visible: false
---

# Migrating to Computle

## Pre-Migration

{% hint style="success" %}
**Parsec / Teradici PCoIP**

As the sole UK reseller for NICE DCV, we are able to offer new customers **free** migration licenses for NICE DCV. Benefit from the rich range of capabilities, such as audio/visual calls and 4K support.&#x20;
{% endhint %}

{% hint style="info" %}
**GPU Analyser**&#x20;

To help customers identify their system usage, we recommend that you install Computle's [GPU Analyser](gpu-analyser.md) ahead of the migration. This helps you accurately understand system usage and the best plans for your workloads.&#x20;
{% endhint %}

***

## Moving to Computle

When transitioning to Computle, the three most important aspects of the move are:

1. **Data:** Ensuring all your valuable information is securely and completely transferred to our platform.
2. **IDAM (Identity & Access Management):** Seamlessly migrating your identity management systems to ensure smooth access and permissions post-migration.
3. **Image Build:** Recreating or developing a fresh machine image on Computle for future use.
4. **Hardware:** Whether you will use your own devices, or use [Computle Device](../administrator-guide/computle-device.md).

***

## Shared Responsibilities  <a href="#user-and-identity-management" id="user-and-identity-management"></a>

For more information, head [here](../../service-delivery/service-operations/shared-responsibility-model.md).

{% hint style="info" %}
**Best Endeavor Assistance**

All services here are provided free, on a best-endeavours basis. Additional costs may apply if the services rendered are extensive or complex.
{% endhint %}

### **User and Identity Management** <a href="#user-and-identity-management" id="user-and-identity-management"></a>

**Computle:**

* Computle can host virtualized domain controllers on Hyper-V. There is no fee for this service.
* Computle can provide virtualized Windows Server X instances which can be provisioned by you or your technical support provider as a Domain Controller. There is no fee for this service.
* Each customer is provided with a self-service portal which allows them to reset the local administrator account on provisioned workstations.

**You or your technical support provider:**

* You or your technical support provider handle all aspects of user management, including account creation, access permissions, password resets, and identity management (Azure AD, Google Workspace, etc.).

### Servers and Storage <a href="#servers-and-storage" id="servers-and-storage"></a>

**Computle:**

* Computle can host virtualized storage systems, ensuring clients can access their storage and data from a localised environment.
* Computle can host [virtualized storage solutions](../../service-delivery/service-delivery-architecture/storage-providers.md) like Panzura, or Computle Files.&#x20;

**You or your technical support provider:**

* You or your technical support provider manage data residency, compliance, file management, data integrity, and other storage or caching solutions.

***

## Migration Routes

### Route 1: Non-Cooperative Move

In cases where the incumbent provider refuses to engage with us during the transition, we take the following approach:

1. **Data Migration:** We clone all your data and securely migrate it to our environment, ensuring no loss or corruption during the process.
2. **New Domain Controller (DC) / Azure AD Setup:** We create a new Domain Controller or Azure AD environment to ensure your organization remains fully functional and secure.
3. **Basic Image Build:** We construct a basic machine image for your needs.&#x20;

### Route 2: Cooperative Move

If the incumbent provider allows for a smooth transition, we follow these steps:

1. **Domain Controller Migration (Single Site):** We migrate your Domain Controllers if they are part of a single site, ensuring continuity for your existing infrastructure. For companies with multiple locations, we provide a new, additional Windows Server X instance. This is then configured by **you or your technical support provide** configure. **Note that in all instances, we only support the importing of virtualised domain controllers.**
2. **Data Migration with Planning:** We work with the incumbent provider to plan **migration windows** that minimize downtime and disruption. For _traditional file shares_, this includes using **delta sync** techniques to transfer data in stages, ensuring that the final switch to Computle is seamless with the least possible interruption to your workflow. In the case of _managed storage solutions_, such as as _Panzura_, we deploy the virtualised image and work directly with Panzura to implement the service.&#x20;
3. **Image Build:** We provide the tools necessary to create your first Computle Image. Note that we do not support importing existing images from the previous provider, unless they come in the form of a Windows Deployment Services (WDS) sequence.&#x20;

***

## Recommendations for Single Site Customers

If this migration involves your only site, we strongly recommend migrating all your resources and keeping them local on the Computle side. This helps with ease of management and ensures the highest levels of performance and reliability for your systems.

***

## Linked Services: M365 and Beyond

While Computle exclusively provides **workstations**, we understand that many organizations rely on linked services such as Microsoft 365 (M365) for productivity, communication, and collaboration.

Though we do not manage or provision accounts, licenses, or other third-party services, our platform is fully compatible with these solutions. Our workstations are designed to seamlessly integrate with M365 and similar cloud-based services, allowing your team to continue working without interruption.

If your organization uses other third-party tools like OneDrive, Teams, or SharePoint, our workstations are built to support these services out of the box, ensuring that your employees can access the resources they need with no additional setup.
