# Computle Broker

The **Computle Broker Agent** helps you manage machine assignments by dynamically updating based on the device's hostname and assigned user.  Computle Broker is available free of charge to Computle customers.

{% hint style="warning" %}
Computle Broker requires an existing VPN solution such as [Computle Gateway for SMEs. ](../../onboarding/administrator-guide/computle-gateway-for-smes.md)
{% endhint %}

***

## Broker Agent <a href="#broker-agent" id="broker-agent"></a>

Each Computle machine is supplied with our brokering agent. This agent is responsible for dynamic machine assignment based on the device's hostname and the assigned user.

<div align="left">

<figure><img src="https://blog.computle.com/content/images/2024/09/Screenshot-2024-09-26-005922.png" alt="" height="232" width="348"><figcaption><p>Broker Agent</p></figcaption></figure>

</div>

***

## Assignment Manager <a href="#assignment-manager" id="assignment-manager"></a>

Administrators can access a simple interface where they can assign machines. Within here, they can also browse previous versions of the assignments and restore previous versions where required.

<div align="left">

<figure><img src="https://blog.computle.com/content/images/2024/09/image-1.png" alt=""><figcaption></figcaption></figure>

</div>

***

## End User Experience

Connecting to your assigned machine is easy. Simply enter your username, and your assigned machine is automatically presented.

<div align="left">

<figure><img src="https://blog.computle.com/content/images/2024/09/image-2-1-1.png" alt="" height="549" width="403"><figcaption><p>Computle Client App</p></figcaption></figure>

</div>

<div align="left">

<figure><img src="https://blog.computle.com/content/images/2024/09/image-3-1-1-1.png" alt="" height="549" width="404"><figcaption></figcaption></figure>

</div>

***

## **Security and API Key Authentication**

Each tenant is assigned a unique API key, which is used to authenticate access to their machines and data. All communications between the Computle Broker Agent and our servers are encrypted using HTTPS, ensuring that data in transit is secure. API keys ensure that only authorized users can interact with the system.

Tenant data is fully isolated, with each tenant’s information stored in a dedicated, separate environment to prevent cross-access between tenants. This ensures that machine assignments and other sensitive information remain secure and exclusive to each tenant.

***

## Service Resiliency&#x20;

**High Availability**

Computle's infrastructure is designed with high availability in mind, ensuring that our services remain operational even in the event of hardware failures or network issues. Each component of our system, from storage to compute, is built with redundancy and failover mechanisms to maintain uptime. This architecture helps provide continuous access to machine assignments and ensures that the Computle Broker Agent can perform without interruption.

**Caching for Reliability**

In the event that the app is unable to download the latest assignment file due to a network issue or API unavailability, the app intelligently caches the last known good file. This ensures that users can continue to work with their assigned machines even during temporary disruptions. As soon as connectivity is restored, the app will automatically attempt to download the latest file, maintaining seamless operation without user intervention.\


***

## Installation Guide

{% hint style="warning" %}
Ensure that you have your API credentials before installing Computle Broker.&#x20;
{% endhint %}

{% hint style="warning" %}
Computle Broker requires the pre-installation of [NICE DCV](../../troubleshooting/component-reinstallation/reinstall-dcv-server.md).
{% endhint %}

### Computle Client

Computle Client runs on the user's device and provides easy access to your Computle machine.

{% hint style="info" %}
[Computle\_Client\_x64\_2024.09.01.0.exe](https://downloads.oncomputle.com/Computle\_Client\_x64\_2024.09.01.0.exe)
{% endhint %}

**Unattended installation**

`Computle_Client_x64_2024.09.01.0.exe /S /USERNAME=YourUsername /PASSWORD=YourPassword /TENANT=YourTenantUUID /AGREETERMS`

### Computle Agent

Computle Agent runs on the target machine and handles the automatic allocation.

{% hint style="info" %}
[Computle\_Agent\_x64\_2024.09.01.0.exe](https://downloads.oncomputle.com/Computle\_Agent\_x64\_2024.09.01.0.exe)
{% endhint %}

**Unattended installation**

`Computle_Agent_x64_2024.09.01.0.exe /S /USERNAME="YourUsername" /PASSWORD="YourPassword" /TENANT_UUID="YourTenantUUID" /ACCEPT_TERMS`







