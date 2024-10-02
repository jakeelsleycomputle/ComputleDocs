# Security

## Data Centres

Computle places paramount importance on physical security to ensure the safeguarding of sensitive data within its data centers and critical infrastructure. To achieve this, we have implemented stringent measures to control and monitor access to our facilities. Our data centers are equipped with multi-layered security systems, including biometric authentication, access card systems, and video surveillance.

Only authorized personnel with the appropriate credentials are granted entry to restricted areas, and all access events are closely monitored and logged. Furthermore, our server rooms are designed with reinforced access points, environmental controls, and fire suppression systems to mitigate potential physical threats.&#x20;

## Host Isolation

Each physical host in our infrastructure is dedicated exclusively to running a single Computle machine instance for a customer. This approach guarantees that a customer's workload operates in complete isolation, with exclusive access to the underlying hardware resources. By dedicating each host to one client, we eliminate the risk of data co-mingling and resource contention. This strict isolation enhances data security and privacy, minimizing the potential impact of security incidents on neighboring instances.&#x20;

## Site Isolation

Computle implements stringent network segmentation and access controls to ensure that data and resources within one site remain completely separate from those in other sites. This approach reduces the attack surface and prevents potential lateral movement for cyber attackers.

## Tenant Isolation&#x20;

Although Computle provides shared services to multiple customers, we prioritize ensuring the highest level of security and data isolation. To achieve this, we implement robust tenant isolation measures that block inter-tenant traffic. Each tenant's data and resources are strictly segregated, creating distinct virtual boundaries that prevent any unauthorized access or interaction between tenants. Each host is dedicated to a single tenant, and each host resides in a tenant namespace, with access to those hosts permitted only to devices within that specific namespace.

## Zero Trust

Computle operates on the principle of "never trust, always verify," ensuring that no user or device is granted unrestricted access by default. Our ZTA implementation involves rigorous identity verification through multi-factor authentication (MFA) and robust identity and access management (IAM) systems. We enforce the principle of least privilege access, limiting access rights to the minimum required for each user or device. Network micro-segmentation is employed to create isolated segments, reducing the lateral movement potential of threats. Continuous monitoring and policy-based access control help us detect and respond to anomalies in real-time.

## Hardware Keys

Computle leverages phishing-resistant FIDO2 keys with WebAuthn as a crucial component of our Multi-Factor Authentication (MFA) strategy. By incorporating these hardware-based security keys into our authentication process, we provide an additional layer of security beyond passwords. When users access our systems or services, they are required to use their FIDO2 key, combined with a password and a trusted device. This hardware-based MFA adds a robust security layer, effectively reducing the risk of phishing attacks.

## Security Information and Event Management (SIEM)

Computle's SIEM solution aggregates data from various sources, including network devices, servers, applications, and security tools, to provide a holistic view of our estate. By continuously monitoring this data, we can quickly detect and respond to security events and incidents, such as suspicious network traffic, unauthorized access attempts, or malware outbreaks and provide automatic remediation such as device quarantine.

## Security Auditing and Logging

Security auditing and logging are essential components of Computle's security approach, enabling us to detect and respond to security incidents, maintain compliance, and continuously enhance our security posture. These practices are crucial in our commitment to protecting our clients' data and assets from emerging cybersecurity threats.













