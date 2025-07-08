# Entra ID Sync with On-Premise Active Directory: Validating Seamless File Share Access

**Question**: Can you achieve seamless access to on-premise file shares when using Entra ID Sync and Computle/a third party?

**Answer**: Yes.&#x20;

***

### **Architecture**

* On premise Active Directory with Entra ID integration.
* On premise file share.

### **Log in flow**

<figure><img src="../.gitbook/assets/Screenshot 2025-07-08 at 13.36.12.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/Screenshot 2025-07-08 at 13.42.23.png" alt=""><figcaption></figcaption></figure>

### **File operations**

No password is requested as Entra ID Sync validates the user's identity.&#x20;

<figure><img src="../.gitbook/assets/Screenshot 2025-07-08 at 13.40.17.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/Screenshot 2025-07-08 at 13.40.34.png" alt=""><figcaption></figcaption></figure>

### Permission validation

<figure><img src="../.gitbook/assets/Screenshot 2025-07-08 at 13.41.43.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/Screenshot 2025-07-08 at 13.42.05.png" alt=""><figcaption></figcaption></figure>

### Backend set up

<figure><img src="../.gitbook/assets/Screenshot 2025-07-08 at 12.49.04.png" alt=""><figcaption></figcaption></figure>
