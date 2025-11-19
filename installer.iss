[Setup]
AppName=DaVinci RPC Launcher
AppVersion=1.0
DefaultDirName={userappdata}\DaVinciRPC
DisableProgramGroupPage=yes
OutputBaseFilename=DaVinciRPCInstaller
Compression=lzma
SolidCompression=yes

[Files]
; Copia o launcher.bat para a pasta de instalação
Source: "launcher.bat"; DestDir: "{app}"; Flags: ignoreversion

; Baixa o RPC.exe (ou já incluir no instalador)
Source: "{tmp}\davinci-rpc.exe"; DestDir: "{app}"; Flags: external download

[Code]
procedure InitializeWizard;
begin
  idpAddFile(
    'https://github.com/zherri/davinci-rpc/davinci-rpc.exe',  // Link direto para download
    ExpandConstant('{tmp}\davinci-rpc.exe')
  );
end;

[Icons]
; Cria atalho na área de trabalho
Name: "{commondesktop}\DaVinci Resolve";
Filename: "cmd.exe";
Parameters: "/c ""{app}\launcher.bat""";
IconFilename: "C:\Program Files\Blackmagic Design\DaVinci Resolve\Resolve.exe";
Tasks: desktopicon
