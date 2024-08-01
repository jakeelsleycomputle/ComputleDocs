# Tenant Isolation

Although Computle provides shared services to multiple customers, we prioritize ensuring the highest level of security and data isolation. To achieve this, we implement robust tenant isolation measures that block inter-tenant traffic. Each tenant's data and resources are strictly segregated, creating distinct virtual boundaries that prevent any unauthorized access or interaction between tenants. Each host is dedicated to a single tenant, and each host resides in a tenant namespace, with access to those hosts permitted only to devices within that specific namespace.

