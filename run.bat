@echo off

echo Checking powershell version...
powershell -command "exit" 2>nul
if errorlevel 1 (
 echo Powershell is not installed! Please install it before running this script
 echo See: http://www.github.com/AULFA/speedtest/README.md#powershell-is-not-installed
 timeout 15
 exit
)

powershell.exe -noprofile -executionpolicy Unrestricted -file .\run.ps1
timeout 15
exit
