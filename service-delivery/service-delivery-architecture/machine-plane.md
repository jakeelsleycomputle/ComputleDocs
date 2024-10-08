---
cover: ../../.gitbook/assets/iStock-1094979582.jpg
coverY: 183
---

# Machine Plane

## Dedicated, baremetal hardware

Computle adopts a **Scale-Out Architecture**, where each customer is assigned dedicated resources, ensuring that workloads scale efficiently without compromising performance. To further enhance reliability, Computle follows a **Shared Nothing Architecture**, where each tenant operates independently on dedicated hardware, eliminating the risk of component failures impacting other users.

<div align="left">

<figure><img src="../../.gitbook/assets/image (5).png" alt="" width="551"><figcaption><p>Computle blade workstation v1</p></figcaption></figure>

</div>

This is supported by **baremetal hardware** with a **Type 1 hypervisor**, with each hypervisor hosting one virtual machine. Each seat or user has full access to dedicated resources, including CPU, GPU, memory, and NVMe storage, ensuring maximum performance and efficiency. With **both physical and logical tenant isolation**, each hypervisor and its associated resources are dedicated exclusively to a specific tenant, guaranteeing secure and high-performance operations for every customer.&#x20;

### Features

* **Graphics Card (GPU):** Each user gets exclusive access to a dedicated GPU, allowing for seamless performance in graphics-intensive applications like CAD, 3D rendering, and video editing.&#x20;
* **CPU:** Every virtual machine has its own dedicated CPU, ensuring consistent performance for compute-heavy tasks. Users won’t experience slowdowns, making this ideal for AEC applications.
* **Memory:** Dedicated memory ensures each VM operates independently with zero contention for resources.&#x20;
* **NVMe storage:** Users benefit from ultra-fast, dedicated NVMe storage, allowing for rapid access to large files, faster load times, and improved performance for storage-intensive applications.&#x20;

**Reservations**&#x20;

Customers should note that due to the virtualisation setup of Computle, parts of the hypervisor are reserved for operational purposes. Specifically:

* **Memory Consumption:** The hypervisor consumes 2-4GB of the host memory. Consequently, a machine with 64GB of total RAM will have around 62GB available for customer use.
* **CPU Usage:** Approximately 0.1% of the CPU is utilised by the hypervisor to manage the virtual machine.
* **Graphics:** Graphics performance remains unaffected by the hypervisor, as GPUs are passed directly to the virtual machine.&#x20;

**NICE DCV**

NICE DCV is a high-performance remote display protocol developed to provide users with an efficient and seamless experience when accessing virtual desktops and applications. At Computle, we leverage NICE DCV  to enhance our Computle Machines, ensuring that our clients benefit from low-latency, high-resolution streaming capabilities. This technology is crucial for supporting graphically intensive applications and workflows, offering a near-native experience regardless of the user's location.&#x20;

***

## Image management&#x20;

Computle leverages **QCOW2 imaging** to provide IT administrators with powerful, flexible, and efficient tools for deploying and managing virtual environments. The platform is designed to streamline the provisioning of high-performance workstations, allowing admins to rapidly deploy, clone, and reimage machines as needed, all through our intuitive GUI interface. This enables organizations to scale and manage workstations without complex setup processes, ensuring rapid deployment and maximum performance for every user.

* **Image capture:** Administrators can clone existing Computle Machines to rapidly scale the deployment of identical workstations. This capability is particularly useful when deploying workstations for teams that require the same configuration for tasks like software development, CAD design, or video rendering. Cloning ensures consistency across environments, reducing errors and configuration drift while maintaining performance standards.
* **Image hosting:** Image hosting is provided free of charge. Where required, we can also host Windows Deployment Services.&#x20;
* **Rapid deployment:** With Computle, admins can quickly deploy new virtual workstations using pre-configured QCOW2 images. This eliminates the need for manual setup, as each VM can be provisioned with a few clicks, ensuring new users or projects are up and running in minutes. &#x20;

***

## Default build

Computle provides a default build for all customers which can be deployed at any point. This image can be modified using your own applications.

#### Applications

| Windows 11 Professional 24H2 |
| ---------------------------- |
| NICE DCV Streaming Agent     |
| Computle Agent               |
| QEMU Guest Agent             |
| NVIDIA Professional Drivers  |

#### Policy Options

| Administrator account is active.                                                                 |
| ------------------------------------------------------------------------------------------------ |
| Remote Desktop is enabled.                                                                       |
| Access is permitted for any authorized user to connect, with a session limit of one active user. |
| Windows will download updates once the machine is built.                                         |

### Qemu-guest-agent

The QEMU Guest Agent is a daemon that runs inside Computle Machine and allows the hypervisor to execute commands and perform operations within the machine.&#x20;

{% hint style="info" %}
We advise that you do not remove the QEMU Guest Agent. Doing so will cause a loss of reporting capabilities, the inability to perform graceful power actions, and limited administrator-level recovery options.
{% endhint %}

#### **Data collection**

The QEMU Guest Agent collects a variety of data from Computle machine to assist in management and monitoring. This includes:

1. **System Information:** Hostname and O/S details.
2. **Memory Usage:** Total, free, and used memory.
3. **CPU Information:** Number of CPUs and their usage.
4. **Disk Information:** Disk partitions and file system usage.
5. **GPU Information:** GPU activity data (not currently visible).
6. **Network Information:** Network interfaces and traffic statistics.
7. **Running Processes:** List of active processes with resource usage.
8. **Filesystem Status:** Health and consistency of file systems.
9. **Resource Configuration:** Details on resource allocation and virtual devices.

All data collected is kept within the tenant's namespace and is only visible to trusted users and administrators.

## &#x20;

