@echo off
start "" "C:\Program Files\Blackmagic Design\DaVinci Resolve\Resolve.exe"
timeout /t 5 >nul
start "" "%APPDATA%\DaVinciRPC\DaVinciRPC.exe"
exit
