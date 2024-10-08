# Computle Gateway

{% hint style="info" %}
If you are an administrator looking to onboard a user into Computle Gateway for SMEs, head [here](../../onboarding/administrator-guide/computle-gateway-for-smes.md).
{% endhint %}

**Computle Gateway** is our free network access solution, offering secure, low-latency, and high-performance encrypted connections for both SMEs and Enterprises. Built for **High Availability (HA)**, Computle Gateway ensures that users can always access their resources reliably.

**Low Latency and Always-On Connection**

With WireGuard’s lightweight and efficient architecture, Computle Gateway provides **low-latency, always-on** connectivity. The VPN is designed to minimize overhead, ensuring fast and uninterrupted access to remote resources while keeping security at the forefront.

**End-to-End Encryption**

Computle Gateway uses **end-to-end encryption**, securing all data from the client’s device through the VPN tunnel to their virtual machines (VMs) within the Computle infrastructure. Whether it's SME users connecting through the free service or enterprise customers leveraging SSO and MFA, all communication is encrypted to maintain data confidentiality.

***

## **Versions of Computle Gateway**

**Computle Gateway for SMEs**:

* **Free** version with self-service VPN management.
* Provides secure access to company resources without requiring additional infrastructure.

**Computle Gateway for Enterprise**:

* **£5 per user/month** with added **Single Sign-On (SSO)** and **Multi-Factor Authentication (MFA)**.
* Enterprise-grade security features for larger businesses needing tighter access control and enhanced management capabilities.

Both versions include a **self-service panel** where users can manage VPN connections, troubleshoot access issues, and add or remove devices as needed.

***

## **Network Isolation**

Each tenant within Computle is provided with two virtual network environments (VLANs), ensuring complete data isolation and secure access:

* **Gateway VLAN (DMZ)**: When users connect via Computle Gateway, they are placed in this VLAN, which only provides access to the **DMZ** layer. This allows users to reach their **virtual machines’ login screens**, but they cannot directly access internal resources.
* **Namespace VLAN**: Each virtual machine (VM) is equipped with a separate NIC dedicated to this **namespace-specific VLAN**. This is where the user’s data and applications reside. Once logged in, users can interact with all resources assigned to their VM, but all access is strictly isolated within their namespace.

***

## **Computle Gateway for Enterprise**

The **Enterprise version** of Computle Gateway offers advanced security through **OpenID Connect (OIDC)**, enabling seamless **Single Sign-On (SSO)** and **Multi-Factor Authentication (MFA)**. This integration supports both **Entra ID (formerly Azure AD)** and **on-premises Active Directory**, allowing businesses to leverage their existing identity management systems for secure access.

### Integration: **Azure AD (Entra ID)**

1. **Register the Application in Azure AD:**
   * Go to the **Azure Active Directory** portal.
   * Select **App Registrations** and click **New Registration**.
   * Set the **Name** and **Redirect URI** (use your Computle Gateway callback URL, e.g., `https://gateway.computle.com/callback`).
   * Click **Register**.
2. **Configure API Permissions:**
   * Open the newly registered app.
   * Under **API Permissions**, click **Add a permission**.
   * Select **Microsoft Graph**, then add permissions for **openid**, **profile**, and **email**.
3. **Create a Client Secret:**
   * Under **Certificates & Secrets**, click **New Client Secret**.
   * Set an expiration and copy the secret value (you’ll need this for Computle Gateway configuration).
4. **Set Redirect URIs:**
   * Go to **Authentication** and ensure the redirect URI is set (e.g., `https://gateway.computle.com/callback`).
   * Set **Implicit Grant** to include **ID tokens**.
5. **Get the Client ID and Tenant ID:**
   * Go to **Overview** of the registered application.
   * Copy the **Application (Client) ID** and **Directory (Tenant) ID**.
6. **Configure OIDC in Computle Gateway:**
   * In Computle Gateway’s configuration, add the following:
     * **Client ID**: The Azure AD Application ID.
     * **Client Secret**: The client secret created in step 3.
     * **Issuer URL**: `https://login.microsoftonline.com/{Tenant-ID}/v2.0`.
     * **Redirect URI**: `https://gateway.computle.com/callback`.
7. **Test the Integration:**
   * Access Computle Gateway and authenticate using your Azure AD credentials.

***

### **Integration: On-Premises AD via ADFS**

1. **Install and Configure ADFS:**
   * Install and configure ADFS on your on-premises server.
   * Ensure ADFS is integrated with your Active Directory.
2. **Create a Relying Party Trust in ADFS:**
   * Open ADFS Management.
   * Navigate to **Relying Party Trusts**, click **Add Relying Party Trust**.
   * Choose the option to manually configure the relying party.
   * Enter the **Computle Gateway Callback URL** (e.g., `https://gateway.computle.com/callback`).
   * Complete the wizard.
3. **Configure OpenID Connect (OIDC) in ADFS:**
   * Navigate to **Access Control Policies** in ADFS.
   * Configure the policy to allow OIDC and set the scopes for **openid**, **profile**, and **email**.
4. **Get the Client ID and Secret:**
   * From ADFS, generate a **Client ID** and **Client Secret** for the application.
5. **Configure OIDC in Computle Gateway:**
   * In Computle Gateway’s configuration, add:
     * **Client ID**: The ADFS-generated Client ID.
     * **Client Secret**: The ADFS-generated secret.
     * **Issuer URL**: ADFS URL (e.g., `https://your-adfs-server/adfs/.well-known/openid-configuration`).
     * **Redirect URI**: `https://gateway.computle.com/callback`.
6. **Test the Integration:**
   * Access Computle Gateway and authenticate using your on-premises AD credentials.

