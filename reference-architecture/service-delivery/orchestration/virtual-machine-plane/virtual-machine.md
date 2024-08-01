# Virtual Machine

### **Baremetal Hardware**

Computle Machine operates directly on baremetal hardware, ensuring dedicated resources for each virtual machine. Each host is assigned to one customer and isolated within a tenant's namespace.&#x20;

### **Hypervisor**

A Type 1 virtualization platform is installed directly on the baremetal hardware. This platform hosts the customer's virtual machines.

#### **Resource Allocation Advisory**

Customers should note that due to the virtualisation setup of Computle, parts of the hypervisor are reserved for operational purposes. Specifically:

* **Memory Consumption:** The hypervisor consumes 4GB of the host memory. Consequently, a machine with 64GB of total RAM will have 60GB available for customer use.
* **CPU Usage:** Approximately 1% of the CPU resources are utilized by the hypervisor to manage the virtual machine.
* **Graphics:** Graphics performance remains unaffected by the hypervisor, as GPUs are passed directly to the virtual machine.&#x20;
