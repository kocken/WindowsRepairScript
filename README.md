# WindowsRepairScript
Repairs corrupt Windows OS files and fixes disk errors by executing the [SFC](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/sfc), [DISM](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/repair-a-windows-image) and [CHKDSK](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk) Windows commands from a batch script file.

These commands are frequently recommended to fix various system errors. Surprisingly I couldn't find any script online to easily execute all of these commands one by one, so I made it myself.

You only need to start the "Run" batch file, the "CHKDSK_scan" powershell file will be executed from the batch file. The file(s) will execute the following commands, in the same order as listed below:

SFC /ScanNow
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
CHKDSK :drive /F /X - This command is optional by prompt. This command is run on all local drives, whereas HDD drives has the option to use the /R parameter to scan for bad sectors, for a more comprehensive scan.
