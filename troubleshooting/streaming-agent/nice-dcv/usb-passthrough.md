# USB Passthrough

1. Connect the USB device in any open USB slot on your computer.
2. Go to your DCV client session.
3.  Choose the Settings icon located in the upper left of the window.

    ![](https://docs.aws.amazon.com/images/dcv/latest/userguide/images/dcv-settings-icon.jpg)
4.  Select Removable Devices... from the dropdown menu.

    ![](https://docs.aws.amazon.com/images/dcv/latest/userguide/images/dcv-settings-dropdown.jpg)
5.  Move the slider next to the USB device in the list.

    ![](https://docs.aws.amazon.com/images/dcv/latest/userguide/images/dcv-settings-removable-devices.png)

Your USB device is ready to use now.

***

## Specialised Devices

Computle uses an allow list to determine which USB devices clients are allowed to use. By default, some commonly used USB devices are added to the allow list. This means clients can connect these USB devices to their computer and use them on the server without any additional configuration.&#x20;

However, some specialized devices might not be added to the allow list by default. These devices must be manually added to the allow list on the NICE DCV server before they can be used by the client. After they have been added, they appear in the Windows client Settings menu.

### **To add a USB device to the allow list**

1. Install the USB device's hardware drivers on the Computle Machine.&#x20;
2. On the Windows client machine, navigate to `C:\Program Files (x86)\NICE\DCV\Client\bin\` in the File Manager.
3. Run `dcvusblist.exe`.
4. Right-click on the USB device in the list.
5. Choose Copy filter string from the dropdown menu.
6. On the Computle Machine, open `C:\Program Files\NICE\DCV\Server\conf\usb-devices.conf` using your preferred text editor and add the filter string to a new line at the bottom of the file.
7. Save and close the file.
8. Open the Services snap-in for the Microsoft Management Console.
9. In the right pane, open DCV Server.
10. Click Stop.
11. Click Start.
