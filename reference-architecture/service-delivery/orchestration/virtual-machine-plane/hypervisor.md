# Hypervisor

Computle machines run on baremetal hardware with dedicated resources for each virtual machine. Atop the baremetal hardware sits a type one virtualisation platform on which a customer’s virtual machine is hosted. Customers should be advised that the virtualised nature of this setup results in 4GB of host memory being consumed by the hypervisor. Therefore, a 64GB machine will present as containing 60GB of RAM. In addition, around 1% of the CPU is consumed by the hypervisor. Graphics performance is unaffected.
