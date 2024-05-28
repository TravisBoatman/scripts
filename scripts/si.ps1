Get-WmiObject -Class Win32_OperatingSystem |
Select-Object CSName, Version, BuildNumber, Manufacturer, Caption