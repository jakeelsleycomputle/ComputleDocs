# Telemetry and Monitoring at Computle

At Computle, we maintain continuous **24/7 telemetry** across our entire infrastructure and Computle Machines, ensuring that every aspect of performance, security, and uptime is closely monitored. Our system tracks anomalies, machine issues, outages, and performance trends to keep operations running smoothly.

## **Real-Time Monitoring**

**System Information Monitored:**

* **Memory Usage**: Total, free, and used memory, helping identify potential memory bottlenecks.
* **CPU**: CPUs and their usage to monitor performance under load.
* **Disk**: Disk partitions, usage statistics, and file system health to detect potential storage issues.
* **GPU Information**: Active monitoring of GPU utilisation, thermal performance, power draw, and memory usage.&#x20;
* **Network**: Interface details, traffic statistics, and potential anomalies like high latency or packet loss.
* **Processes**: Monitoring of running processes, resource consumption, and identification of rogue or resource-hungry tasks.
* **Disk Status**: Continuous health checks for filesystem integrity and consistency.
* **Resource Configuration**: Information on allocated resources such as virtual devices and overall resource distribution.

This allows us to quickly identify and resolve potential issues before they affect performance.

***

## **Anomaly Detection**

Our telemetry system uses advanced algorithms to detect anomalies across the estate, such as:

* **Unusual spikes in resource usage** (CPU, memory, disk).
* **Sudden drops in network throughput**.
* **Hardware failures**, such as disk read/write errors or network interface degradation.

When an anomaly is detected, alerts are immediately generated for our engineering team to assess and resolve the issue. We monitor overall **machine health** by looking at historical data trends, identifying patterns of performance degradation, and ensuring proactive maintenance. &#x20;

***

## **Global Endpoint Monitoring**

We monitor the **global network infrastructure**, including switches, routers, and other critical endpoints, ensuring high availability across regions. This includes tracking uptime, bandwidth usage, and hardware status at each site. If any hardware, such as switches or network interfaces, shows signs of failure, immediate action is taken to prevent service disruptions.

***

## **Outage Detection and Response**

We continuously monitor for machine outages or downtime. If a machine goes offline or experiences reduced availability, our system detects this automatically and begins the remediation process. Failover mechanisms are also in place to ensure high availability across all virtual machines.

Automated responses and notifications are sent to the relevant engineers and customers in case of significant performance or hardware issues. Through this proactive approach, we ensure that the Computle environment runs smoothly 24/7, delivering optimal performance for customers.



