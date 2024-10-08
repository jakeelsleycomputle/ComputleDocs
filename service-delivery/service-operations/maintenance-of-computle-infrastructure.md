# Maintenance of Computle Infrastructure

At Computle, we regularly patch the underlying hypervisors to ensure performance, security, and reliability. Patching takes place during our **global maintenance window** on **Saturdays**, with **Sunday reserved for rollback** if needed. The process involves placing virtual machines into a **paused or hibernated state**, allowing updates to be applied seamlessly without interrupting workloads.

Patches are applied across **fault domains** and are thoroughly tested to minimize risk. Any sign of failure immediately halts operations. Each site is patched **independently**, and while rare, **Windows instances may reboot** during the maintenance window.

#### **Pausing and Hibernation with Reboot Considerations**

When virtual machines are placed into **paused or hibernated states**, all active processes and sessions are preserved, allowing us to update the underlying hypervisor infrastructure without disrupting workloads. This ensures that the machine resumes smoothly after the update. However, there is a rare chance that **Windows instances may require a reboot** during this process. While this occurrence is infrequent, it is essential for customers to prepare for the possibility of a reboot during the maintenance window.

#### **Underlying Hypervisor Patching**

The patching process focuses on both the **virtualization technology** and the **host operating system**. Updates target core elements of the hypervisor, including networking, storage, and resource management, ensuring optimal performance and the latest security enhancements. Each update is carefully tested within isolated fault domains to verify that stability and functionality are maintained throughout the process.

#### **Fault Domain Isolation and Testing**

To limit the impact of patching, we isolate the updates within **fault domains**. This strategy ensures that patches are applied to small sections of the environment at a time, allowing any issues to be identified before a wider rollout. Each fault domain is **rigorously tested** after patching to ensure there are no performance issues. Should any failure occur during testing, the **entire process is halted** until the issue is resolved.

#### **Site-by-Site Execution**

Patching is executed on a **site-by-site** basis, ensuring that only one location undergoes patching at a time. This approach reduces the risk of disruption across your global operations, as unaffected sites continue running smoothly while maintenance is performed. Each site is updated individually, ensuring that the patching process is localized and isolated.

#### **Global Maintenance Window and Rollback**

Patching takes place during our **global maintenance window**, scheduled for **Saturdays**. If any issues are encountered during the patching process, **Sunday** is reserved for rolling back updates and restoring the environment to its previous state. This two-day window provides ample time to test and correct any potential issues while minimizing the impact on customer workloads.

#### **DevOps-Driven Automation**

All hypervisor patching is automated through our **DevOps pipeline**, ensuring consistent, efficient deployment of updates. The automation pipeline includes pre-patch validation, post-patch testing, and continuous monitoring for any failures. Should an issue arise, the system automatically pauses the patching process and, if necessary, triggers a rollback to ensure system stability.

Through this carefully controlled maintenance process, Computle ensures that your virtual environments remain secure, stable, and up-to-date with the latest performance and security improvements, while minimizing downtime and operational impact.
