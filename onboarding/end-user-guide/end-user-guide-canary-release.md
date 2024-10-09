---
hidden: true
---

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

## Stage 1 of 3: Install Computle Client

1. Download Computle Client client to your device.

* [Windows](https://download.wireguard.com/windows-client/wireguard-amd64-0.5.3.msi)
* [Mac](https://itunes.apple.com/us/app/wireguard/id1451685025?ls=1\&mt=12)

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

## Stage 2 of 3: Install NICE DCV

1. Download NICE DCV:

* [Windows](https://d1uj6qtbmh3dt5.cloudfront.net/nice-dcv-client-Release.msi)
* [Mac](https://d1uj6qtbmh3dt5.cloudfront.net/nice-dcv-viewer.x86\_64.dmg)

2. Launch the downloaded file.

<div align="left">

<figure><img src="../../.gitbook/assets/image (8) (1) (1).png" alt=""><figcaption></figcaption></figure>

</div>

<div align="left">

<figure><img src="../../.gitbook/assets/image (7) (1) (1).png" alt=""><figcaption></figcaption></figure>

</div>

3. Read the EULA&#x20;

<div align="left">

<figure><img src="../../.gitbook/assets/image (10).png" alt=""><figcaption></figcaption></figure>

</div>

4. Select the X dropdown and click **"Will be installed on local hard drive"**

<div align="left">

<figure><img src="../../.gitbook/assets/image (9) (1).png" alt=""><figcaption></figcaption></figure>

</div>

5. Click Next

<div align="left">

<figure><img src="../../.gitbook/assets/image (11).png" alt=""><figcaption></figcaption></figure>

</div>

6. Click Install

<div align="left">

<figure><img src="../../.gitbook/assets/image (12).png" alt=""><figcaption></figcaption></figure>

</div>

7. **Windows Users Only**: Install the latest [Microsoft Visual C++ Redistributable](https://aka.ms/vs/17/release/vc\_redist.x64.exe).

<div align="left">

<figure><img src="../../.gitbook/assets/image (13).png" alt=""><figcaption></figcaption></figure>

</div>

***

## Stage 3 of 3: Launch NICE DCV

1. **Launch NICE DCV**

On Windows, search your Start Menu, and on Mac, search your Applications folder.

<div align="left">

<figure><img src="../../.gitbook/assets/image (14).png" alt=""><figcaption></figcaption></figure>

</div>

2. **Enter your Computer name**

In Hostname, enter the Computer name provided by your administrator.

<div align="left">

<figure><img src="../../.gitbook/assets/image (15).png" alt=""><figcaption></figcaption></figure>

</div>

3. Click _Connect._
4. If promoted, click Trust and Connect

<div align="left">

<figure><img src="../../.gitbook/assets/image (17).png" alt=""><figcaption></figcaption></figure>

</div>

4. **Enter your username**

In Login, enter the login name provided by your administrator.\


<div align="left">

<figure><img src="../../.gitbook/assets/image (18).png" alt=""><figcaption></figcaption></figure>

</div>

5. **Enter your password**

In Password, enter the password provided by your administrator.\
\
Then, click OK.

***

## Tip

When you connect again, click the down arrow to retrive your saved machine(s).

<div align="left">

<figure><img src="../../.gitbook/assets/image (24).png" alt=""><figcaption></figcaption></figure>

</div>

***

**Gateway Privacy**

Computle Gateway acts as a network tunnel enabling you to access your company resources. By default, Computle Gateway does not monitor, collect, or log data sent to network resources outside of your company resources. When you are not using Computle Gateway you are free to disconnect the client. However, during normal use, your internet and network traffic is routed to your home/office router.&#x20;
