# Machine Portal

## **Overview**

Each customer gets access to a dedicated machine portal, enabling you to perform tasks such as workstation reboots, password resets, and rebuilds.

<figure><img src="../../.gitbook/assets/image (6).png" alt=""><figcaption><p>Computle Machine Portal</p></figcaption></figure>

***

## **Portal access**

{% hint style="warning" %}
As part of our tenant-defaults, access to this portal is available only via Computle Gateway, or another supported VPN/Zero Trust solutions.&#x20;
{% endhint %}

By default, each tenant is provisioned with one user who has full administrative rights and access to the portal. Multi-Factor Authentication (MFA) is required.&#x20;

To access the portal, navigate to the unique URL provided to you, which typically follows the format:

```
tenantID.computle.net
```

If you haven't received this information, or require further assistance, please contact Computle support.

***

## **Machine controls**

*   **Boot**: This button powers on the machine if it is currently powered off. Use this when you need to start a machine from a shutdown or powered-off state.


*   **Shutdown**: Clicking this button safely powers down the machine.


*   **Restart**: This button reboots the machine without powering it off completely.


* **Power Off**: This option forcibly turns off the machine, similar to cutting power to a physical system. This should only be used if the machine is unresponsive.

***

## **Image deployment**

You can reimage Computle Machines using the Rebuild button. By default, we capture nightly builds, unless otherwise requested.&#x20;

**Steps:**

1. Click Rebuild.
2. Select the image you wish to deploy.
3. The image will deploy in around 30 seconds.

<figure><img src="../../.gitbook/assets/image (1).png" alt=""><figcaption><p>Computle Machine Re-Imaging</p></figcaption></figure>

***

## **Console access**&#x20;

The VNC section provides access to the machine’s virtual console, allowing administrators to connect to the machine as if they were physically present in front of it.

**Steps:**

1. Click the **Enable VNC Access** button to activate VNC functionality.
2. A new window or link will be generated, allowing you to remotely view and control the machine.

***

## **Password reset**

**Reset Password**: This feature allows you to reset the administrator password for the machine.

**Steps:**

1. Click the **Reset Password** button.
2. A new temporary password will be emailed to you.

&#x20;
