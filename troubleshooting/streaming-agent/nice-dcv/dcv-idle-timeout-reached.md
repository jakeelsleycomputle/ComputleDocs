# Idle timeout

To change the NICE DCV server's idle timeout period, you must configure the `idle-timeout` parameter using the Windows Registry Editor.

**To change the idle timeout period on Windows**

1. Open the Windows Registry Editor.
2.  Navigate to the HKEY\_USERS\S-1-5-18\Software\GSettings\com\nicesoftware\dcv\connectivity\ key and select the idle-timeout parameter.

    If the parameter can't be found, use the following steps to create it:

    1. In the navigation pane, open the context (right-click) menu for the connectivity key. Then, choose New, DWORD (32-bit) value.
    2. For Name, enter `idle-timeout` and press Enter.
3. Open the idle-timeout parameter. For Value data, enter a value for the idle timeout period (in minutes, decimal). To avoid disconnecting idle clients, enter `0`.
4. Choose OK and close the Windows Registry Editor.
