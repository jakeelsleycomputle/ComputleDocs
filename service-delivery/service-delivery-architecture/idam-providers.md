# IDAM Providers

At Computle, we offer flexible Identity and Access Management (IDAM) solutions to meet the needs of various organizations, allowing you to choose the identity provider that best fits your infrastructure. Below, we outline the three main methods you can use to authenticate users on the Computle platform, detailing the benefits and considerations of each option.

## **Entra ID (Azure Active Directory) – Suggested Route**

Entra ID (formerly Azure Active Directory) is our **recommended** method for managing identity on the Computle platform. It provides a cloud-native identity solution that integrates seamlessly with our infrastructure, offering users a streamlined and secure way to access Computle resources.

**Benefits**:

* **Seamless Integration**: Entra ID is fully compatible with the Computle platform, enabling secure Single Sign-On (SSO) across all your devices, including workstations, web applications, and cloud resources.
* **Scalability**: As your organization grows, Entra ID can scale effortlessly without requiring additional on-premises infrastructure.
* **No On-Prem Infrastructure Needed**: Since Entra ID is cloud-based, there's no need for maintaining on-premises servers for authentication or managing local domain controllers.

**How It Works**

Users authenticate against Entra ID and gain access to Computle resources using their existing corporate credentials. This method ensures a consistent experience across devices, whether accessing from on-site or remotely.

***

## **On-Premises Domain Controllers (Active Directory)**

For organizations that prefer or require an on-premises setup, Computle fully supports integrating with **on-premises Domain Controllers (DCs)**. We offer a unique solution where we can host Domain Controllers and associated infrastructure **for free** in our data centers, enabling you to manage Active Directory services as part of your Computle deployment.

**Benefits**:

* **Familiar Environment**: If your organization already uses Windows Active Directory for user management, this option allows you to maintain existing workflows and infrastructure.
* **Site Hosting**: Computle provides free hosting for your domain controllers, ensuring that you have dedicated resources for authentication without the overhead of physical server maintenance.
* **Hybrid Integration**: On-prem AD can work in conjunction with cloud resources, giving you the flexibility to run hybrid environments.

**Considerations**:

* **Client Access Licenses (CALs)**: While Computle offers Windows 11 Professional licenses as part of our platform, **CALs are not included** if you opt for on-premises Domain Controllers. You will need to obtain and manage your own CALs for any services requiring licensing (e.g., Windows Server access).
* **Management Overhead**: Running on-premises AD requires that you maintain your own DCs and ensure they are kept up-to-date and secure.

**How It Works**

Computle can host your Active Directory Domain Controllers on our infrastructure, ensuring high availability and redundancy. Users authenticate against these local DCs and gain access to Computle services using their existing AD credentials.

***

## **Local User Accounts (Not Suggested)**

While Computle supports the use of **local user accounts** for authentication, we do not recommend this option for most organizations due to security and scalability concerns.

**Benefits**:

* **No External Infrastructure**: Local accounts do not require any external identity provider or Active Directory service, allowing you to create user accounts directly on individual machines.
* **Basic Setup**: For small-scale deployments or temporary setups, local accounts can be a quick solution.

**Considerations**:

* **Limited Security**: Local accounts lack the advanced security features provided by Entra ID or on-premises AD, such as centralized policy management, MFA, or Conditional Access.
* **Scalability Issues**: Managing local accounts becomes cumbersome as your user base grows, and there is no centralized user management or directory to streamline operations.

**How It Works**

Each machine on the Computle platform will have local user accounts configured. Users will authenticate using those credentials, but they won't have access to advanced identity management features like those offered by Entra ID or on-prem AD.
