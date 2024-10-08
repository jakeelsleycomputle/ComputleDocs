# Storage Providers

Computle offers a flexible array of storage providers to meet the needs of organizations with varying infrastructure requirements. Whether you're looking for a fully managed file share service or need to deploy third-party storage solutions, Computle provides a robust and scalable platform. Below is an overview of the storage options available, including our in-house solution and various third-party integrations.

***

## **Computle Files (Managed File Share)**

**Computle Files** is our fully managed, high-availability file share system designed to provide organizations with a reliable and scalable storage solution. Computle Files is hosted across at least three different storage clusters within the same site, ensuring data availability even in the event of hardware failure. This system is ideal for businesses that need centralised file storage with the added assurance of redundancy and fault tolerance.

{% hint style="info" %}
This service is best suited towards clients with a single location.
{% endhint %}

**Key Features**:

* **High Availability**: Files are replicated across at least three distinct storage clusters, providing seamless access even in the event of a failure.
* **Performance**: Optimized for speed and efficiency, offering low-latency access to files from any connected device.
* **Scalability**: As your storage needs grow, Computle Files can scale effortlessly, allowing you to add capacity without disruption.

**Use Case**

Organizations that require a fully managed, reliable, and high-performing file system with minimal management overhead will benefit from using Computle Files.

***

## **Third-Party Storage Solutions**

In addition to Computle Files, we support the integration of various third-party storage solutions, allowing you to use your preferred storage provider or system while benefiting from Computle’s robust network and compute infrastructure.

### **1. Panzura**

**Panzura** offers a cloud-based distributed file system, ideal for organizations that need to centralize their unstructured data and make it accessible from multiple locations. Computle can host and deploy Panzura’s virtual storage solutions, offering a seamless integration with our platform.

{% hint style="info" %}
This service is best suited towards clients with multiple locations.
{% endhint %}

**Key Features**:

* **Global File System**: Panzura’s Global File System provides a single, unified namespace, allowing users across multiple locations to access the same data with real-time consistency.
* **Data Centralization**: Panzura’s file locking and synchronization mechanisms ensure that data is always available, no matter where it is accessed.

**Prerequisites**:

* **Local Domain Controller Required**: You will need to have a local domain controller hosted within Computle to support DFS functionalities.&#x20;

### **2. LucidLink**

**LucidLink** offers a cloud-native file system designed for remote access to large files, such as media files or CAD projects. LucidLink operates using object storage backends and provides efficient data streaming for teams that need to collaborate remotely.

{% hint style="info" %}
This service is best suited towards clients with multiple locations.
{% endhint %}

**Key Features**:

* **File Streaming**: Instead of downloading entire files, LucidLink streams file data as needed, optimizing performance and reducing local storage requirements.
* **Collaborative**: Multiple users can access, share, and work on large files from anywhere in the world without transferring large datasets between locations.

### **3. Microsoft OneDrive**

{% hint style="info" %}
This service is not recommended for shared data, such as drawing files.
{% endhint %}

**OneDrive** is Microsoft’s cloud-based storage solution, which integrates seamlessly with the Microsoft ecosystem and can be used as a storage option within the Computle environment.

**Key Features**:

* **File Syncing**: OneDrive allows users to sync files across multiple devices, providing a consistent experience across platforms.
* **Office 365 Integration**: Fully integrates with the Microsoft 365 suite, making it easy to share and collaborate on documents using Office apps.

***

## Pricing

With Computle, you only pay for the deployed storage. There are no extra charges associated with the running of storage appliances such as Panzura.

| Storage tier    | All-location pricing  |
| --------------- | --------------------- |
| Archive (HDDs)  | £10 per TB/per month  |
| Standard (NVMe) | £100 per TB/per month |

