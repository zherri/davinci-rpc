[Setup]
AppName=DaVinci RPC
AppVersion=1.0
DefaultDirName={userappdata}\DaVinciRPC
DisableProgramGroupPage=yes
OutputBaseFilename=DaVinciRPCInstaller
Compression=lzma
SolidCompression=yes

[Files]
Source: "dist/launcher.bat"; DestDir: "{app}"; Flags: ignoreversion

Source: "dist/launcher.vbs"; DestDir: "{app}"; Flags: ignoreversion

Source: "dist/DaVinciRPC.exe"; DestDir: "{app}"; Flags: ignoreversion

[Tasks]
Name: desktopicon; Description: "Create desktop shortcut"; GroupDescription: "Additional settings";

[Icons]
Name: "{app}\DaVinci Resolve"; Filename: "wscript.exe"; Parameters: """{app}\launcher.vbs"""; IconFilename: "C:\Program Files\Blackmagic Design\DaVinci Resolve\Resolve.exe"

Name: "{commondesktop}\DaVinci Resolve"; Filename: "wscript.exe"; Parameters: """{app}\launcher.vbs"""; IconFilename: "C:\Program Files\Blackmagic Design\DaVinci Resolve\Resolve.exe"; Tasks: desktopicon
