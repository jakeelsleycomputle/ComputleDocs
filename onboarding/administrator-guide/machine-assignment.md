# Machine Assignment

The **Computle Broker Agent** helps you manage machine assignments by dynamically updating based on the device's hostname and assigned user. &#x20;

## **To modify an assignment:**

1.  **Open the Modify Assignments Window:**

    * Right-click on the **Computle Broker Agent** icon in the system tray.

    <div align="left">

    <figure><img src="../../.gitbook/assets/image (38).png" alt=""><figcaption></figcaption></figure>

    </div>

    * From the menu, select **Modify Assignments**.
2.  **Update Assigned User:**

    * In the window, you will see a table with the columns for **Machine Name**, **Assigned User**, and **IP/DNS**.
    * To change the user, click the **Assigned User** field next to the machine you wish to update.
    * Enter the new user in the following format: `domain\username`



    <div align="left">

    <figure><img src="https://blog.computle.com/content/images/2024/09/image-1.png" alt=""><figcaption></figcaption></figure>

    </div>
3. **Save Changes:**
   * After editing the user assignment, click the **Save** button on the right side of the window.
   * The new user assignment will now be synced.
4. **Sync Interval:**
   * The updated assignment is automatically synced every **5 minutes** to ensure that all machines and users are up to date. This means that after making a change, the new user assignment will take effect on the machine after the next sync cycle.

***

## **Restoring Previous Versions**

If you need to revert to an older assignment configuration, you can restore a previous version using the **Browse Versions** feature.

1. **Open the Modify Assignments Window:**
   * Right-click the **Computle Broker Agent** icon in the tray.
   * Select **Modify Assignments** from the menu.
2. **Browse Versions:**
   * In the **Modify Assignments** window, click the **Browse Versions** button on the right.
   * A new window will appear, listing historical versions of the assignment configurations by date.
3. **Select and Restore:**
   * Scroll through the list and choose the version you want to restore.
   * Select the desired date and confirm the restoration.
   * The machine assignments will now be reverted to how they were on that specific date.
4. **Save and Sync:**
   * After restoring a previous version, the updated assignment list will be automatically synced to the system within **5 minutes**.

***

## **Viewing Latest Log Files**

This feature allows administrators to access log files, which can be helpful for tracking changes or troubleshooting issues.

1. **Right-Click the Tray Icon:**
   * Right-click the **Computle Broker Agent** icon in the system tray.
2. **Select “View Latest Log File”:**
   * From the menu, click **View Latest Log File**.
   * This will open the most recent log file in your default text editor, displaying any recent activity, changes, or errors related to machine assignments.

***

## **Refreshing the Interface**

If you make changes or want to check for updates immediately, you can manually refresh the assignment interface.

1. **Right-Click the Tray Icon:**
   * Right-click the **Computle Broker Agent** icon.
2. **Select “Refresh”:**
   * Click **Refresh** from the menu.
   * This will reload the current machine assignments and ensure the latest data is displayed.
