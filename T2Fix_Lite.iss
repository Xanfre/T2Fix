; T2Fix Lite
; Setup Script

; Version Information
#define FName "T2Fix Lite"
#define FLongName "Thief 2 Fixer Lite"
#define FVer "1.27e"

; Language File Processing Routines
#include "lang.iss"

; IS5 Compatibility
#if Ver < 0x06000000
#pragma message "Building with IS5 Compatibility"
#define IS5
#endif

; Define basic setup characteristics.
[Setup]
AppName={#FLongName}
AppVersion={#FVer}
VersionInfoVersion=1.2.7.5
OutputBaseFilename=T2Fix_Lite_{#FVer}
Compression=lzma2/ultra64
DefaultDirName=C:\Games\Thief 2 The Metal Age
SetupIconFile=T2.ico
WizardSmallImageFile=T2s.bmp
WizardImageFile=T2.bmp
PrivilegesRequired=lowest
DirExistsWarning=no
EnableDirDoesntExistWarning=no
AppendDefaultDirName=no
DisableProgramGroupPage=yes
DisableReadyPage=yes
Uninstallable=no
WizardStyle=modern
#ifndef IS5
MinVersion=6.0
#endif

; Define files to be included within the setup executable.
[Files]
Source: "Resources\newdark\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Resources\config\cam_mod.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "Resources\config\cam_ext.cfg"; DestDir: "{app}"; Flags: ignoreversion

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl,{#ProcessLanguage("en.isl")}"

; Pascal script for more thorough setup customization and work.
[Code]
{ Detect if setup has write access to the currently-selected directory. }
function HaveDirWriteAccess(): Boolean;
var
  FileName: String;
begin
  FileName := ExpandConstant('{app}\writetest.tmp');
  Result := SaveStringToFile(FileName, #13#10, False);
  if Result then
    DeleteFile(FileName);
end;

{ Handle checks necessary when moving to the next page. }
function NextButtonClick(PageId: Integer): Boolean;
begin
  Result := True;
  if (PageId = wpSelectDir) then begin
    if not FileExists(ExpandConstant('{app}\thief2.exe')) then begin
      SuppressibleMsgBox(CustomMessage('T2Invalid'), mbError, MB_OK, IDOK);
      Result := False;
      Exit;
    end;
    if not HaveDirWriteAccess then begin
      SuppressibleMsgBox(CustomMessage('NoDirWrite'), mbError, MB_OK, IDOK);
      Result := False;
      Exit;
    end
  end;
end;
