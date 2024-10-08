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
