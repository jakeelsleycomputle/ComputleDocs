# Unable To Login

**Local Administrator**

To use the local Administrator account, you can reset the password via Portal > Machine > Options > Administrator Password > Reset Password

***

**EntraID/AzureAD**

Pure EntraID/AzureAD joined machines should use `AzureAD\Your@Email.com.`

You can workaround this by using Computle Device, or by creating a shortcut that parses the AzureAD prefix.&#x20;

***

**On-Premise Active Directory**

For on-premise Active Directory, you should use `DOMAIN\Username`.

***

**Connect Button Inactive**

If you get an error where DCV does not connect, please install the latest [Microsoft Visual C++ Redistributable](https://aka.ms/vs/17/release/vc_redist.x64.exe).

Alternatively, you can use the web client, but note that performance will be reduced.

***

**No Session Available**

Please ensure the [License Server](dcv-server-license-warning.md) details are set and that a user is assigned in `HKEY_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\session-management\automatic-console-session`.

{% hint style="danger" %}
DCV 2025 was released 22nd October 2025, with all Computle users running DCV 2024. Certain IT management platforms may identify this new version and automatically deploy it. Doing so results in “no session available” errors, blocking sign-in. This is caused by an unavailability of licensing for this specific release, which will be rectified when this version is production ready. Please do not upgrade unless specifically requested to do so. DCV has no automatic update mechanism, therefore, most users should not be impacted. However, if impacted, you must rollback to the production stable release, DCV 2024. Read more dcv[reinstall-dcv-server.md](../../component-reinstallation/reinstall-dcv-server.md "mention").
{% endhint %}
