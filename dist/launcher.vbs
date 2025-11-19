Set fso = CreateObject("Scripting.FileSystemObject")
scriptFolder = fso.GetParentFolderName(WScript.ScriptFullName)

batPath = scriptFolder & "\launcher.bat"

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run Chr(34) & batPath & Chr(34), 0
Set WshShell = Nothing
Set fso = Nothing
