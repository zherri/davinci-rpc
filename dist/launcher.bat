@echo off
set RESOLVE_EXE="C:\Program Files\Blackmagic Design\DaVinci Resolve\Resolve.exe"

set RPC_EXE="%~dp0DaVinciRPC.exe"

start "" %RESOLVE_EXE%

timeout /t 10 >nul

start "" %RPC_EXE%

exit
