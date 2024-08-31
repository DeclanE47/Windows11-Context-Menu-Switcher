@echo off
title Windows 11 Context Menu Switcher
:menu
cls
echo ===============================
echo Windows 11 Context Menu Switcher
echo ===============================
echo Created by: Declan
echo GitHub: https://github.com/DeclanE47
echo ===============================
echo 1. Enable Old Style Right-Click Menu
echo 2. Switch to Windows 11 Right-Click Menu
echo 3. Exit
echo ===============================
set /p choice=Choose an option (1-3): 

if "%choice%"=="1" goto oldmenu
if "%choice%"=="2" goto newmenu
if "%choice%"=="3" exit

:oldmenu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
echo Old style right-click menu enabled.
goto restart

:newmenu
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
echo Windows 11 right-click menu restored.
goto restart

:restart
echo Restarting Windows Explorer to apply changes...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo Restart complete.
pause
goto menu
