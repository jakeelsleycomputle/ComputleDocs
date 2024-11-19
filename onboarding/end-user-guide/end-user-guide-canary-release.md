# End User Guide (Canary Release)

This guide is intended for end users looking to access their Computle Machine using the **Canary Release**. If you are an administrator, please follow the Administrator Guide.

{% hint style="info" %}
**Time Required**

Please allow 15 minutes.&#x20;
{% endhint %}

{% hint style="info" %}
**Your Own Device**

This guide assumes that you are using your own device. If you are using Computle Device, or you are not sure, please ask your system administrator.&#x20;
{% endhint %}

{% hint style="warning" %}
**Computle Gateway Token**

Ensure that your administrator has shared a Computle Gateway token with you.&#x20;
{% endhint %}

***

## Stage 1 of 3: Install Computle Gateway

1. Download Computle Client client to your device.

* [Windows](https://download.wireguard.com/windows-client/wireguard-amd64-0.5.3.msi)

2. Launch the downloaded file.

<div align="left">

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

</div>

2. Install WireGuard

<div align="left">

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

</div>

3. Launch WireGuard
4. Click "Import tunnel(s) from file".

<div align="left">

<figure><img src="../../.gitbook/assets/image (3) (1) (1).png" alt=""><figcaption></figcaption></figure>

</div>

5. Select the token that your administrator sent to you and click Open.

<div align="left">

<figure><img src="../../.gitbook/assets/image (4) (1) (1).png" alt=""><figcaption></figcaption></figure>

</div>

6. Click Activate.

<div align="left">

<figure><img src="../../.gitbook/assets/image (9).png" alt=""><figcaption></figcaption></figure>

</div>

6. Proceed to Stage 2 of 3.

{% hint style="info" %}
If you receive a file name error, ensure that there are no spaces in your token file's name, or extra numbers. For example, if you downloaded the file multiple times, delete all copies, and re-download the token.&#x20;
{% endhint %}

***

## Stage 2 of 3: Install Computle Client

1. Download Computle Client for Windows:

{% hint style="info" %}
[Computle\_Client\_x64\_2024.09.01.0.exe](https://downloads.oncomputle.com/Computle\_Client\_x64\_2024.09.01.0.exe)
{% endhint %}

2. Enter your tenant UUID, username, and password.&#x20;
3. Read the EULA
4. Click Install

***

## Stage 3 of 3: Launch Computle Client

1. Launch Computle Client
2. Click on Settings and ensure that the tenant name matches your organisation.
3. Connecting to your assigned machine is easy. Simply enter your username, and your assigned machine is automatically presented.

<div align="left">

<figure><img src="https://blog.computle.com/content/images/2024/09/image-2-1-1.png" alt="" height="549" width="403"><figcaption><p>Computle Client App</p></figcaption></figure>

</div>

<div align="left">

<figure><img src="https://blog.computle.com/content/images/2024/09/image-3-1-1-1.png" alt="" height="549" width="404"><figcaption></figcaption></figure>

</div>

***

**Gateway Privacy**

Computle Gateway acts as a network tunnel enabling you to access your company resources. By default, Computle Gateway does not monitor, collect, or log data sent to network resources outside of your company resources. When you are not using Computle Gateway you are free to disconnect the client. However, during normal use, your internet and network traffic is routed to your home/office router.&#x20;
