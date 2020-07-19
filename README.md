# WindowsRepairScript
Repairs corrupt Windows OS files and fixes disk errors by executing the [SFC](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/sfc), [DISM](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/repair-a-windows-image) and [CHKDSK](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk) Windows commands from a batch script file.

These commands are frequently recommended to fix Windows system errors. I couldn't find any script online to easily execute all of these commands one by one, so I made it myself.

You only need to start the "Run.bat" file, the "CHKDSK_scan.ps1" powershell file is run from the batch file. The file(s) will execute the following commands below, in the same order as listed:

1. SFC /ScanNow
2. DISM /Online /Cleanup-Image /CheckHealth
3. DISM /Online /Cleanup-Image /ScanHealth
4. DISM /Online /Cleanup-Image /RestoreHealth
5. CHKDSK :drive /F /X - This command is optional by prompt. This command is run on all local drives, whereas HDD drives has the option to use the /R parameter to scan for bad sectors, for a more comprehensive scan.
