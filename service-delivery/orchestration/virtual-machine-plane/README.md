# Virtual Machine Plane

## Baremetal Hardware

Computle Machine operates directly on baremetal hardware, ensuring dedicated resources for each virtual machine. Each host is assigned to one customer and isolated within a tenant's namespace.&#x20;

#### **Resource Allocation Advisory**

Customers should note that due to the virtualisation setup of Computle, parts of the hypervisor are reserved for operational purposes. Specifically:

* **Memory Consumption:** The hypervisor consumes 4GB of the host memory. Consequently, a machine with 64GB of total RAM will have 60GB available for customer use.
* **CPU Usage:** Approximately 1% of the CPU resources are utilized by the hypervisor to manage the virtual machine.
* **Graphics:** Graphics performance remains unaffected by the hypervisor, as GPUs are passed directly to the virtual machine.&#x20;

***

## NICE DCV

NICE DCV is a high-performance remote display protocol developed to provide users with an efficient and seamless experience when accessing virtual desktops and applications. At Computle, we leverage NICE DCV  to enhance our Computle Machines, ensuring that our clients benefit from low-latency, high-resolution streaming capabilities. This technology is crucial for supporting graphically intensive applications and workflows, offering a near-native experience regardless of the user's location.&#x20;

### End-to-End Security

NICE DCV employs robust security mechanisms to ensure the security of data in transit between the DCV server and the client.&#x20;

* **TLS**: NICE DCV uses TLS to encrypt all data transmitted between the server and the client. TLS is a widely adopted security protocol designed to provide privacy and data integrity. It prevents eavesdropping, tampering, and message forgery, ensuring that any data exchanged remains confidential and unaltered.
* **SSL Certificates**: The DCV server requires an SSL certificate to establish secure TLS connections. Computle cerrtificates are issued by a trusted Certificate Authority (CA) for public access. The SSL certificate ensures that the server's identity is authenticated and that the communication channel is secure.
* **End-to-End Encryption**: DCV ensures that all communication, including video, audio, keyboard, and mouse data, is encrypted from the moment it leaves the client until it reaches the Computle Machine. This end-to-end encryption guarantees that no intermediary can access or modify the data.
* **Session Authentication**: Before any data is transmitted, DCV sessions are authenticated using secure methods such as local authentication, EntraID, or Active Directory. This authentication process verifies the identities of the client and server, establishing a trusted connection before any sensitive information is exchanged.

### Ports

**Port 8443 (TCP)** is the default port for secure DCV sessions. It handles encrypted traffic for secure communications between the DCV server and the client. Optionally, you can also use UDP for QUIC mode, on the same port.&#x20;



***

## Default Windows Build

Below you can find a breakdown of all image-specific configurations supplied in Computle's default images.

### O/S

* Windows 11 Professional 23H2.

### Applications

* NICE DCV Streaming Agent.
* QEMU Guest Agent.
* NVIDIA Professional Drivers.

### **Policy Options**

* Administrator account is active.&#x20;
* Remote Desktop is enabled.
* Access is permitted for any authorised user to connect, with a session limit of one active user.&#x20;

### **Depreciated: Windows Updates**

To streamline delivery, we will be removing the stage where Windows Updates are applied during the image capture. Instead, Windows will download updates once the machine is built.&#x20;

