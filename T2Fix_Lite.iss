; T2Fix Lite
; Setup Script

; Version information
#define FName "T2Fix Lite"
#define FLongName "Thief 2 Fixer Lite"
#define FVer "1.27e"

; Define basic setup characteristics
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

; Define files to be included within the setup executable
[Files]
Source: "Resources\newdark\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Resources\config\cam_mod.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "Resources\config\cam_ext.cfg"; DestDir: "{app}"; Flags: ignoreversion

; Pascal script for more thorough setup customization and work
[Code]
{ Detect if setup has write access to the currently-selected directory }
function HaveDirWriteAccess(): Boolean;
var
  FileName: String;
begin
  FileName := ExpandConstant('{app}\writetest.tmp');
  Result := SaveStringToFile(FileName, #13#10, False);
  if Result then
    DeleteFile(FileName);
end;

{ Handle checks necessary when moving to the next page }
function NextButtonClick(PageId: Integer): Boolean;
begin
  Result := True;
  if (PageId = wpSelectDir) then begin
    if not FileExists(ExpandConstant('{app}\thief2.exe')) then begin
      SuppressibleMsgBox('A valid Thief 2 install was not detected. Please select a directory in which the game is installed.', mbError, MB_OK, IDOK);
      Result := False;
      Exit;
    end;
    if not HaveDirWriteAccess then begin
      SuppressibleMsgBox('{#FName} cannot write to the specified directory. Please choose a directory to which you have write access.', mbError, MB_OK, IDOK);
      Result := False;
      Exit;
    end
  end;
end;

[Messages]
SetupAppTitle={#FName}
SetupWindowTitle={#FLongName} {#FVer}
FinishedHeadingLabel={#FLongName} Setup Complete 
FinishedLabelNoIcons=Setup has finished installing.
FinishedLabel=Setup has finished installing.
ExitSetupTitle=Exit {#FName}
ExitSetupMessage=Are you sure you want to exit?
SelectDirDesc=Select the location of your existing Thief 2 installation.
SelectDirLabel3=Setup will install {#FName} into the following directory.
PreparingDesc=Setup is preparing to install {#FName} on your computer.
InstallingLabel=Please wait while Setup installs {#FName} on your computer.
