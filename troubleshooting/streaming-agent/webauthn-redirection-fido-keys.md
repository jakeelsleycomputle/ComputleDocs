# WebAuthn Redirection/FIDO Keys

WebAuthn redirection requires a **browser extension** to be installed on the Computle Machine. When the feature is enabled and the browser extension is installed, any WebAuthn requests initiated by the web applications running in the browser within the session are seamlessly redirected to the local client. Users can then use utilize devices like Windows Hello or YubiKey to finalize the authentication.

### Automatic Prompt on First Browser Launch

Users are prompted to enable the DCV browser extension when they first launch their browser. If they choose not to install the extension or uninstall it later, WebAuthn redirection will not work. An administrator can enforce installation using the Group Policy.

### Installing Using the Group Policy <a href="#w16aac16c51c19b5" id="w16aac16c51c19b5"></a>

For organizations looking to deploy the extension on a broader scale, you can utilize the Group Policy.

**Using Microsoft Edge:**

1. Download and install the [Microsoft Edge administrative template.](https://learn.microsoft.com/en-us/deployedge/configure-microsoft-edge#1-download-and-install-the-microsoft-edge-administrative-template)
2. Launch the Group Policy Management tool (gpmc.msc).
3. Navigate through: Forest > Domains > Your FQDN (e.g., example.com) > Group Policy Objects.
4. Select desired policy or create a new one then right-click on it and select "Edit".
5. Follow this path: Computer Configuration > Administrative Templates > Microsoft Edge > Extensions.
6. Access "Configure extension management settings", set it to "Enabled".
7.  In the field for Configure extension management settings, enter the following:

    ```
    {"ihejeaahjpbegmaaegiikmlphghlfmeh":{"installation_mode":"force_installed","update_url":"https://edge.microsoft.com/extensionwebstorebase/v1/crx"}}
    ```
8. Save the changes and reboot the server.

**Using Google Chrome:**

1. Obtain and implement the [Google Chrome administrative template](https://chromeenterprise.google/browser/download/#manage-policies-tab)
2. Similar to the steps for Microsoft Edge, navigate through the Group Policy Management tool.
3. Proceed to: Computer Configuration > Administrative Templates > Google Chrome > Extensions.
4. Access "Configure extension management settings", set it to "Enabled".
5.  In the field for Configure extension management settings, enter the following:

    ```
    {"mmiioagbgnbojdbcjoddlefhmcocfpmn":{ "installation_mode":"force_installed","update_url":"https://clients2.google.com/service/update2/crx"}}
    ```
6. Save the changes and reboot the server.

### Installing Manually <a href="#manual-install" id="manual-install"></a>

Extensions can be sourced from the respective browser stores:

* [Microsoft Edge Add-ons](https://microsoftedge.microsoft.com/addons/detail/dcv-webauthn-redirection-/ihejeaahjpbegmaaegiikmlphghlfmeh)
* [Chrome Web Store](https://chrome.google.com/webstore/detail/dcv-webauthn-redirection/mmiioagbgnbojdbcjoddlefhmcocfpmn)

For manual installation:

1. Connect to your NICE DCV session.
2. Open your preferred browser, and navigate to the relevant browser store (links above).
3. Proceed by selecting "Get" (Microsoft Edge) or "Add to Chrome" (Google Chrome).
4. Follow the on-screen instructions. A confirmation will appear once the extension is successfully added.

\


\
