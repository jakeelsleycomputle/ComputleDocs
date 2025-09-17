# Twinmotion GPU Crash Detected / Twinmotion crashes when performing renders.

{% hint style="info" %}
Created from [EpicGames](https://dev.epicgames.com/documentation/en-us/unreal-engine/how-to-fix-a-gpu-driver-crash-when-using-unreal-engine?application_version=5.0) documentation.&#x20;
{% endhint %}

### Symptom: Twinmotion crashes when performing renders and/or displays "GPU Crash Detected" in the crash log.

***

1.  Type '**run'** into the Windows operating system search bar. Open the **Run** application.



    ![](<../../.gitbook/assets/image (2).png>)
2.  In the search field, type '**regedit**'. Click **OK** to open the Registry Edit Tool.



    <figure><img src="../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>
3. Navigate to:&#x20;
4.  `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers`.



    ![](<../../.gitbook/assets/image (3).png>)


5.  The registry key you need is called `TdrDelay`. If this registry key already exists, double-click to edit it. If it does not already exist, right-click in the pane on the right and select **New > DWORD (32-bit) Value**.

    ![Create a new DWORD registry key](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/4744e353-a524-4113-bf21-45ab186d3f90/new-dword.png)
6.  Set the **Base** to **Decimal.** Set the **Value** of TdrDelay to **60**. Click **OK** to finish.

    ![TdrDelay settings](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/d3218114-68f1-48df-b932-182cfe5b9d51/tdr-delay.png)
7. Right-click in the right hand pane and select **New > DWORD (32-bit) Value** and create a 2nd key.
8.  Set the **Base** to **Decimal.** Set the **Value** of `TdrDdiDelay` to **60**. Click **OK** to finish.

    ![TdrDdiDelay settings](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/8f89c0ba-d05c-47c4-a671-aa48171ba823/tdr-ddi-delay.png)
9.  Your registry should now include both `TdrDelay` and `TdrDdiDelay`.



    <figure><img src="../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>
10. Close the Registry Editor.
11. Restart your Computle workstation.&#x20;
