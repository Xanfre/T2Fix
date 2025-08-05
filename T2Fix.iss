; T2Fix: An Unofficial Patcher and Installer for Thief 2
; Setup Script

; Version Information
#define FName "T2Fix"
#define FLongName "Thief 2 Fixer"
#ifndef FVer
#define FVer "1.0"
#endif
#define FVerNS StringChange(FVer, " ", "")
#ifndef FVIVer
#define FVIVer "1.0.0.0"
#endif
#ifndef OBFSuffix
#define OBFSuffix
#endif

; Language File Processing Routines
#include "lang.iss"

; IS5 Compatibility
#if Ver < 0x06000000
#pragma message "Building with IS5 Compatibility"
#define IS5
#if Len(OBFSuffix) == 0
#define OBFSuffix "_legacy"
#endif
#endif

; Define basic setup characteristics.
[Setup]
AppName={#FLongName}
AppVersion={#FVer}
VersionInfoVersion={#FVIVer}
#ifndef Mods
OutputBaseFilename={#FName}_{#FVerNS}{#OBFSuffix}
#else
OutputBaseFilename={#FName}_{#FVerNS}_with_mods{#OBFSuffix}
#endif
#ifdef DEBUG
Compression=none
#else
Compression=lzma2/ultra64
#endif
DefaultDirName=C:\Games\Thief 2 The Metal Age
SetupIconFile=T2.ico
WizardSmallImageFile=T2s.bmp
WizardImageFile=T2.bmp
PrivilegesRequired=lowest
DirExistsWarning=no
EnableDirDoesntExistWarning=no
AppendDefaultDirName=no
DisableWelcomePage=no
DisableProgramGroupPage=yes
#ifndef Mods
InfoBeforeFile=info_{#FVIVer}.txt
#else
InfoBeforeFile=info_{#FVIVer}_with_mods.txt
#endif
Uninstallable=no
WizardStyle=modern

; Define files to be included within the setup executable.
[Files]
; Thief 2 files from CD
Source: "{code:CDDir}\RES\bitmap.crf"; DestDir: "{app}\RES"; Components: newdark; BeforeInstall: PreGameConfig; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\books.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\camera.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\default.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\editor.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\editor.res"; DestDir: "{app}"; Components: newdark;Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\fam.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\intrface.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\mesh.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\motions.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\obj.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\pal.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\SHKRES.RES"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\skeldata.res"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\snd.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\song.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\RES\strings.crf"; DestDir: "{app}\RES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\TEXTURE.RES"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\thief2.exe"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\DEATH.AVI"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\SUCCESS.AVI"; DestDir: "{app}\MOVIES"; Components: newdark; AfterInstall: InsertCD2; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\editor.res"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\SHKRES.RES"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\skeldata.res"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\TEXTURE.RES"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\DEATH.AVI"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\SUCCESS.AVI"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\bitmap.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\books.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\camera.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\default.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\editor.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\fam.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\intrface.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\mesh.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\motions.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\obj.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\pal.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\snd.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\song.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\strings.crf"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\SAVES\CFG0000.BND"; DestDir: "{app}\SAVES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\SAVES\CFG0001.BND"; DestDir: "{app}\SAVES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\SAVES\CFG0002.BND"; DestDir: "{app}\SAVES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\SAVES\cfg0003.bnd"; DestDir: "{app}\SAVES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\archer.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\convict.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\DARK.BND"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\DARK.GAM"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\gen.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\motiondb.bin"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\dark.cfg"; DestDir: "{app}"; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\USER.CFG"; DestDir: "{app}"; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss1.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss1.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss2.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss2.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss4.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss4.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MISS5.MIS"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss6.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss6.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss7.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss7.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss8.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss8.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss9.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss9.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss10.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss10.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss11.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss12.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss12.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss13.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss14.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss14.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss15.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss15.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss16.mis"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\miss16.osm"; DestDir: "{app}"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\B01.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\b02.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\B04.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\b05.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\B06.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\B07.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\b08.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\b09.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\b10.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\b11.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\B12.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\B13.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\b14.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\b15.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\b16.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\CREDITS.AVI"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\cs05.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\cs10.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\cs16.avi"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\DEATH.AVI"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\INTRO.AVI"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\MOVIES\SUCCESS.AVI"; DestDir: "{app}\MOVIES"; Components: newdark; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:CDDir}\thief2.exe"; DestDir: "{app}"; Components: newdark; AfterInstall: BeforePatch; Flags: external ignoreversion skipifsourcedoesntexist
; 1.18 patch data
Source: "Resources\patch118\*"; Excludes: "res.7z"; DestDir: "{app}"; Components: newdark; Check: ExtPatchMis; Flags: ignoreversion
Source: "Resources\patch118\res.7z"; DestDir: "{tmp}"; Components: newdark; Check: ExtPatchData; Flags: ignoreversion deleteafterinstall
; Helper Executables
#ifdef Mods
Source: "Resources\Helper\oggdec.exe"; DestDir: "{tmp}"; Components: newdark and mods\t2seep; Flags: ignoreversion deleteafterinstall
#endif
Source: "Resources\Helper\7za.exe"; DestDir: "{tmp}"; Components: newdark; AfterInstall: GameConfig; Flags: ignoreversion deleteafterinstall
; NewDark
Source: "Resources\newdark\*"; DestDir: "{app}"; Components: newdark; Flags: ignoreversion recursesubdirs createallsubdirs
; Optional libraries
Source: "Resources\libs\OpenAL32.dll"; DestDir: "{app}"; Components: newdark; Tasks: oalsoft; Flags: ignoreversion
Source: "Resources\libs\libmp3lame.dll"; DestDir: "{app}"; Components: newdark; Tasks: lame; Flags: ignoreversion
; Advanced options
Source: "Resources\advanced\miss1.mis.dml"; DestDir: "{app}"; Components: newdark; Check: IsAdvOpChecked(8); Flags: ignoreversion
Source: "Resources\advanced\miss2.mis.dml"; DestDir: "{app}"; Components: newdark; Check: IsAdvOpChecked(8); Flags: ignoreversion
Source: "Resources\advanced\miss4.mis.dml"; DestDir: "{app}"; Components: newdark; Check: IsAdvOpChecked(8); Flags: ignoreversion
Source: "Resources\advanced\dark.gam.dml"; DestDir: "{app}"; Components: newdark; Check: IsAdvOpChecked(9); Flags: ignoreversion
; DromEd
Source: "Resources\dromed\*"; DestDir: "{app}"; Components: dromed; Flags: ignoreversion
; DromEd Config Files and Tools (unnecessary if also installing the toolkit)
Source: "Resources\dromedtk\Tools\3ds_to_bin\3ds\Workshop\BSP.exe"; DestDir: "{app}"; Components: dromed and not dromed\toolkit; Flags: ignoreversion
Source: "Resources\dromedtk\Tools\3ds_to_bin\3ds\Workshop\N3ds2e.exe"; DestDir: "{app}"; Components: dromed and not dromed\toolkit; Flags: ignoreversion
Source: "Resources\dromedtk\Docs\DromEd2 License.txt"; DestDir: "{app}"; DestName: "LICENSE.TXT"; Components: dromed and not dromed\toolkit; Flags: ignoreversion
Source: "Resources\config\MENUS.CFG"; DestDir: "{app}"; Components: dromed and not dromed\toolkit; Flags: ignoreversion
Source: "Resources\config\DEFAULT.BND"; DestDir: "{app}"; Components: dromed and not dromed\toolkit; Flags: ignoreversion
; DromEd Basic Toolkit
Source: "Resources\dromedtk\*"; DestDir: "{app}"; Components: dromed\toolkit; Flags: ignoreversion recursesubdirs createallsubdirs
#ifdef Mods
Source: "Resources\osm\*"; DestDir: "{app}"; Components: osm; Flags: ignoreversion recursesubdirs createallsubdirs
; Thief2 Fixed
Source: "Resources\mods\Thief2 Fixed\*"; DestDir: "{app}\MODS\Thief2 Fixed"; Components: mods\thief2fixed; Flags: ignoreversion recursesubdirs createallsubdirs
; Dark Mod Manager
Source: "Resources\dmm\*"; DestDir: "{app}"; Components: dmm; Flags: ignoreversion
; Carry body mod
Source: "Resources\mods\CarryBody\*"; DestDir: "{app}\MODS\CarryBody"; Components: mods\carrybody; Flags: ignoreversion recursesubdirs createallsubdirs
; Interactive candles
Source: "Resources\mods\Candles\*"; DestDir: "{app}\MODS\Candles"; Components: mods\candles; Flags: ignoreversion
; t2skies
Source: "Resources\mods\t2skies\*"; DestDir: "{app}\MODS\t2skies"; Components: mods\t2skies; Flags: ignoreversion recursesubdirs createallsubdirs
; t2water
Source: "Resources\mods\t2water\*"; DestDir: "{app}\MODS\t2water"; Components: mods\t2water; Flags: ignoreversion recursesubdirs createallsubdirs
; Thief Enhancement Pack
Source: "Resources\mods\EP\*"; DestDir: "{app}\MODS\EP"; Components: mods\ep; Flags: ignoreversion recursesubdirs createallsubdirs
; Sound Enhancement Pack
Source: "Resources\mods\NewT2SFX\*"; DestDir: "{app}\MODS\NewT2SFX"; Components: mods\t2seep; AfterInstall: OggDecode; Flags: ignoreversion recursesubdirs createallsubdirs
; English Subtitles
Source: "Resources\mods\Subtitles\*"; DestDir: "{app}\MODS\Subtitles"; Components: mods\subtitles; Flags: ignoreversion recursesubdirs createallsubdirs
; T2FMDML
Source: "Resources\mods\T2FMDML\*"; DestDir: "{app}\MODS\T2FMDML"; Components: mods\fmdml; Flags: ignoreversion recursesubdirs createallsubdirs
#endif
; NewDark Multiplayer
Source: "Resources\multiplayer\*"; DestDir: "{app}"; Components: multiplayer; Flags: ignoreversion recursesubdirs createallsubdirs
; Legacy Executables
Source: "Resources\olddark\*"; DestDir: "{app}"; Components: olddark; Flags: ignoreversion recursesubdirs createallsubdirs
; Config Files
Source: "Resources\config\cam.cfg"; DestDir: "{app}"; Components: newdark; AfterInstall: ConfigureGeneral; Flags: ignoreversion onlyifdoesntexist
#ifdef Mods
Source: "Resources\config\cam_mod.ini"; DestDir: "{app}"; Components: newdark; BeforeInstall: CheckModIni; AfterInstall: ConfigureMods; Flags: ignoreversion
#else
Source: "Resources\config\cam_mod.ini"; DestDir: "{app}"; Components: newdark; Flags: ignoreversion onlyifdoesntexist
#endif
Source: "Resources\config\cam_ext.cfg"; DestDir: "{app}"; Components: newdark; Check: not WizardIsTaskSelected('nomodifycfg') or not FileExists(ExpandConstant('{app}\cam_ext.cfg')); AfterInstall: ConfigureVideo; Flags: ignoreversion

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl,{#ProcessLanguage("en.isl")}"

; Define optional desktop icons.
[Icons]
Name: "{commondesktop}\{cm:IconThief2}"; Filename: "{app}\thief2.exe"; Components: newdark; Tasks: iconthief2
Name: "{commondesktop}\{cm:IconFMSel}"; Filename: "{app}\thief2.exe"; Parameters: "-fm"; Components: newdark; Tasks: iconthief2fm
Name: "{commondesktop}\{cm:IconDromEd}"; Filename: "{app}\DromEd.exe"; Components: dromed; Tasks: icondromed2
Name: "{commondesktop}\{cm:IconMP}"; Filename: "{app}\Thief2MP.exe"; Components: multiplayer; Tasks: iconmultiplayer

; Define available components.
[Components]
Name: "newdark"; Description: {cm:CompNewDark}; Types: custom; Flags: fixed
Name: "dromed"; Description: {cm:CompDromEd}
Name: "dromed\toolkit"; Description: {cm:CompDromEdTK}
#ifdef Mods
Name: "osm"; Description: {cm:CompScripts}
Name: "dmm"; Description: {cm:CompDMM}
Name: "mods"; Description: {cm:CompMods}
Name: "mods\thief2fixed"; Description: {cm:CompT2F}
Name: "mods\carrybody"; Description: {cm:CompCarryBody}
Name: "mods\candles"; Description: {cm:CompCandles}
Name: "mods\t2skies"; Description: {cm:CompT2Skies}
Name: "mods\t2water"; Description: {cm:CompT2Water}
Name: "mods\ep"; Description: {cm:CompEP}
Name: "mods\t2seep"; Description: {cm:CompSound}; ExtraDiskSpaceRequired: 191601069
Name: "mods\subtitles"; Description: {cm:CompSubtitles}
Name: "mods\fmdml"; Description: {cm:CompT2FMDML}
#endif
Name: "multiplayer"; Description: {cm:CompMP}
Name: "olddark"; Description: {cm:CompLegacy}

; Define custom setup type.
[Types]
Name: "custom"; Description: "Custom"; Flags: iscustom

; Define tasks.
[Tasks]
Name: "vprehigh"; Description: {cm:TaskVideoH}; GroupDescription: {cm:TaskVideo}; Components: newdark; Flags: exclusive unchecked
Name: "vpremed"; Description: {cm:TaskVideoM}; GroupDescription: {cm:TaskVideo}; Components: newdark; Flags: exclusive unchecked
Name: "vprelow"; Description: {cm:TaskVideoL}; GroupDescription: {cm:TaskVideo}; Components: newdark; Flags: exclusive
Name: "nomodifycfg"; Description: {cm:TaskVideoNone}; GroupDescription: {cm:TaskVideo}; Components: newdark; Flags: unchecked
Name: "oalsoft"; Description: {cm:TaskOALSoft}; GroupDescription: {cm:TaskInst}; Components: newdark; Flags: unchecked
Name: "lame"; Description: {cm:TaskMP3}; GroupDescription: {cm:TaskInst}; Components: newdark; Flags: unchecked
Name: "cleanup"; Description: {cm:TaskCleanUp}; GroupDescription: {cm:TaskInst}; Components: newdark; Flags: unchecked
Name: "iconthief2"; Description: {cm:TaskIconThief2}; GroupDescription: {cm:TaskIcon}; Components: newdark; Flags: unchecked
Name: "iconthief2fm"; Description: {cm:TaskIconFMSel}; GroupDescription: {cm:TaskIcon}; Components: newdark; Flags: unchecked
Name: "icondromed2"; Description: {cm:TaskIconDromEd}; GroupDescription: {cm:TaskIcon}; Components: dromed; Flags: unchecked
Name: "iconmultiplayer"; Description: {cm:TaskIconMP}; GroupDescription: {cm:TaskIcon}; Components: multiplayer; Flags: unchecked

; Pascal script for more thorough setup customization and work.
[Code]
{ Globals }
var
  ImmediateExit: Boolean;
  CD: String;
  Lang: String;
#ifdef Mods
  OnCompClickOrig: TNotifyEvent;
#endif
  NeedsPatch: Boolean;
  NeedsMisPatch: Boolean;
  InstGame: TNewCheckBox;
  PrevCompBut: TNewButton;
  AdvPage: TWizardPage;
  AdvOp1: TNewCheckBox;
  AdvOp2: TNewCheckBox;
  AdvOp3: TNewCheckBox;
  AdvOp4: TNewCheckBox;
  AdvOp5: TNewCheckBox;
  AdvOp6: TNewCheckBox;
  AdvOp7: TNewCheckBox;
  AdvOp8: TNewCheckBox;
  AdvOp9: TNewCheckBox;
  AdvOp10: TNewCheckBox;
  AdvOp11: TNewCheckBox;
#ifdef Mods
  AdvOp12: TNewCheckBox;
#endif
  AdvOp13: TNewCheckBox;
#ifndef IS5
  LastHoverIndex: Integer;
  CompHovering: Boolean;
#endif
  CompLabel: TLabel;
  CompBevel: TBevel;
  BevelCap: TLabel;
  CompDesc: String;
  InitialPage: Boolean;
  TasksState: Array of TCheckBoxState;
  AdvVLabel: TLabel;
  AdvGLabel: TLabel;
#ifdef Mods
  ModIniSettings: Array of String;
#endif
  WinVer: Cardinal;

#ifdef IS5
{ IS5 Wrapper Functions }
function WizardIsComponentSelected(Components: String): Boolean;
begin
  Result := IsComponentSelected(Components);
end;

function WizardIsTaskSelected(Tasks: String): Boolean;
begin
  Result := IsTaskSelected(Tasks);
end;

function IsAdmin: Boolean;
begin
  Result := IsAdminLoggedOn;
end;
#endif

{ Get the path of the CD or data source path chosen on the directory selection
  page. }
function CDDir(Param: String): String;
begin
  Result := CD;
end;

{ Check if the patched resources should be extracted. }
function ExtPatchData(): Boolean;
begin
  Result := NeedsPatch or AdvOp10.Checked;
end;

{ Check if the patched missions should be extracted. }
function ExtPatchMis(): Boolean;
begin
  Result := NeedsPatch or NeedsMisPatch or AdvOp10.Checked;
end;

{ Check if the specified advanced option is selected.
  For use in other sections of the setup script. }
function IsAdvOpChecked(Op: Integer): Boolean;
begin
  case Op of
    1: Result := AdvOp1.Checked;
    2: Result := AdvOp2.Checked;
    3: Result := AdvOp3.Checked;
    4: Result := AdvOp4.Checked;
    5: Result := AdvOp5.Checked;
    6: Result := AdvOp6.Checked;
    7: Result := AdvOp7.Checked;
    8: Result := AdvOp8.Checked;
    9: Result := AdvOp9.Checked;
    10: Result := AdvOp10.Checked;
    11: Result := AdvOp11.Checked;
#ifdef Mods
    12: Result := AdvOp12.Checked;
#endif
    13: Result := AdvOp13.Checked;
  else
    Result := False;
  end;
end;

{ Close the wizard form without any additional user input.
  Automatically handles purging the temp directory and such. }
procedure ImmediateFClose();
begin
  ImmediateExit := True;
  WizardForm.Close;
end;

{ Show dialogs prompting for the second CD if necessary. }
procedure InsertCD2();
begin
  if InstGame.Checked then begin
    if not FileExists(CD + '\RES\fam.crf') then begin
      SuppressibleMsgBox(CustomMessage('T2InstallRemoved'), mbError, MB_OK, IDOK);
      ImmediateFClose;
      Exit;
    end;
    if not FileExists(CD + '\miss8.mis') then begin
      while not FileExists(CD + '\miss8.mis') do begin
        if BrowseForFolder(CustomMessage('CD2Prompt'), CD, False) then begin
          if FileExists(CD + '\THIEF2\miss8.mis') then begin
            CD := CD + '\THIEF2';
            StringChangeEx(CD, ':\\THIEF2', ':\THIEF2', True);
          end;
          if not FileExists(CD + '\miss8.mis') then
            SuppressibleMsgBox(CustomMessage('T2InstallFailed'), mbError, MB_OK, IDOK);
          if (CompareText(CD, ExpandConstant('{app}')) = 0) then begin
            SuppressibleMsgBox(CustomMessage('T2InstallSameDir'), mbError, MB_OK, IDOK);
            CD := '';
          end;
        end else begin
          if SuppressibleMsgBox(CustomMessage('NoSelectedDir'), mbConfirmation, MB_YESNO, IDYES) = IDYES then begin
            ImmediateFClose;
            Exit;
          end;
          CD := '';
        end;
      end;
    end;
  end;
end;

type
  TShellExecuteInfo = record
    cbSize: DWORD;
    fMask: Cardinal;
    Wnd: HWND;
    lpVerb: String;
    lpFile: String;
    lpParameters: String;
    lpDirectory: String;
    nShow: Integer;
    hInstApp: THandle;
    lpIDList: DWORD;
    lpClass: String;
    hkeyClass: THandle;
    dwHotKey: DWORD;
    hMonitor: THandle;
    hProcess: THandle;
  end;
  TMsg = record
    hwnd: HWND;
    message: UINT;
    wParam: Longint;
    lParam: Longint;
    time: DWORD;
    pt: TPoint;
  end;
const
  WAIT_OBJECT_0 = $0;
  WAIT_TIMEOUT = $00000102;
  SEE_MASK_NOCLOSEPROCESS = $00000040;
  INFINITE = $FFFFFFFF;
  PM_REMOVE = 1;
function ShellExecuteEx(var lpExecInfo: TShellExecuteInfo): BOOL;
  external 'ShellExecuteExW@shell32.dll stdcall';
function WaitForSingleObject(hHandle: THandle; dwMilliseconds: DWORD): DWORD;
  external 'WaitForSingleObject@kernel32.dll stdcall';
function CloseHandle(hObject: THandle): BOOL;
  external 'CloseHandle@kernel32.dll stdcall';
function PeekMessage(var lpMsg: TMsg; hWnd: HWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL;
  external 'PeekMessageW@user32.dll stdcall';
function TranslateMessage(const lpMsg: TMsg): BOOL;
  external 'TranslateMessage@user32.dll stdcall';
function DispatchMessage(const lpMsg: TMsg): Longint;
  external 'DispatchMessageW@user32.dll stdcall';

{ Pump the message queue to prevent blocking the UI thread.
  The interface would be sluggish while doing long operations otherwise. }
procedure AppProcessMessage();
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
  {WizardForm.Refresh;}
end;

{ Execute a program while not blocking the UI thread. }
procedure Execute(Exe: String; Params: String);
var
  ExecInfo: TShellExecuteInfo;
begin
  ExecInfo.cbSize := SizeOf(ExecInfo);
  ExecInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  ExecInfo.Wnd := 0;
  ExecInfo.lpFile := Exe;
  ExecInfo.lpParameters := Params;
  ExecInfo.nShow := SW_HIDE;
  if ShellExecuteEx(ExecInfo) then begin
    while WaitForSingleObject(ExecInfo.hProcess, 5) = WAIT_TIMEOUT do begin
      AppProcessMessage();
    end;
    CloseHandle(ExecInfo.hProcess);
  end;
end;

{ Change the status caption shown during installation. }
procedure SetStatusCaption(const Message: String);
begin
  WizardForm.StatusLabel.Caption := Message;
end;

{ Change the filename caption shown during installation. }
procedure SetFilenameCaption(const Message: String);
begin
  WizardForm.FilenameLabel.Caption := Message;
end;

{ Add the specified path to a string. }
procedure AddPath(var S: String; Path: String);
begin
  if (Length(S) <> 0) then
    S := S + '+';
  S := S + Path;
end;

{ Return the specified Ini setting. }
function GetIniSetting(S, Key: String; Param: Boolean): String;
begin
  Result := '';
  if (Pos(#13#10, S) = 0) then
    Exit;
  if Param then begin
    if (Pos(#13#10 + Key, S) <> 0) or (Pos(Key, S) = 1) then begin
      if (Pos(#13#10 + Key, S) <> 0) then
        Delete(S, 1, Pos(#13#10 + Key, S)+1);
      if (Pos(#13#10, S) <> 0) then
        Delete(S, Pos(#13#10, S), Length(S));
      Result := S;
    end;
  end else begin
    if (Pos(#13#10 + Key + #13#10, S) <> 0) or (Pos(Key + #13#10, S) = 1) or
       (Pos(#13#10 + Key, S)+Length(Key)+1 = Length(S)) or (CompareText(Key, S) = 0) then
      Result := Key;
  end;
end;

{ Check or uncheck the specified component according to the condition. }
procedure CheckComponent(I: Integer; C: Boolean);
begin
  if C and WizardForm.ComponentsList.ItemEnabled[I] then
    WizardForm.ComponentsList.CheckItem(I, coCheck)
  else
    WizardForm.ComponentsList.CheckItem(I, coUncheck);
  WizardForm.ComponentsList.OnClickCheck(WizardForm.ComponentsList);
end;

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

{ Elevate the setup executable }
function Elevate(): Boolean;
var
  I: Integer;
  ExecInfo: TShellExecuteInfo;
  Params: String;
  S: String;
begin
#ifdef IS5
  if (WinVer < $06000000) then
    Result := False
  else begin
#endif
  { Disable the buttons. }
  WizardForm.CancelButton.Enabled := False;
  WizardForm.NextButton.Enabled := False;
  WizardForm.BackButton.Enabled := False;
  WizardForm.DirEdit.Enabled := False;
  WizardForm.DirBrowseButton.Enabled := False;
  InstGame.Enabled := False;
  { Iterate through passed parameters. }
  Params := '';
  for I := 1 to ParamCount do begin
    S := ParamStr(I);
    { Unique log file name. }
    if (CompareText(Copy(S, 1, 5), '/LOG=') = 0) then
      S := S + '-elevated';
    { Add paramater. }
    if (CompareText(Copy(S, 1, 6), '/LANG=') <> 0) and (CompareText(Copy(S, 1, 5), '/DIR=') <> 0) and 
       (CompareText(Copy(S, 1, 5), '/SL5=') <> 0) then
      Params := Params + AddQuotes(S) + ' ';
  end;
  { Add current language and directory to parameters and skip the info pages. }
  Params := Params + '/LANG=' + ActiveLanguage + ' ' + AddQuotes('/DIR=' + WizardDirValue) + ' /SKIPTOCOMP=TRUE';
  if InstGame.Checked then
    Params := Params + ' /INSTGAME=TRUE';
  { Execute new process. }
  ExecInfo.cbSize := SizeOf(ExecInfo);
  ExecInfo.Wnd := 0;
  ExecInfo.lpVerb := 'runas'
  ExecInfo.lpFile := ExpandConstant('{srcexe}');
  ExecInfo.lpParameters := Params;
  ExecInfo.nShow := SW_SHOW;
  if ShellExecuteEx(ExecInfo) then
    Result := (ExecInfo.hInstApp > 32)
  else
    Result := False;
  { Close the old process if successful and enable the buttons. }
  WizardForm.CancelButton.Enabled := True;
  WizardForm.NextButton.Enabled := True;
  WizardForm.BackButton.Enabled := True;
  WizardForm.DirEdit.Enabled := True;
  WizardForm.DirBrowseButton.Enabled := True;
  InstGame.Enabled := True;
  if Result then
    ImmediateFClose;
#ifdef IS5
  end;
#endif
end;

{ Set the game language in darkinst.cfg. }
procedure SetLang();
var
  A: AnsiString;
  U: String;
  Darkinst: String;
begin
  SetStatusCaption(CustomMessage('LangConfig'));
  { Simply use the defined language if darkinst.cfg exists and the language
    field is set. }
  if FileExists (ExpandConstant('{app}\darkinst.cfg')) then begin
    LoadStringFromFile(ExpandConstant('{app}\darkinst.cfg'), A);
    U := A;
  end else
    U := '';
  Lang := GetIniSetting(U, 'language ', True);
  Delete(Lang, 1, 9);
  Lang := Trim(Lang);
  { Otherwise detect it ourselves. }
  if (Length(Lang) = 0) then begin
    { Extract strings.crf to check for game language. }
    Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('x "{app}\RES\strings.crf" -o"{tmp}"'));
    { Check language and append as necessary. }
    if DirExists(ExpandConstant('{tmp}\english')) then
      AddPath(Lang, 'english');
    if DirExists(ExpandConstant('{tmp}\german')) then
      AddPath(Lang, 'german');
    if DirExists(ExpandConstant('{tmp}\french')) then
      AddPath(Lang, 'french');
  end;
  if (Pos('english', Lang) = 0) and (Pos('german', Lang) = 0) and (Pos('french', Lang) = 0) then begin
    if (Length(Lang) = 0) then
      Lang := 'english+german+french';
    SuppressibleMsgBox(CustomMessage('LangConfigWarn'), mbError, MB_OK, IDOK);
  end;
  SetStatusCaption(CustomMessage('LangConfigApply'));
  Darkinst := 'install_path .\' + #13#10 +
    'language ' + Lang + #13#10 +
    'resname_base .\RES' + #13#10 +
    'load_path .\' + #13#10 +
    'script_module_path .\' + #13#10 +
    'movie_path .\MOVIES' + #13#10;
  if WizardIsComponentSelected('olddark') then
    SaveStringToFile(ExpandConstant('{app}\oldinst.cfg'), Darkinst, False);
  if DirExists(ExpandConstant('{app}\OSM'))
#ifdef Mods
    or WizardIsComponentSelected('osm')
#endif
  then
    StringChangeEx(Darkinst, 'script_module_path .\', 'script_module_path .\OSM+.\', True);
  SaveStringToFile(ExpandConstant('{app}\darkinst.cfg'), Darkinst, False);
  SetStatusCaption('');
end;

{ Apply the official 1.18 patch files. }
procedure ApplyPatch();
begin
  SetStatusCaption(CustomMessage('VerConfig'));
  if NeedsPatch or AdvOp10.Checked then begin
    SetStatusCaption(CustomMessage('PatchConfig'));
    SetFilenameCaption(CustomMessage('ExtractingFiles'));
    { Extract patched resources. }
    Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('x "{tmp}\p118res.7z" -o"{tmp}"'));
    { We can't write to read-only resources.
      So remove special file attributes on CRFs in .\RES. }
    Execute(ExpandConstant('"{sys}\attrib.exe"'), ExpandConstant('-R "{app}\RES\*.CRF"'));
    { Install patched resources. }
    SetFilenameCaption(CustomMessage('CRFPatching') + ' fam.crf');
    Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('a "{app}\RES\fam.crf" "{tmp}\fam\*"'));
    SetFilenameCaption(CustomMessage('CRFPatching') + ' mesh.crf');
    Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('a "{app}\RES\mesh.crf" "{tmp}\mesh\*"'));
    SetFilenameCaption(CustomMessage('CRFPatching') + ' obj.crf');
    Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('a "{app}\RES\obj.crf" "{tmp}\obj\*"'));
    { Install English-specific patched resources. }
    if not (Pos('english', Lang) = 0) then begin
      SetFilenameCaption(CustomMessage('CRFPatching') + ' books.crf (English)');
      Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('a "{app}\RES\books.crf" "{tmp}\english\books\*"'));
      SetFilenameCaption(CustomMessage('CRFPatching') + ' intrface.crf (English)');
      Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('a "{app}\RES\intrface.crf" "{tmp}\english\intrface\*"'));
      SetFilenameCaption(CustomMessage('CRFPatching') + ' snd.crf (English)');
      Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('a "{app}\RES\snd.crf" "{tmp}\english\snd\*"'));
      SetFilenameCaption(CustomMessage('CRFPatching') + ' strings.crf (English)');
      Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('a "{app}\RES\strings.crf" "{tmp}\english\strings\*"'));
    end;
    { Install German-specific patched resources. }
    if not (Pos('german', Lang) = 0) then begin
      SetFilenameCaption(CustomMessage('CRFPatching') + ' books.crf (Deutsch)');
      Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('a "{app}\RES\books.crf" "{tmp}\german\books\*"'));
      SetFilenameCaption(CustomMessage('CRFPatching') + ' intrface.crf (Deutsch)');
      Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('a "{app}\RES\intrface.crf" "{tmp}\german\intrface\*"'));
      SetFilenameCaption(CustomMessage('CRFPatching') + ' strings.crf (Deutsch)');
      Execute(ExpandConstant('"{tmp}\7za.exe"'), ExpandConstant('a "{app}\RES\strings.crf" "{tmp}\german\strings\*"'));
    end;
    SetFilenameCaption(CustomMessage('FinishConfig'));
    DelTree(ExpandConstant('{tmp}\fam'), True, True, True);
    DelTree(ExpandConstant('{tmp}\mesh'), True, True, True);
    DelTree(ExpandConstant('{tmp}\obj'), True, True, True);
    DelTree(ExpandConstant('{tmp}\english'), True, True, True);
    DelTree(ExpandConstant('{tmp}\german'), True, True, True);
    SetFilenameCaption('');
  end;
end;

{ Clean up the installation directory. }
procedure CleanUp();
begin
  if WizardIsTaskSelected('cleanup') then begin
    SetStatusCaption(CustomMessage('CleanUp'));
    { Steam distribution cleanup. }
    if FileExists(ExpandConstant('{app}\Steam_install.cfg')) or FileExists(ExpandConstant('{app}\Steam_darkinst.cfg')) then begin
      DeleteFile(ExpandConstant('{app}\Steam_install.cfg'));
      DeleteFile(ExpandConstant('{app}\Steam_darkinst.cfg'));
      DeleteFile(ExpandConstant('{app}\211740_install.vdf'));
      DeleteFile(ExpandConstant('{app}\unins000.exe'));
      DeleteFile(ExpandConstant('{app}\unins000.dat'));
      DeleteFile(ExpandConstant('{app}\innosetup_license.txt'));
    end;
    { General cleanup. }
    DeleteFile(ExpandConstant('{app}\install.cfg'));
    DeleteFile(ExpandConstant('{app}\lgvid.ax'));
    DeleteFile(ExpandConstant('{app}\00000407.016'));
    DeleteFile(ExpandConstant('{app}\00000407.256'));
    DeleteFile(ExpandConstant('{app}\00000409.016'));
    DeleteFile(ExpandConstant('{app}\00000409.256'));
    DeleteFile(ExpandConstant('{app}\eidos.url'));
    DeleteFile(ExpandConstant('{app}\eidosstore.url'));
    DeleteFile(ExpandConstant('{app}\eidossto.url'));
    DeleteFile(ExpandConstant('{app}\eidosuk.url'));
    DeleteFile(ExpandConstant('{app}\eidosus.url'));
    DeleteFile(ExpandConstant('{app}\ets.url'));
    DeleteFile(ExpandConstant('{app}\itypes.b'));
    DeleteFile(ExpandConstant('{app}\itypes.f'));
    DeleteFile(ExpandConstant('{app}\itypes.g'));
    DeleteFile(ExpandConstant('{app}\itypes.m'));
    DeleteFile(ExpandConstant('{app}\itypes.t'));
    DeleteFile(ExpandConstant('{app}\lgt.url'));
    DeleteFile(ExpandConstant('{app}\register.url'));
    DeleteFile(ExpandConstant('{app}\patch.url'));
    DeleteFile(ExpandConstant('{app}\lglass.u'));
    DeleteFile(ExpandConstant('{app}\readme.wri'));
    DeleteFile(ExpandConstant('{app}\readmeuk.wri'));
    DeleteFile(ExpandConstant('{app}\3DS2E.EXE'));
    DeleteFile(ExpandConstant('{app}\BSP.EXE'));
    DeleteFile(ExpandConstant('{app}\CSGMERGE.EXE'));
    { DRM file cleanup. }
    DeleteFile(ExpandConstant('{app}\CLCD16.DLL'));
    DeleteFile(ExpandConstant('{app}\CLCD32.DLL'));
    DeleteFile(ExpandConstant('{app}\CLOKSPL.EXE'));
    DeleteFile(ExpandConstant('{app}\DPLAYERX.DLL'));
    DeleteFile(ExpandConstant('{app}\DRVMGT.DLL'));
    DeleteFile(ExpandConstant('{app}\SECDRV.SYS'));
    DeleteFile(ExpandConstant('{app}\THIEF2.ICD'));
    { Logs and temp file cleanup. }
    DeleteFile(ExpandConstant('{app}\INSTALL.LOG'));
    DeleteFile(ExpandConstant('{app}\license.txt'));
    { DromEd file cleanup. }
    DeleteFile(ExpandConstant('{app}\dromed.ico'));
    DeleteFile(ExpandConstant('{app}\dromed license.txt'));
    DeleteFile(ExpandConstant('{app}\KEYBIND.CFG'));
    DeleteFile(ExpandConstant('{app}\SCHEMA.ZIP'));
    DeleteFile(ExpandConstant('{app}\Icon.ico'));
  end;
  SetStatusCaption(CustomMessage('PrepareDir'));
  { Create FMs directory if it does not already exist. }
  if not DirExists(ExpandConstant('{app}\FMs')) then
    CreateDir(ExpandConstant('{app}\FMs'));
  { Move CRFs to .\RES if needed. }
  if not DirExists(ExpandConstant('{app}\RES')) then
    CreateDir(ExpandConstant('{app}\RES'));
  if FileExists(ExpandConstant('{app}\bitmap.crf')) and not FileExists(ExpandConstant('{app}\RES\bitmap.crf')) then
    RenameFile(ExpandConstant('{app}\bitmap.crf'), ExpandConstant('{app}\RES\bitmap.crf'));
  if FileExists(ExpandConstant('{app}\books.crf')) and not FileExists(ExpandConstant('{app}\RES\books.crf')) then
    RenameFile(ExpandConstant('{app}\books.crf'), ExpandConstant('{app}\RES\books.crf'));
  if FileExists(ExpandConstant('{app}\camera.crf')) and not FileExists(ExpandConstant('{app}\RES\camera.crf')) then
    RenameFile(ExpandConstant('{app}\camera.crf'), ExpandConstant('{app}\RES\camera.crf'));
  if FileExists(ExpandConstant('{app}\default.crf')) and not FileExists(ExpandConstant('{app}\RES\default.crf')) then
    RenameFile(ExpandConstant('{app}\default.crf'), ExpandConstant('{app}\RES\default.crf'));
  if FileExists(ExpandConstant('{app}\editor.crf')) and not FileExists(ExpandConstant('{app}\RES\editor.crf')) then
    RenameFile(ExpandConstant('{app}\editor.crf'), ExpandConstant('{app}\RES\editor.crf'));
  if FileExists(ExpandConstant('{app}\fam.crf')) and not FileExists(ExpandConstant('{app}\RES\fam.crf')) then
    RenameFile(ExpandConstant('{app}\fam.crf'), ExpandConstant('{app}\RES\fam.crf'));
  if FileExists(ExpandConstant('{app}\intrface.crf')) and not FileExists(ExpandConstant('{app}\RES\intrface.crf')) then
    RenameFile(ExpandConstant('{app}\intrface.crf'), ExpandConstant('{app}\RES\intrface.crf'));
  if FileExists(ExpandConstant('{app}\mesh.crf')) and not FileExists(ExpandConstant('{app}\RES\mesh.crf')) then
    RenameFile(ExpandConstant('{app}\mesh.crf'), ExpandConstant('{app}\RES\mesh.crf'));
  if FileExists(ExpandConstant('{app}\motions.crf')) and not FileExists(ExpandConstant('{app}\RES\motions.crf')) then
    RenameFile(ExpandConstant('{app}\motions.crf'), ExpandConstant('{app}\RES\motions.crf'));
  if FileExists(ExpandConstant('{app}\obj.crf')) and not FileExists(ExpandConstant('{app}\RES\obj.crf')) then
    RenameFile(ExpandConstant('{app}\obj.crf'), ExpandConstant('{app}\RES\obj.crf'));
  if FileExists(ExpandConstant('{app}\pal.crf')) and not FileExists(ExpandConstant('{app}\RES\pal.crf')) then
    RenameFile(ExpandConstant('{app}\pal.crf'), ExpandConstant('{app}\RES\pal.crf'));
  if FileExists(ExpandConstant('{app}\snd.crf')) and not FileExists(ExpandConstant('{app}\RES\snd.crf')) then
    RenameFile(ExpandConstant('{app}\snd.crf'), ExpandConstant('{app}\RES\snd.crf'));
  if FileExists(ExpandConstant('{app}\song.crf')) and not FileExists(ExpandConstant('{app}\RES\song.crf')) then
    RenameFile(ExpandConstant('{app}\song.crf'), ExpandConstant('{app}\RES\song.crf'));
  if FileExists(ExpandConstant('{app}\strings.crf')) and not FileExists(ExpandConstant('{app}\RES\strings.crf')) then
    RenameFile(ExpandConstant('{app}\strings.crf'), ExpandConstant('{app}\RES\strings.crf'));
  { T2Fix file cleanup. }
  DeleteFile(ExpandConstant('{app}\dark.gam.dml'));
  DeleteFile(ExpandConstant('{app}\miss1.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss2.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss4.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss5.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss6.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss7.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss8.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss9.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss10.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss11.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss12.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss13.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss14.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss15.mis.dml'));
  DeleteFile(ExpandConstant('{app}\miss16.mis.dml'));
  { Clean any items leftover from old installations. }
  if FileExists(ExpandConstant('{app}\OSM\gamesys.dml')) then
    DelTree(ExpandConstant('{app}\OSM\*'), False, True, True);
  if DirExists(ExpandConstant('{app}\MPOSM')) then
    DelTree(ExpandConstant('{app}\MPOSM'), True, True, True);
#ifdef Mods
  DelTree(ExpandConstant('{app}\RES\RESPATCH'), True, True, True);
  DelTree(ExpandConstant('{app}\MISPATCH'), True, True, True);
  DeleteFile(ExpandConstant('{app}\MODS\EP.crf'));
  if DirExists(ExpandConstant('{app}\MODS\t2snd')) then begin
    if not RenameFile(ExpandConstant('{app}\MODS\t2snd'), ExpandConstant('{app}\MODS\NewT2SFX')) then
      DelTree(ExpandConstant('{app}\MODS\t2snd'), True, True, True);
  end;
  if DirExists(ExpandConstant('{app}\subtitles')) then begin
    CreateDir(ExpandConstant('{app}\MODS\Subtitles'));
    if not RenameFile(ExpandConstant('{app}\subtitles'), ExpandConstant('{app}\MODS\Subtitles\subtitles')) then
      DelTree(ExpandConstant('{app}\subtitles'), True, True, True);
  end;
  if DirExists(ExpandConstant('{app}\T2FMDML')) then begin
    if not RenameFile(ExpandConstant('{app}\T2FMDML'), ExpandConstant('{app}\MODS\T2FMDML')) then
      DelTree(ExpandConstant('{app}\T2FMDML'), True, True, True);
  end;
#endif
end;

{ Uninstall components that are not currently selected but are detected in the
  install directory. }
procedure UninstPrevComp();
begin
  SetStatusCaption(CustomMessage('UninstallPrev'));
  if not WizardIsComponentSelected('dromed') and FileExists(ExpandConstant('{app}\DromEd.exe')) then begin
    SetFilenameCaption(CustomMessage('CompDromEd'));
    DeleteFile(ExpandConstant('{app}\DromEd.exe'));
    DeleteFile(ExpandConstant('{app}\DromEd.log'));
    DeleteFile(ExpandConstant('{app}\DromEd.cfg'));
    DeleteFile(ExpandConstant('{app}\menus-sample.cfg'));
    DeleteFile(ExpandConstant('{app}\troubleshooting_editor.txt'));
    DeleteFile(ExpandConstant('{app}\monolog.txt'));
    DeleteFile(ExpandConstant('{app}\darkdlgs.dll'));
    DeleteFile(ExpandConstant('{app}\3DS2E.EXE'));
    DeleteFile(ExpandConstant('{app}\N3ds2e.exe'));
    DeleteFile(ExpandConstant('{app}\BSP.EXE'));
    DeleteFile(ExpandConstant('{app}\CSGMERGE.EXE'));
    DeleteFile(ExpandConstant('{app}\DEFAULT.BND'));
    DeleteFile(ExpandConstant('{app}\KEYBIND.CFG'));
    DeleteFile(ExpandConstant('{app}\LICENSE.TXT'));
    DeleteFile(ExpandConstant('{app}\MENUS.CFG'));
    DeleteFile(ExpandConstant('{app}\darkdlgs.dat'));
    DeleteFile(ExpandConstant('{app}\bsp.bin'));
    DeleteFile(ExpandConstant('{app}\inprog.cow'));
    DeleteFile(ExpandConstant('{app}\loc_hist.hst'));
    DeleteFile(ExpandConstant('{app}\merge000.log'));
    DeleteFile(ExpandConstant('{app}\p_portal.cow'));
    DeleteFile(ExpandConstant('{app}\temp.wr'));
  end;
  if not WizardIsComponentSelected('dromed\toolkit') and DirExists(ExpandConstant('{app}\Tools')) then begin
    SetFilenameCaption(CustomMessage('CompDromEdTK'));
    DeleteFile(ExpandConstant('{app}\Page001.pcx'));
    DeleteFile(ExpandConstant('{app}\editor.crf'));
    DeleteFile(ExpandConstant('{app}\DromEd Basic Readme.txt'));
    DelTree(ExpandConstant('{app}\Cmds'), True, True, True);
    DelTree(ExpandConstant('{app}\Docs'), True, True, True);
    DelTree(ExpandConstant('{app}\Tools'), True, True, True);
    RemoveDir(ExpandConstant('{app}\Schema'));
  end;
#ifdef Mods
  if not WizardIsComponentSelected('osm') and DirExists(ExpandConstant('{app}\OSM')) then begin
    SetFilenameCaption(CustomMessage('CompScripts'));
    DeleteFile(ExpandConstant('{app}\dh2.osl'));
    DelTree(ExpandConstant('{app}\OSM'), True, True, True);
  end;
  if not WizardIsComponentSelected('dmm') and FileExists(ExpandConstant('{app}\dmm.exe')) then begin
    SetFilenameCaption(CustomMessage('CompDMM'));
    DeleteFile(ExpandConstant('{app}\dmm.exe'));
    DeleteFile(ExpandConstant('{app}\dmm.cfg'));
    DeleteFile(ExpandConstant('{app}\dmm.log'));
  end;
  if not WizardIsComponentSelected('mods\thief2fixed') and DirExists(ExpandConstant('{app}\MODS\Thief2 Fixed')) then begin
    SetFilenameCaption(CustomMessage('CompT2F'));
    DelTree(ExpandConstant('{app}\MODS\Thief2 Fixed'), True, True, True);
  end;
  if not WizardIsComponentSelected('mods\carrybody') and DirExists(ExpandConstant('{app}\MODS\CarryBody')) then begin
    SetFilenameCaption(CustomMessage('CompCarryBody'));
    DelTree(ExpandConstant('{app}\MODS\CarryBody'), True, True, True);
  end;
  if not WizardIsComponentSelected('mods\candles') and DirExists(ExpandConstant('{app}\MODS\Candles')) then begin
    SetFilenameCaption(CustomMessage('CompCandles'));
    DelTree(ExpandConstant('{app}\MODS\Candles'), True, True, True);
  end;
  if not WizardIsComponentSelected('mods\ep') and DirExists(ExpandConstant('{app}\MODS\EP')) then begin
    SetFilenameCaption(CustomMessage('CompEP'));
    DelTree(ExpandConstant('{app}\MODS\EP'), True, True, True);
  end;
  if not WizardIsComponentSelected('mods\t2skies') and DirExists(ExpandConstant('{app}\MODS\t2skies')) then begin
    SetFilenameCaption(CustomMessage('CompT2Skies'));
    DelTree(ExpandConstant('{app}\MODS\t2skies'), True, True, True);
  end;
  if not WizardIsComponentSelected('mods\t2water') and DirExists(ExpandConstant('{app}\MODS\t2water')) then begin
    SetFilenameCaption(CustomMessage('T2Water'));
    DelTree(ExpandConstant('{app}\MODS\t2water'), True, True, True);
  end;
  if not WizardIsComponentSelected('mods\t2seep') and DirExists(ExpandConstant('{app}\MODS\NewT2SFX')) then begin
    SetFilenameCaption(CustomMessage('CompSound'));
    DelTree(ExpandConstant('{app}\MODS\NewT2SFX'), True, True, True);
  end;
  if not WizardIsComponentSelected('mods\subtitles') and DirExists(ExpandConstant('{app}\MODS\Subtitles')) then begin
    SetFilenameCaption(CustomMessage('CompSubtitles'));
    DelTree(ExpandConstant('{app}\MODS\Subtitles'), True, True, True);
  end;
  if DirExists(ExpandConstant('{app}\MODS\T2FMDML')) then begin { always remove }
    SetFilenameCaption(CustomMessage('CompT2FMDML'));
    DelTree(ExpandConstant('{app}\MODS\T2FMDML'), True, True, True);
  end;
#endif
  if not WizardIsComponentSelected('multiplayer') and FileExists(ExpandConstant('{app}\Thief2MP.exe')) then begin
    SetFilenameCaption(CustomMessage('CompMP'));
    DeleteFile(ExpandConstant('{app}\Thief2MP.exe'));
    DeleteFile(ExpandConstant('{app}\Thief2MP.log'));
    DeleteFile(ExpandConstant('{app}\dark_net.bnd'));
    DeleteFile(ExpandConstant('{app}\dark_net.cfg'));
    DeleteFile(ExpandConstant('{app}\dark_net.crf'));
    DeleteFile(ExpandConstant('{app}\dark_net.dml'));
    DeleteFile(ExpandConstant('{app}\GlobalServer.zip'));
    DeleteFile(ExpandConstant('{app}\mp_release_notes.txt'));
    DeleteFile(ExpandConstant('{app}\miss16_aux.osm'));
  end;
  if not WizardIsComponentSelected('olddark') and FileExists(ExpandConstant('{app}\ddfix.dll')) then begin
    SetFilenameCaption(CustomMessage('CompLegacy'));
    DeleteFile(ExpandConstant('{app}\thief2_no_ddfix.exe'));
    DeleteFile(ExpandConstant('{app}\thief2_ddfix.exe'));
    DeleteFile(ExpandConstant('{app}\oldfm.exe'));
    DeleteFile(ExpandConstant('{app}\oldfm.cfg'));
    DeleteFile(ExpandConstant('{app}\old.cfg'));
    DeleteFile(ExpandConstant('{app}\oldinst.cfg'));
    DeleteFile(ExpandConstant('{app}\ddfix.dll'));
    DeleteFile(ExpandConstant('{app}\ddfix.ini'));
    DeleteFile(ExpandConstant('{app}\lgvid.ax'));
    DeleteFile(ExpandConstant('{app}\startold.sav'));
    DeleteFile(ExpandConstant('{app}\ddfix 1.3.11 readme.txt'));
    DeleteFile(ExpandConstant('{app}\ddfix README.html'));
    DeleteFile(ExpandConstant('{app}\OldDark_readme.txt'));
    DelTree(ExpandConstant('{app}\OLDSV'), True, True, True);
  end;
  SetFilenameCaption('');
end;

{ Update status caption and check whether game files need to be patched before
  the T2Fix patching process begins. }
procedure BeforePatch();
begin
  SetStatusCaption(CustomMessage('Extracting'));
  if (CompareText(GetMD5OfFile(ExpandConstant('{app}\DARK.GAM')), 'D593B9A25EA320B1F1A3744FB45B5C68') = 0) or 
     (CompareText(GetMD5OfFile(ExpandConstant('{app}\GEN.OSM')), '92AB303703F098E7CA7770F1058F6BCA') = 0) then
    NeedsPatch := True;
  if (CompareText(GetMD5OfFile(ExpandConstant('{app}\DARK.GAM')), '9F510C7ADBE415B287BA6FABF4D5F0EF') <> 0) or
     (CompareText(GetMD5OfFile(ExpandConstant('{app}\GEN.OSM')), '0CC03C984A79DF89B341DFD208C8A362') <> 0) then
    NeedsMisPatch := True;
end;

{ Handle configuration necessary prior to game installation. }
procedure PreGameConfig();
begin
  { Hide the progress bar. }
  WizardForm.ProgressGauge.Visible := False;
  { Pre-configuration. }
  CleanUp;
  UninstPrevComp;
  { Update external media path if applicable. }
  if FileExists(CD + '\THIEF2\RES\fam.crf') then begin
    CD := CD + '\THIEF2';
    StringChangeEx(CD, ':\\THIEF2', ':\THIEF2', True);
  end;
  { Update status caption if the game is to be installed. }
  if InstGame.Checked then
    SetStatusCaption(CustomMessage('T2Install'));
  { Show the progress bar and set to marquee style. }
  WizardForm.ProgressGauge.Visible := True;
  WizardForm.ProgressGauge.Style := npbstMarquee;
end;

{ Handle configuration necessary after game installation. }
procedure GameConfig();
begin
  SetStatusCaption(CustomMessage('ConfigureGame'));
  { Exit setup if required files could not be located after install despite
    having passed prior to installation. }
  if InstGame.Checked and (not FileExists(ExpandConstant('{app}\Thief2.exe')) or not FileExists(CD + '\DARK.GAM') or not FileExists(CD + '\GEN.OSM')) then begin
    SuppressibleMsgBox(CustomMessage('T2MissingFiles'), mbError, MB_OK, IDOK);
    ImmediateFClose;
    Exit;
  end;
  { Post-configuration. }
  SetLang;
  ApplyPatch;
  { Set the progress bar style to its normal style. }
  WizardForm.ProgressGauge.Style := npbstNormal;
  SetStatusCaption(CustomMessage('InstallComponents'));
end;

{ Check for a single resource CRF. }
procedure CheckCRF(CRF: String; var MCRFs: String; var Found: Boolean);
begin
  if not FileExists(ExpandConstant('{app}\') + CRF) and not FileExists(ExpandConstant('{app}\RES\') + CRF) then begin
    MCRFs := MCRFs + #13#10 + '-' + CRF;
    Found := False;
  end;
end;

{ Check for game resources
  Return false and show warning if check fails }
function CheckResources(): Boolean;
var
  MCRFs: String;
begin
  Result := True;
  MCRFs := '';
  CheckCRF('bitmap.crf', MCRFs, Result);
  CheckCRF('books.crf', MCRFs, Result);
  CheckCRF('camera.crf', MCRFs, Result);
  CheckCRF('default.crf', MCRFs, Result);
  CheckCRF('editor.crf', MCRFs, Result);
  CheckCRF('fam.crf', MCRFs, Result);
  CheckCRF('intrface.crf', MCRFs, Result);
  CheckCRF('mesh.crf', MCRFs, Result);
  CheckCRF('motions.crf', MCRFs, Result);
  CheckCRF('obj.crf', MCRFs, Result);
  CheckCRF('pal.crf', MCRFs, Result);
  CheckCRF('snd.crf', MCRFs, Result);
  CheckCRF('song.crf', MCRFs, Result);
  CheckCRF('strings.crf', MCRFs, Result);
  if not Result then
    SuppressibleMsgBox(CustomMessage('CRFNotFound') + #13#10 + MCRFs + #13#10 + #13#10 +
      CustomMessage('CRFNotFoundNotify'), mbError, MB_OK, IDOK);
end;

{ Handle checks necessary when moving to the next page. }
function NextButtonClick(PageID: Integer): Boolean;
begin
  Result := True;
  if (PageID = wpSelectDir) then begin
    { Handle moving from the Select Directory page when the external media
      checkbox is selected. }
    if InstGame.Checked then begin
      if not DirExists(ExpandConstant('{app}')) then begin
        if InitialPage or (SuppressibleMsgBox(ExpandConstant('{app}') + #13#10#13#10 + CustomMessage('NoDirExist'), mbConfirmation, MB_YESNO, IDYES) = IDYES) then begin
          if not ForceDirectories(ExpandConstant('{app}')) then begin
            Result := False;
            if not IsAdmin and Elevate then
              Exit;
            SuppressibleMsgBox(CustomMessage('NoDirMake'), mbError, MB_OK, IDOK);
            Exit;
          end;
        end else begin
          Result := False;
          Exit;
        end;
        if InitialPage then begin
          Result := False;
          Exit;
        end;
      end;
      if BrowseForFolder(CustomMessage('T2InstallSelect'), CD, False) then begin
        if FileExists(CD + '\THIEF2\RES\fam.crf') then begin
          CD := CD + '\THIEF2';
          StringChangeEx(CD, ':\\', ':\', True);
        end;
        if not FileExists(CD + '\RES\fam.crf') then begin
          SuppressibleMsgBox(CustomMessage('T2InstallFailed2'), mbError, MB_OK, IDOK);
          Result := False;
          Exit;
        end;
        if (CompareText(CD, ExpandConstant('{app}')) = 0) then begin
          SuppressibleMsgBox(CustomMessage('T2InstallSameDir2'), mbError, MB_OK, IDOK);
          Result := False;
          Exit;
        end;
      end else begin
        Result := False;
        Exit;
      end;
    { And when the checkbox is NOT selected. }
    end else begin
      CD := '';
      { 'Thief2.exe', 'dark.gam', and 'gen.osm' are required for recognizing the
        install. }
      if not FileExists(ExpandConstant('{app}\thief2.exe')) or not FileExists(ExpandConstant('{app}\dark.gam')) or not FileExists(ExpandConstant('{app}\gen.osm')) then begin
        SuppressibleMsgBox(CustomMessage('T2Invalid'), mbError, MB_OK, IDOK);
        Result := False;
        Exit;
      end;
      { Check the resources and prevent moving on if the check fails. }
      if not CheckResources() then begin
        Result := False;
        Exit;
      end;
    end;
    { Display a warning if the current install directory is 'Program Files' or
      'Program Files (x86)'. }
    if (WinVer >= $06000000) and not InitialPage and ((Pos(ExpandConstant('{pf32}'), ExpandConstant('{app}')) <> 0) or (IsWin64 and (Pos(ExpandConstant('{pf64}'), ExpandConstant('{app}')) <> 0))) and
       (SuppressibleMsgBox(CustomMessage('T2InvalidProtected'), mbError, MB_YESNO, IDYES) = IDNO) then begin
      Result := False;
      Exit;
    end;
    { Either display an error or elevate the installer if the selected directory
      is not writable. }
    if DirExists(ExpandConstant('{app}')) and not HaveDirWriteAccess then begin
      Result := False;
      { Ask to elevate the installer. }
      if not IsAdmin and Elevate then
        Exit;
      SuppressibleMsgBox(CustomMessage('NoDirWrite'), mbError, MB_OK, IDOK);
      Exit;
    end;
  end else if (PageID = wpReady) then begin
    { Display error if the external media checkbox was selected while moving
      from the Ready page and 'fam.crf' could not be located. }
    if InstGame.Checked then begin
      if not FileExists(CD + '\THIEF2\RES\fam.crf') and not FileExists(CD + '\RES\fam.crf') then begin
        CD := '';
        SuppressibleMsgBox(CustomMessage('T2InstallNoMedia'), mbError, MB_OK, IDOK);
        Result := False;
        Exit;
      end;
    { Or if the other required files could not be located. }
    end else begin
      if not FileExists(ExpandConstant('{app}\thief2.exe')) or not FileExists(ExpandConstant('{app}\dark.gam')) or not FileExists(ExpandConstant('{app}\gen.osm')) then begin
        SuppressibleMsgBox(CustomMessage('T2Invalid2'), mbError, MB_OK, IDOK);
        Result := False;
        Exit;
      end;
    end;
  end;
end;

{ When the cancel button is selected, either present a confirmation dialog or
  exit setup immediately if ImmediateExit is set. }
procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  Confirm := not ImmediateExit;
end;

{ Handle tasks to be executed when the wizard page has changed. }
procedure CurPageChanged(CurPageID: Integer);
var
  I: Integer;
begin
  if PrevCompBut.Visible and (CurPageID <> wpSelectComponents) and not InitialPage then begin
    PrevCompBut.Visible := False;
    PrevCompBut.Enabled := False;
  end;
  if (CurPageID = wpSelectComponents) then begin
    PrevCompBut.Visible := True;
    PrevCompBut.Enabled := True;
  end else if (CurPageID = wpSelectTasks) then begin
    { Set the initial state of the selected Tasks. }
    SetArrayLength(TasksState, WizardForm.TasksList.Items.Count);
    for I := 0 to WizardForm.TasksList.Items.Count - 1 do
      TasksState[I] := WizardForm.TasksList.State[I];
    { Disable video presets if nomodifycfg is checked. }
    if WizardIsTaskSelected('nomodifycfg') then begin
      WizardForm.TasksList.ItemEnabled[1] := False;
      WizardForm.TasksList.ItemEnabled[2] := False;
      WizardForm.TasksList.ItemEnabled[3] := False;
      WizardForm.TasksList.Invalidate;
    end;
    { Enable the eleventh advanced option if DromEd selected. }
    if WizardIsComponentSelected('dromed') then begin
      AdvOp11.Visible := True;
      AdvOp11.Enabled := True;
    end else begin
      AdvOp11.Visible := False;
      AdvOp11.Enabled := False;
    end;
#ifdef Mods
    { Enable the twelfth advanced option if the fixed missions are selected. }
    if WizardIsComponentSelected('mods\thief2fixed') then begin
      AdvOp12.Visible := True;
      AdvOp12.Enabled := True;
    end else begin
      AdvOp12.Visible := False;
      AdvOp12.Enabled := False;
    end;
#endif
  end else if (CurPageID = wpWelcome) and InitialPage then begin
    { Skip the info pages if the 'skiptocomp' parameter was specified. }
    if Uppercase(ExpandConstant('{param:skiptocomp|FALSE}')) = 'TRUE' then begin
      WizardForm.NextButton.OnClick(nil);
      WizardForm.NextButton.OnClick(nil);
      WizardForm.NextButton.OnClick(nil);
    end;
    InitialPage := False;
  end;
end;

#ifndef IS5
type
  TTimerProc = procedure(H: LongWord; Msg: LongWord; IdEvent: LongWord; Time: LongWord);
function GetCursorPos(var lpPoint: TPoint): BOOL;
  external 'GetCursorPos@user32.dll stdcall';
function SetTimer(hWnd: longword; nIDEvent, uElapse: LongWord; lpTimerFunc: LongWord): LongWord;
  external 'SetTimer@user32.dll stdcall';
function ScreenToClient(hWnd: HWND; var lpPoint: TPoint): BOOL;
  external 'ScreenToClient@user32.dll stdcall';
function ListBox_GetItemRect(
  const hWnd: HWND; const Msg: Integer; Index: LongInt; var Rect: TRect): LongInt;
  external 'SendMessageW@user32.dll stdcall';  
const
  LB_GETITEMRECT = $0198;
  LB_GETTOPINDEX = $018E;

{ Determine if the specified point is located inside the specified rect. }
function PointInRect(const Rect: TRect; const Point: TPoint): Boolean;
begin
  Result := (Point.X >= Rect.Left) and (Point.X <= Rect.Right) and (Point.Y >= Rect.Top) and (Point.Y <= Rect.Bottom);
end;

{ Get the list box item at the specified point. }
function ListBoxItemAtPos(ListBox: TCustomListBox; Pos: TPoint): Integer;
var
  Count: Integer;
  ItemRect: TRect;
begin
  Result := SendMessage(ListBox.Handle, LB_GETTOPINDEX, 0, 0);
  Count := ListBox.Items.Count;
  while (Result < Count) do begin
    ListBox_GetItemRect(ListBox.Handle, LB_GETITEMRECT, Result, ItemRect);
    if PointInRect(ItemRect, Pos) then
      Exit;
    Inc(Result);
  end;
  Result := -1;
end;

{ Show default description. }
procedure NoCompHover();
begin
  if (CompLabel.Font.Color <> clGrayText) then
    CompLabel.Font.Color := clGrayText;
  CompDesc := CustomMessage('CompNoneDesc');
end;
#endif

{ Change the component description. }
procedure HoverComponentChanged(I: Integer);
begin
#ifndef IS5
  if (I <> -1) and (CompLabel.Font.Color <> clWindowText) then
    CompLabel.Font.Color := clWindowText;
#endif
  case I of
    0: CompDesc := CustomMessage('CompNewDarkDesc');
    1: CompDesc := CustomMessage('CompDromEdDesc');
    2: CompDesc := CustomMessage('CompDromEdTKDesc');
#ifdef Mods
    3: CompDesc := CustomMessage('CompScriptsDesc');
    4: CompDesc := CustomMessage('CompDMMDesc');
    5: CompDesc := CustomMessage('CompModsDesc');
    6: CompDesc := CustomMessage('CompT2FDesc');
    7: CompDesc := CustomMessage('CompCarryBodyDesc');
    8: CompDesc := CustomMessage('CompCandlesDesc');
    9: CompDesc := CustomMessage('CompT2SkiesDesc');
    10: CompDesc := CustomMessage('CompT2WaterDesc');
    11: CompDesc := CustomMessage('CompEPDesc');
    12: CompDesc := CustomMessage('CompSoundDesc');
    13: CompDesc := CustomMessage('CompSubtitlesDesc');
    14: CompDesc := CustomMessage('CompT2FMDMLDesc');
    15: CompDesc := 
#else
    3: CompDesc :=
#endif
      CustomMessage('CompMPDesc');
#ifdef Mods
    16: CompDesc :=
#else
    4: CompDesc :=
#endif
      CustomMessage('CompLegacyDesc');
#ifndef IS5
  else
    NoCompHover;
#endif
  end;
  CompLabel.Caption := CompDesc;
end;

#ifndef IS5
{ Implement component descriptions based on which component the mouse is hovered
  over. }
procedure HoverTimerProc(H: LongWord; Msg: LongWord; IdEvent: LongWord; Time: LongWord);
var
  P: TPoint; 
  I: Integer;
begin
  { Only get the cursor location and component index if a control on the
    components page is selected. }
  if (WizardForm.CurPageID = wpSelectComponents)
    and (WizardForm.ComponentsList.Focused or WizardForm.CancelButton.Focused
      or WizardForm.NextButton.Focused or WizardForm.BackButton.Focused
      or PrevCompBut.Focused) then begin
    GetCursorPos(P);
    ScreenToClient(WizardForm.ComponentsList.Handle, P);
    I := ListBoxItemAtPos(WizardForm.ComponentsList, P);
    if (I <> LastHoverIndex) then begin
      HoverComponentChanged(I);
      if not CompHovering then
        CompHovering := True;
      LastHoverIndex := I;
    end;
  { Otherwise nullify the component index. }
  end else if CompHovering and (LastHoverIndex <> -1) then begin
    LastHoverIndex := -1;
    NoCompHover;
    CompLabel.Caption := CompDesc;
  end;
end;
#endif

{ Decode OGG files to WAV. }
#ifdef Mods
procedure OggDecode();
begin
  SetFilenameCaption(ExpandConstant(ChangeFileExt(CurrentFilename(), '.wav')));
  Execute(ExpandConstant('"{tmp}\oggdec.exe"'), '"' + ExpandConstant(CurrentFilename()) + '"');
  if FileExists(ExpandConstant(ChangeFileExt(CurrentFilename(), '.wav'))) then
    DeleteFile(ExpandConstant(CurrentFilename()));
end;
#endif

function GetSystemMetrics (nIndex: Integer): Integer;
  external 'GetSystemMetrics@User32.dll stdcall setuponly';
Const
  SM_CXSCREEN = 0;
  SM_CYSCREEN = 1;

{ Set general configuration options. }
procedure ConfigureGeneral();
var
  X: Integer;
  Y: Integer;
  A: AnsiString;
  U: String;
begin
  { Set the default game resolution to the current display resolution. }
  X := GetSystemMetrics(SM_CXSCREEN);
  Y := GetSystemMetrics(SM_CYSCREEN);
  if (X >= 640) and (Y >= 480) then begin
    LoadStringFromFile(ExpandConstant('{app}\cam.cfg'), A);
    U := A;
    if (Pos('game_screen_size', U) = 0) then
      SaveStringToFile(ExpandConstant('{app}\cam.cfg'), 'game_screen_size ' + IntToStr(X) + ' ' + IntToStr(Y) + #13#10, True);
  end;
  { Enable DromEd hardware rendering if chosen. }
  if WizardIsComponentSelected('dromed') and AdvOp11.Enabled and AdvOp11.Checked then begin
    LoadStringFromFile(ExpandConstant('{app}\DromEd.cfg'), A);
    U := A;
    StringChangeEx(U, 'edit_screen_depth 16' + #13#10, ';edit_screen_depth 16' + #13#10, True);
    StringChangeEx(U, ';editor_disable_gdi' + #13#10, 'editor_disable_gdi' + #13#10, True);
    StringChangeEx(U, ';edit_screen_depth 32' + #13#10, 'edit_screen_depth 32' + #13#10, True);
    A := U;
    SaveStringToFile(ExpandConstant('{app}\DromEd.cfg'), A, False);
  end;
end;

#ifdef Mods
{ Check and remember the options set in cam_mod.ini. }
procedure CheckModIni();
var
  A: AnsiString;
  U: String;
begin
  if FileExists(ExpandConstant('{app}\cam_mod.ini')) then begin
    LoadStringFromFile(ExpandConstant('{app}\cam_mod.ini'), A);
    U := A;
    SetArrayLength(ModIniSettings, 5);
    ModIniSettings[0] := GetIniSetting(U, 'fm ', True);
    if (Length(ModIniSettings[0]) = 0) then
      ModIniSettings[0] := GetIniSetting(U, 'fm', False);
    ModIniSettings[1] := GetIniSetting(U, 'fm_path ', True);
    ModIniSettings[2] := GetIniSetting(U, 'fm_movie_dir ', True);
    ModIniSettings[3] := GetIniSetting(U, 'fm_selector ', True);
    ModIniSettings[4] := GetIniSetting(U, 'no_unload_fmsel', False);
  end;
end;

{ Set the options and mod paths in cam_mod.ini. }
procedure ConfigureMods();
var
  A: AnsiString;
  U: String;
  Mods: String;
begin
  LoadStringFromFile(ExpandConstant('{app}\cam_mod.ini'), A);
  U := A;
  if (GetArrayLength(ModIniSettings) = 5) then begin
    if (Length(ModIniSettings[0]) <> 0) then begin
      if (Length(ModIniSettings[0]) > 2) then
        StringChangeEx(U, ';fm TheDarkMansion' + #13#10, ModIniSettings[0] + #13#10, True)
      else
        StringChangeEx(U, ';fm' + #13#10, ModIniSettings[0] + #13#10, True);
    end;
    if (Length(ModIniSettings[1]) <> 0) then
      StringChangeEx(U, ';fm_path .\FMs' + #13#10, ModIniSettings[1] + #13#10, True);
    if (Length(ModIniSettings[2]) <> 0) then
      StringChangeEx(U, ';fm_movie_dir Movies' + #13#10, ModIniSettings[2] + #13#10, True);
    if (Length(ModIniSettings[3]) <> 0) then
      StringChangeEx(U, ';fm_selector fmsel.dll' + #13#10, ModIniSettings[3] + #13#10, True);
    if (Length(ModIniSettings[4]) <> 0) then
      StringChangeEx(U, ';no_unload_fmsel' + #13#10, ModIniSettings[4] + #13#10, True);
  end;
  Mods := '';
  if WizardIsComponentSelected('mods\candles') then
    AddPath(Mods, '.\MODS\Candles');
  if WizardIsComponentSelected('mods\carrybody') then
    AddPath(Mods, '.\MODS\CarryBody');
  if WizardIsComponentSelected('mods\t2water') then
    AddPath(Mods, '.\MODS\t2water');
  if WizardIsComponentSelected('mods\t2skies') then
    AddPath(Mods, '.\MODS\t2skies');
  if WizardIsComponentSelected('mods\t2seep') then
    AddPath(Mods, '.\MODS\NewT2SFX');
  if WizardIsComponentSelected('mods\ep') then
    AddPath(Mods, '.\MODS\EP');
  if WizardIsComponentSelected('mods\thief2fixed') then
    AddPath(Mods, '.\MODS\Thief2 Fixed');
  if WizardIsComponentSelected('mods\subtitles') then
    AddPath(Mods, '.\MODS\Subtitles');
  if WizardIsComponentSelected('mods\fmdml') then
    AddPath(Mods, '.\MODS\T2FMDML');
  if WizardIsComponentSelected('osm') then
    Insert('uber_mod_path .\OSM' + #13#10, U, Pos(';uber_mod_path mods\UpToDateOSMs+MyGemMod' + #13#10, U)+43);
  if (Length(Mods) <> 0) then
    Insert('mod_path ' + Mods + #13#10, U, Pos(';mod_path MyBowMod+.\TexturePack' + #13#10, U)+34);
  A := U;
  SaveStringToFile(ExpandConstant('{app}\cam_mod.ini'), A, False);
  { Enable the improved meshes that come with Thief 2 Fixed if specified. }
  if WizardIsComponentSelected('mods\thief2fixed') and AdvOp12.Enabled and AdvOp12.Checked then begin
    DeleteFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\blacjack.bin'));
    DeleteFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\txt16\BLACJAC2.png'));
    DeleteFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\txt16\BLACJAC4.png'));
    DeleteFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\txt16\hiltsx.tga'));
    RenameFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\Disabled\blacjack.bin'), ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\blacjack.bin'));
    RenameFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\txt16\Disabled\BLACJAC4.png'), ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\txt16\BLACJAC4.png'));
    RenameFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\txt16\Disabled\hiltsx.tga'), ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\txt16\hiltsx.tga'));
    DelTree(ExpandConstant('{app}\MODS\Thief2 Fixed\Obj\Disabled'), True, True, True);
    DeleteFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\bjachand.bin'));
    DeleteFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\txt16\bjhand.tga'));
    DeleteFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\txt16\hiltsx.tga'));
    DeleteFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\txt16\swhand.tga'));
    RenameFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\Disabled\bjachand.bin'), ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\bjachand.bin'));
    RenameFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\txt16\Disabled\bjhand.tga'), ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\txt16\bjhand.tga'));
    RenameFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\txt16\Disabled\Hiltsx.tga'), ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\txt16\Hiltsx.tga'));
    RenameFile(ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\txt16\Disabled\swhand.tga'), ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\txt16\swhand.tga'));
    DelTree(ExpandConstant('{app}\MODS\Thief2 Fixed\Mesh\Disabled'), True, True, True);
  end;
end;
#endif

{ Configure settings in cam_ext.cfg. }
procedure ConfigureVideo();
var
  A: AnsiString;
  U: String;
begin
  LoadStringFromFile(ExpandConstant('{app}\cam_ext.cfg'), A);
  U := A;
  if AdvOp1.Checked then
    StringChangeEx(U, ';d3d_disp_sw_cc' + #13#10, 'd3d_disp_sw_cc' + #13#10, True);
  if AdvOp2.Checked then
    StringChangeEx(U, ';force_windowed' + #13#10, 'force_windowed' + #13#10, True);
  if not AdvOp3.Checked then
    StringChangeEx(U, ';vsync_mode 0' + #13#10, 'vsync_mode 0' + #13#10, True);
  if AdvOp4.Checked then begin
    StringChangeEx(U, ';multisampletype 8' + #13#10, 'multisampletype 8' + #13#10, True);
    StringChangeEx(U, ';d3d_disp_enable_atoc 1' + #13#10, 'd3d_disp_enable_atoc 1' + #13#10, True);
  end;
  if AdvOp5.Checked then
    StringChangeEx(U, ';postprocess 1' + #13#10, 'postprocess 1' + #13#10, True);
  if AdvOp6.Checked then
    StringChangeEx(U, ';d3d_disp_enable_hdr' + #13#10, 'd3d_disp_enable_hdr' + #13#10, True);
  if AdvOp7.Checked then
    StringChangeEx(U, ';new_mantle' + #13#10, 'new_mantle' + #13#10, True);
  A := U;
  SaveStringToFile(ExpandConstant('{app}\cam_ext.cfg'), A, False);
  if AdvOp13.Checked then
    SaveStringToFile(ExpandConstant('{app}\cam_ext.cfg'), #13#10 +
      '; prevent camera jitter when crossing portals' + #13#10 +
      'small_portal_repel' + #13#10, True);
#ifdef Mods
  { Configure subtitles if chosen. }
  if WizardIsComponentSelected('mods\subtitles') then
    SaveStringToFile(ExpandConstant('{app}\cam_ext.cfg'), #13#10 +
      '; enable and configure subtitles' + #13#10 + 
      'enable_subtitles' + #13#10 +
      'subtitles_bg_color 0 0 0 0' + #13#10 +
      'movsubtitles_bg_color 0 0 0 0' + #13#10, True);
#endif
end;

{ Change the component description if the selected component changes. }
procedure ComponentsClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to WizardForm.ComponentsList.Items.Count - 1 do begin
    if WizardForm.ComponentsList.Selected[I] then begin
      HoverComponentChanged(I);
#ifndef IS5
      CompHovering := False;
#endif
    end;
  end;
end;

#ifdef Mods
{ Ensure components that rely on others cannot be chosen if their dependency is
  not currently selected. }
procedure ComponentsClickCheck(Sender: TObject);
var
  Invalidate: Boolean;
begin
  OnCompClickOrig(Sender);
  Invalidate := False;
  { Enable T2FMDML if the scripts are selected. }
  if WizardIsComponentSelected('osm') then begin
    if not WizardForm.ComponentsList.ItemEnabled[14] then begin
      WizardForm.ComponentsList.ItemEnabled[14] := True;
      Invalidate := True;
    end;
  { Disable it otherwise. }
  end else begin
    WizardForm.ComponentsList.CheckItem(14, coUncheck);
    if WizardForm.ComponentsList.ItemEnabled[14] then begin
      WizardForm.ComponentsList.ItemEnabled[14] := False;
      Invalidate := True;
    end;
  end;
  { Enable the Interactive Candles if the scripts and the fixed missions are
    selected. }
  if WizardIsComponentSelected('osm') and WizardIsComponentSelected('mods\thief2fixed') then begin
    if not WizardForm.ComponentsList.ItemEnabled[8] then begin
      WizardForm.ComponentsList.ItemEnabled[8] := True;
      { Select the Interactive Candles if the mods category was checked. }
      if (TNewCheckListBox(Sender).ItemIndex = 5) and (WizardForm.ComponentsList.State[5] = cbGrayed) then
        WizardForm.ComponentsList.CheckItem(8, coCheck);
      Invalidate := True;
    end;
  { Disable them otherwise. }
  end else begin
    WizardForm.ComponentsList.CheckItem(8, coUncheck);
    if WizardForm.ComponentsList.ItemEnabled[8] then begin
      WizardForm.ComponentsList.ItemEnabled[8] := False;
      Invalidate := True;
    end;
  end;
  { Redraw the components list if required. }
  if Invalidate then
    WizardForm.ComponentsList.Invalidate;
end;
#endif

{ Handle modifying advanced options pertaining to video settings when a video
  preset is chosen. }
procedure TasksClickCheck(Sender: TObject);
var
  I: Integer;
begin
  if WizardIsTaskSelected('nomodifycfg') and (TasksState[4] <> WizardForm.TasksList.State[4]) then begin
    WizardForm.TasksList.CheckItem(3, coCheck);
    WizardForm.TasksList.ItemEnabled[1] := False;
    WizardForm.TasksList.ItemEnabled[2] := False;
    WizardForm.TasksList.ItemEnabled[3] := False;
    WizardForm.TasksList.Invalidate;
    AdvOp1.Enabled := False;
    AdvOp2.Enabled := False;
    AdvOp3.Enabled := False;
    AdvOp4.Enabled := False;
    AdvOp5.Enabled := False;
    AdvOp6.Enabled := False;
    AdvOp7.Enabled := False;
    AdvOp13.Enabled := False;
  end else if not WizardIsTaskSelected('nomodifycfg') and (TasksState[4] <> WizardForm.TasksList.State[4]) then begin
    WizardForm.TasksList.ItemEnabled[1] := True;
    WizardForm.TasksList.ItemEnabled[2] := True;
    WizardForm.TasksList.ItemEnabled[3] := True;
    WizardForm.TasksList.Invalidate;
    AdvOp1.Enabled := True;
    AdvOp2.Enabled := True;
    AdvOp3.Enabled := True;
    AdvOp4.Enabled := True;
    AdvOp5.Enabled := True;
    AdvOp6.Enabled := True;
    AdvOp7.Enabled := True;
    AdvOp13.Enabled := True;
  end;
  if WizardIsTaskSelected('vprehigh') and (TasksState[1] <> WizardForm.TasksList.State[1]) then begin
    AdvOp1.Checked := True;
    AdvOp2.Checked := False;
    AdvOp3.Checked := True;
    AdvOp4.Checked := True;
    AdvOp5.Checked := True;
    AdvOp6.Checked := True;
    AdvOp13.Checked := True;
  end else if WizardIsTaskSelected('vpremed') and (TasksState[2] <> WizardForm.TasksList.State[2]) then begin
    AdvOp1.Checked := False;
    AdvOp2.Checked := False;
    AdvOp3.Checked := True;
    AdvOp4.Checked := True;
    AdvOp5.Checked := False;
    AdvOp6.Checked := False;
    AdvOp13.Checked := True;
  end else if WizardIsTaskSelected('vprelow') and (TasksState[3] <> WizardForm.TasksList.State[3]) then begin
    AdvOp1.Checked := False;
    AdvOp2.Checked := False;
    AdvOp3.Checked := True;
    AdvOp4.Checked := False;
    AdvOp5.Checked := False;
    AdvOp6.Checked := False;
    AdvOp13.Checked := True;
  end;
  { Update the state of the selected Tasks. }
  for I := 0 to WizardForm.TasksList.Items.Count - 1 do begin
    if TasksState[I] <> WizardForm.TasksList.State[I] then
      TasksState[I] := WizardForm.TasksList.State[I];
  end;
end;

{ Check and uncheck components based on whether they are already installed. }
procedure PrevCompButClick(Sender: TObject);
begin
  CheckComponent(1, FileExists(ExpandConstant('{app}\DromEd.exe')));
  CheckComponent(2, DirExists(ExpandConstant('{app}\Tools')));
#ifdef Mods
  CheckComponent(3, DirExists(ExpandConstant('{app}\OSM')));
  CheckComponent(4, FileExists(ExpandConstant('{app}\dmm.exe')));
  CheckComponent(6, DirExists(ExpandConstant('{app}\MODS\Thief2 Fixed')));
  CheckComponent(7, DirExists(ExpandConstant('{app}\MODS\CarryBody')));
  CheckComponent(8, DirExists(ExpandConstant('{app}\MODS\Candles')));
  CheckComponent(9, DirExists(ExpandConstant('{app}\MODS\t2skies')));
  CheckComponent(10, DirExists(ExpandConstant('{app}\MODS\t2water')));
  CheckComponent(11, DirExists(ExpandConstant('{app}\MODS\EP')));
  CheckComponent(12, DirExists(ExpandConstant('{app}\MODS\NewT2SFX')));
  CheckComponent(13, DirExists(ExpandConstant('{app}\MODS\Subtitles')));
  CheckComponent(14, DirExists(ExpandConstant('{app}\MODS\T2FMDML')));
#endif
  CheckComponent(
#ifdef Mods
    15,
#else
    3,
#endif
    FileExists(ExpandConstant('{app}\Thief2MP.exe')));
  CheckComponent(
#ifdef Mods
    16,
#else
    4,
#endif
    FileExists(ExpandConstant('{app}\ddfix.dll')));
end;

{ Set up various modifications to the wizard form. }
procedure InitializeWizard();
begin
  { Get Windows version. }
  WinVer := GetWindowsVersion;
  { Set up checkbox for installing the game from an external source. }
  InstGame := TNewCheckBox.Create(WizardForm.SelectDirPage);
  InstGame.Top:= WizardForm.DirEdit.Top + WizardForm.DirEdit.Height + ScaleY(30);
  InstGame.Width := WizardForm.SelectDirPage.Width;
  InstGame.Caption := CustomMessage('T2InstallButton');
  if Uppercase(ExpandConstant('{param:instgame|FALSE}')) = 'TRUE' then
    InstGame.Checked := True
  else
    InstGame.Checked := False;
  InstGame.Parent := WizardForm.SelectDirPage;
#ifndef IS5
  { Set up the component description functionality. }
  SetTimer(0, 0, 5, CreateCallback(@HoverTimerProc));
#endif
  WizardForm.ComponentsList.Width := ScaleX(278);
#ifdef Mods
  WizardForm.SelectComponentsLabel.Height := ScaleY(26);
  WizardForm.ComponentsList.Top := ScaleY(30)
  WizardForm.ComponentsList.Height := ScaleY(206);
#endif
  CompLabel := TLabel.Create(WizardForm);
  CompLabel.Parent := WizardForm.SelectComponentsPage;
  CompLabel.Left := WizardForm.ComponentsList.Width + ScaleX(11);
  CompLabel.Width := WizardForm.SelectComponentsLabel.Width - WizardForm.ComponentsList.Width - ScaleX(14);
#ifdef Mods
  CompLabel.Height := WizardForm.ComponentsList.Height - ScaleY(42);
#else
  CompLabel.Height := WizardForm.ComponentsList.Height;
#endif
  CompLabel.Top := WizardForm.ComponentsList.Top + ScaleY(8);
  CompLabel.AutoSize := False;
  CompLabel.WordWrap := True;
  CompBevel := TBevel.Create(WizardForm);
  CompBevel.Parent := WizardForm.SelectComponentsPage;
  CompBevel.Shape := bsFrame;
  CompBevel.Left := CompLabel.Left - ScaleX(5);
  CompBevel.Top := WizardForm.ComponentsList.Top;
  CompBevel.Width := WizardForm.SelectComponentsLabel.Width - WizardForm.ComponentsList.Width - ScaleX(6);
#ifdef Mods
  CompBevel.Height := WizardForm.ComponentsList.Height - ScaleY(26);
#else
  CompBevel.Height := WizardForm.ComponentsList.Height;
#endif
  BevelCap := TLabel.Create(WizardForm);
  BevelCap.Parent := WizardForm.SelectComponentsPage;
  BevelCap.Left := CompBevel.Left + ScaleX(8);
  BevelCap.Top := CompBevel.Top - ScaleY(6);
  BevelCap.Transparent := False;
  BevelCap.Caption := CustomMessage('ComponentDesc');
  { Set up the 'Restore Previous Setup' button. }
  PrevCompBut := TNewButton.Create(WizardForm);
  PrevCompBut.Caption := CustomMessage('ComponentRestore');
  PrevCompBut.Left := WizardForm.InfoAfterPage.Left + (WizardForm.ClientWidth - (WizardForm.CancelButton.Left + WizardForm.CancelButton.Width));
  PrevCompBut.Top := WizardForm.NextButton.Top;
  PrevCompBut.Height := WizardForm.NextButton.Height;
  PrevCompBut.Width := WizardForm.NextButton.Width * 2;
  PrevCompBut.Parent := WizardForm.NextButton.Parent;
  PrevCompBut.Visible := False;
  PrevCompBut.Enabled := False;
#ifdef IS5
  { Reset the component description to the first item. }
  WizardForm.ComponentsList.Selected[0] := True;
  HoverComponentChanged(0);
#endif
  { Set up the advanced options page. }
  AdvPage := CreateCustomPage(wpSelectTasks, CustomMessage('AdvancedOps'), CustomMessage('AdvancedOpsDesc'));
  AdvVLabel := TLabel.Create(WizardForm);
  AdvVLabel.Parent := AdvPage.Surface;
  AdvVLabel.Width := AdvPage.SurfaceWidth div 2;
  AdvVLabel.Top := ScaleY(0);
  AdvVLabel.Height := ScaleY(17);
  AdvVLabel.Transparent := False;
  AdvVLabel.Caption := CustomMessage('AdvancedVideo');
  AdvGLabel := TLabel.Create(WizardForm);
  AdvGLabel.Parent := AdvPage.Surface;
  AdvGLabel.Left := AdvPage.SurfaceWidth div 2;
  AdvGLabel.Width := AdvPage.SurfaceWidth div 2;
  AdvGLabel.Top := ScaleY(0);
  AdvGLabel.Height := ScaleY(17);
  AdvGLabel.Transparent := False;
  AdvGLabel.Caption := CustomMessage('AdvancedGeneral');
  AdvOp1 := TNewCheckBox.Create(AdvPage);
  AdvOp1.Top:= ScaleY(30);
  AdvOp1.Width := AdvPage.SurfaceWidth div 2;
  AdvOp1.Caption := CustomMessage('AdvancedOp1');
  AdvOp1.Checked := False;
  AdvOp1.Parent := AdvPage.Surface;
  AdvOp2 := TNewCheckBox.Create(AdvPage);
  AdvOp2.Top:= ScaleY(55);
  AdvOp2.Width := AdvPage.SurfaceWidth div 2;
  AdvOp2.Caption := CustomMessage('AdvancedOp2');
  AdvOp2.Checked := False;
  AdvOp2.Parent := AdvPage.Surface;
  AdvOp3 := TNewCheckBox.Create(AdvPage);
  AdvOp3.Top:= ScaleY(80);
  AdvOp3.Width := AdvPage.SurfaceWidth div 2;
  AdvOp3.Caption := CustomMessage('AdvancedOp3');
  AdvOp3.Checked := True;
  AdvOp3.Parent := AdvPage.Surface;
  AdvOp4 := TNewCheckBox.Create(AdvPage);
  AdvOp4.Top:= ScaleY(105);
  AdvOp4.Width := AdvPage.SurfaceWidth div 2;
  AdvOp4.Caption := CustomMessage('AdvancedOp4');
  AdvOp4.Checked := False;
  AdvOp4.Parent := AdvPage.Surface;
  AdvOp5 := TNewCheckBox.Create(AdvPage);
  AdvOp5.Top:= ScaleY(130);
  AdvOp5.Width := AdvPage.SurfaceWidth div 2;
  AdvOp5.Caption := CustomMessage('AdvancedOp5');
  AdvOp5.Checked := False;
  AdvOp5.Parent := AdvPage.Surface;
  AdvOp6 := TNewCheckBox.Create(AdvPage);
  AdvOp6.Top:= ScaleY(155);
  AdvOp6.Width := AdvPage.SurfaceWidth div 2;
  AdvOp6.Caption := CustomMessage('AdvancedOp6');
  AdvOp6.Checked := False;
  AdvOp6.Parent := AdvPage.Surface;
  AdvOp7 := TNewCheckBox.Create(AdvPage);
  AdvOp7.Top:= ScaleY(180);
  AdvOp7.Width := AdvPage.SurfaceWidth div 2;
  AdvOp7.Caption := CustomMessage('AdvancedOp7');
  AdvOp7.Checked := True;
  AdvOp7.Parent := AdvPage.Surface;
  AdvOp13 := TNewCheckBox.Create(AdvPage);
  AdvOp13.Top:= ScaleY(205);
  AdvOp13.Width := AdvPage.SurfaceWidth div 2;
  AdvOp13.Caption := CustomMessage('AdvancedOp13');
  AdvOp13.Checked := True;
  AdvOp13.Parent := AdvPage.Surface;
  AdvOp8 := TNewCheckBox.Create(AdvPage);
  AdvOp8.Top:= ScaleY(30);
  AdvOp8.Left := AdvPage.SurfaceWidth div 2;
  AdvOp8.Width := AdvPage.SurfaceWidth div 2;
  AdvOp8.Caption := CustomMessage('AdvancedOp8');
  AdvOp8.Checked := False;
  AdvOp8.Parent := AdvPage.Surface;
  AdvOp9 := TNewCheckBox.Create(AdvPage);
  AdvOp9.Top:= ScaleY(55);
  AdvOp9.Left := AdvPage.SurfaceWidth div 2;
  AdvOp9.Width := AdvPage.SurfaceWidth div 2;
  AdvOp9.Caption := CustomMessage('AdvancedOp9');
  AdvOp9.Checked := False;
  AdvOp9.Parent := AdvPage.Surface;
  AdvOp10 := TNewCheckBox.Create(AdvPage);
  AdvOp10.Top:= ScaleY(80);
  AdvOp10.Left := AdvPage.SurfaceWidth div 2;
  AdvOp10.Width := AdvPage.SurfaceWidth div 2;
  AdvOp10.Caption := CustomMessage('AdvancedOp10');
  AdvOp10.Checked := False;
  AdvOp10.Parent := AdvPage.Surface;
  AdvOp11 := TNewCheckBox.Create(AdvPage);
  AdvOp11.Top:= ScaleY(105);
  AdvOp11.Left := AdvPage.SurfaceWidth div 2;
  AdvOp11.Width := AdvPage.SurfaceWidth div 2;
  AdvOp11.Caption := CustomMessage('AdvancedOp11');
  AdvOp11.Checked := False;
  AdvOp11.Parent := AdvPage.Surface;
  AdvOp11.Visible := False;
  AdvOp11.Enabled := False;
#ifdef Mods
  AdvOp12 := TNewCheckBox.Create(AdvPage);
  AdvOp12.Top:= ScaleY(130);
  AdvOp12.Left := AdvPage.SurfaceWidth div 2;
  AdvOp12.Width := AdvPage.SurfaceWidth div 2;
  AdvOp12.Caption := CustomMessage('AdvancedOp12');
  AdvOp12.Checked := False;
  AdvOp12.Parent := AdvPage.Surface;
  AdvOp12.Visible := False;
  AdvOp12.Enabled := False;
#endif
#ifndef IS5
  { Set up the anchors on the wizard form components. }
  InstGame.Anchors := [akRight, akLeft, akTop];
  CompLabel.Anchors := [akRight, akTop];
  CompBevel.Anchors := [akRight, akTop];
  BevelCap.Anchors := [akRight, akTop];
  PrevCompBut.Anchors := [akLeft, akBottom];
  AdvVLabel.Anchors := [akLeft, akTop];
  AdvGLabel.Anchors := [akRight, akTop];
  AdvOp1.Anchors := [akLeft, akTop];
  AdvOp2.Anchors := [akLeft, akTop];
  AdvOp3.Anchors := [akLeft, akTop];
  AdvOp4.Anchors := [akLeft, akTop];
  AdvOp5.Anchors := [akLeft, akTop];
  AdvOp6.Anchors := [akLeft, akTop];
  AdvOp7.Anchors := [akLeft, akTop];
  AdvOp8.Anchors := [akRight, akTop];
  AdvOp9.Anchors := [akRight, akTop];
  AdvOp10.Anchors := [akRight, akTop];
  AdvOp11.Anchors := [akRight, akTop];
#ifdef Mods
  AdvOp12.Anchors := [akRight, akTop];
  WizardForm.ComponentsDiskSpaceLabel.Anchors := [akRight, akBottom];
#else
  WizardForm.ComponentsDiskSpaceLabel.Anchors := [akLeft, akBottom];
#endif
  AdvOp13.Anchors := [akLeft, akTop];
#endif
#ifdef Mods
  { Modify default layout for components selection page. }
  WizardForm.ComponentsDiskSpaceLabel.Top := CompBevel.Top + CompBevel.Height + ScaleY(5);
  WizardForm.ComponentsDiskSpaceLabel.Left := WizardForm.ComponentsList.Width + ScaleX(9);
  { Disable selecting Dark Mod Manager if running a Windows version older than
    Vista SP2. }
  if (WinVer < $06000200) then
    WizardForm.ComponentsList.ItemEnabled[4] := False;
  { Interactive Candles and T2FMDML should be disabled by default. }
  WizardForm.ComponentsList.ItemEnabled[8] := False;
  WizardForm.ComponentsList.ItemEnabled[14] := False;
  { Overrides for components selection page events. }
  OnCompClickOrig := WizardForm.ComponentsList.OnClickCheck;
#endif
  WizardForm.ComponentsList.OnClick := @ComponentsClick;
#ifdef Mods
  WizardForm.ComponentsList.OnClickCheck := @ComponentsClickCheck;
#endif
  WizardForm.TasksList.OnClickCheck := @TasksClickCheck;
  PrevCompBut.OnClick := @PrevCompButClick;
  { The wizard form starts on the initial page. }
  InitialPage := True;
end;

{ Update the ready page to show the external directory if chosen. }
function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  S: String;
begin
  S := '';
  S := S + MemoDirInfo + NewLine + NewLine + MemoComponentsInfo + NewLine;
  if WizardIsTaskSelected('nomodifycfg') then
    StringChangeEx(MemoTasksInfo, 'Low Preset' + NewLine + Space + Copy(Space, 1, Length(Space) div 2), '', True);
  if not (MemoTasksInfo = '') then
    S := S + NewLine + MemoTasksInfo + NewLine; 
  if not (CD = '') then
    S := S + NewLine + CustomMessage('T2InstallDirMemo') + NewLine + Space + CD + NewLine;
  Result := S;
end;
