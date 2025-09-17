# Intune/Entra ID and Computle, BitLocker

This knowledge base article covers common enrollment and device management issues seen when utilising Microsoft services in conjunction with Computle.

***

#### **\[1] You experience irregular MFA prompts or irregular sign-in prompts. \[2] You may experience issues with Windows 11 Enterprise uplifts.** <a href="#id-1-you-experience-irregular-mfa-prompts-or-irregular-sign-in-prompts-2-you-may-experience-issues-with" id="id-1-you-experience-irregular-mfa-prompts-or-irregular-sign-in-prompts-2-you-may-experience-issues-with"></a>

**Synopsis:** Users may experience irregular Microsoft Authenticator requests when using Windows 11 Professional/Enterprise. Messages include "Please sign in to your work or school account to verify your information", "Verify your account" and "We weren't able to connect. Sign in and we'll try again". You may also see issues with device compliance when using Conditional Access policies.

**Windows 11 Enterprise uplift**

* **Cause:** Microsoft Authenticator/3rd party MFA can interfere with the Primary Refresh Token. When Windows is unable to refresh the token, Microsoft removes the Enterprise uplift and can mark the device as non-compliant.
* **Solution:** Per Microsoft [guidelines](https://learn.microsoft.com/en-us/windows/deployment/windows-subscription-activation?pivots=windows-11\&ref=blog.computle.com), you should remove the MFA requirement on the following applications:
  * Universal Store Service APIs and Web Application, AppID 45a330b1-b1ec-4cc1-9161-9f03992aa49f;
  * Windows Store for Business, AppID 45a330b1-b1ec-4cc1-9161-9f03992aa49f;
  * And in our testing, the Microsoft Intune application, AppID 0000000a-0000-0000-c000-000000000000.

**MFA for device enrollment**

* **Cause:** Microsoft Authenticator/3rd party MFA can interfere with the Primary Refresh Token. When Windows is unable to refresh the token, Intune can then mark the device as non-compliant, in turn triggering a sign-out of M365 desktop apps. This may then result in apps failing to sign in.
* **Solution:** Exclude Microsoft Authenticator when enrolling devices into Intune and create a secure, dedicated enrolment account. To do this, head to Entra ID > Devices > Device Settings > and untick MFA on enrolment. Then, create a device enrolment user and configure your enrolment policies to only allow that user.

You should also ensure that Conditional Access policies are updated to match the settings above.

**Third party MFA**

* **Cause:** Default Conditional access policies can interfere with third party MFA.
* **Solution:** Confirm sign-in frequency requirements under Conditional Access > Session > Sign-in frequency.

**Credential cache**

* **Cause:** Cached credentials can cause an immediate failure when trying to re-authenticate with OneDrive/M365 desktop apps.
* **Solution:** Delete the contents of this folder and then re-authenticate.

_C:\Users\\{username}\AppData\Local\Packages\Microsoft.AAD.BrokerPlugin\_cw5n1h_

***

#### **\[1] BitLocker enters a recovery state. \[2] BitLocker re-arms and locks the device.** <a href="#id-1-bitlocker-enters-a-recovery-state-2-bitlocker-re-arms-and-locks-the-device" id="id-1-bitlocker-enters-a-recovery-state-2-bitlocker-re-arms-and-locks-the-device"></a>

**Synopsis:** Computle machine asks for a recovery key on system reboots.

* **Cause:** By default, Windows will lock the BitLocker drive after 4 to 32 incorrect login attempts. BitLocker then resets at a rate of one failure count every two hours. Due to the nature of Computle, where users may share a machine, normal usage behaviour can trigger brute force protection policies. In addition, failed logins from threat actors can also trigger this lockout threshold.
* **Solution:**
  * Configure IP whitelisting/Zero Trust and restrict Computle to dedicated IPs/devices. See our [guide](https://blog.computle.com/zero-trust-and-vdi-how-to-secure-access-with-computle/) for more information.

_Or:_

* Amend the default lockout value under Group Policy > Computer Configuration > Administrative Templates > System > Trusted Platform Module Services > Standard User Individual Lockout Threshold.

_Or:_

* Amend the default lockout value under Intune Device Configurations > Administrative Templates > System > Trusted Platform Module Services.

_Or:_

* Configure [Network Unlock](https://learn.microsoft.com/en-us/windows/security/operating-system-security/data-protection/bitlocker/network-unlock?ref=blog.computle.com).
