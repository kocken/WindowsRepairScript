@echo off
:: Elevate window with administrator privileges, snippet from https://stackoverflow.com/a/52517718
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

echo Running scans with administrator privileges

echo.
echo.
echo Starting "SFC /ScanNow" scan
SFC /ScanNow

echo.
echo.
echo Starting "DISM /Online /Cleanup-Image /CheckHealth" scan
DISM /Online /Cleanup-Image /CheckHealth

echo.
echo.
echo Starting "DISM /Online /Cleanup-Image /ScanHealth" scan
DISM /Online /Cleanup-Image /ScanHealth

echo.
echo.
echo Starting "DISM /Online /Cleanup-Image /RestoreHealth" scan
DISM /Online /Cleanup-Image /RestoreHealth

echo.
echo.
PowerShell -file "CHKDSK_scan.ps1"

echo.
echo.
echo Scan completed

echo.
pause
exit