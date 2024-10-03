# GPU Analyser

<figure><img src="../../.gitbook/assets/image (34).png" alt=""><figcaption></figcaption></figure>

### Computle GPU Analyser is a powerful free tool designed to help organisations monitor and analyse GPU usage across their workstations. By providing detailed insights into how different users or personas utilize GPU resources, it enables team leads and IT administrators to make informed decisions when planning a migration to Computle.

## Features

* **Real-Time GPU Monitoring**: Track GPU utilisation in real-time.
* **Historical Data Access**: View historical GPU performance data to spot trends over time.
* **System Information Collection**: Gather detailed system specs, including CPU, RAM, GPU type, and operating system.
* **Web-Based Dashboard**: Visualise GPU performance metrics through our intuitive web interface.
* **Customizable Time Ranges**: Analyse data over various time periods (e.g., past 24 hours, 7 days, 30 days).

***

## Windows agent

The GPU Analyser installs a lightweight agent on each workstation. This agent runs silently in the background, collecting GPU performance metrics at regular intervals without disrupting user activities.

The data collected includes:

#### GPU Performance Metrics

* **Timestamp**: Date and time of data capture.
* **GPU Utilization (%)**: Current usage level of the GPU.
* **Memory Used (MB)**: Amount of GPU memory in use.
* **Power Draw (W)**: Current power consumption of the GPU.

#### System Information

* **CPU**: Processor model and specifications.
* **RAM**: Total installed system memory.
* **GPU Type**: Make and model of the GPU.
* **GPU vRAM**: Total video memory available on the GPU.
* **Operating System**: Version and build of the operating system.

***

## Installation&#x20;

#### Prerequisites

* **Administrator Access**: Required for installation on each workstation.
* **Internet Connection**: Necessary for data uploads to Computle's servers.

#### Installation Steps

1. **Download the Installer**:

{% hint style="info" %}
**Installer:** [Computle\_GPU\_Analyser\_x64\_2024.09.01.4.exe](https://gpuanalyser.computle.net/installer/Computle\_GPU\_Analyser\_x64\_2024.09.01.4.exe)

**sha256sum** e6d5269291bf48ccbcde31b8a56c13fd5cab547d9ee161c60776a9b046ad1f7a
{% endhint %}

2. **Run the Installer**:

* Double-click the installer file.
* Follow the on-screen prompts.

<figure><img src="../../.gitbook/assets/image (3).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (5).png" alt=""><figcaption></figcaption></figure>

3. **Completion**

The agent will start running in the background upon successful installation. After closing the window, you can view the live results in the web dashboard.&#x20;

<figure><img src="../../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>

***

## Using the web dashboard

Access the web dashboard and enter your serial:

{% hint style="info" %}
[Web dashboard](https://gpuanalyser.computle.net)
{% endhint %}

<figure><img src="../../.gitbook/assets/image (32).png" alt=""><figcaption><p>Computle GPU Analyser</p></figcaption></figure>

***

## Using the dashboard

1. **Machine Selection**:
   * Use the **"Select Machine"** dropdown to choose a workstation or user persona.
   * Machines are identified by their hostnames or assigned labels.
2. **Time Range Selection**:
   * Choose from predefined time ranges (e.g., past 24 hours, 7 days, 30 days) or set a custom range.
3. **Viewing Charts**:
   * **GPU Utilization Chart**: Visual representation of GPU usage over time.
   * **Memory Usage Chart**: Displays GPU memory consumption patterns.
   * **Power Draw Chart**: Shows the GPU's power consumption trends.
4. **System Information**:
   * Access detailed hardware and system specs for the selected machine.

<figure><img src="../../.gitbook/assets/image (33).png" alt=""><figcaption></figcaption></figure>

***

## Troubleshooting&#x20;

* **No Data Displayed**:
  * Ensure the agent is running on the workstation. You can verify this by going to Services and then looking for _Computle GPU Analyser_. Ensure that the status shows as Running.&#x20;
  * Verify that the machine has an active internet connection.
  * Check firewall settings to allow outbound connections to Computle's servers. `gpuanalyser.computle.net`
* **Agent Not Starting**:
  * Confirm that the installation was completed with administrator privileges.
  * Reinstall the agent if necessary.
* **Incorrect System Information**:
  * The agent collects system info daily; discrepancies may resolve after 24 hours.
  * Ensure the workstation's date and time settings are correct.
* Log file
  * Logs are stored in `C:\ProgramData\GPUAnalyser\logs`.

***

## FAQs

* **Is the GPU Analyser resource-intensive?** No, the agent is designed to be lightweight and operates with minimal impact on system performance.&#x20;
* **How often is data collected?** Data is collected every second and then aggregated into hourly averages.&#x20;
* **Do I need to remain logged in?** No, the application runs as a service.&#x20;

