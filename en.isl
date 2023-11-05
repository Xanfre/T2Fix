; *** T2Fix English messages ***
;
; This is to be used as a supplement to the official Inno Setup translation
; for the applicable languages.

[Messages]

; *** Application titles
SetupAppTitle=[fname]
SetupWindowTitle=[flongname]

; *** Setup common messages
ExitSetupTitle=Exit [fname]
ExitSetupMessage=Are you sure you want to exit?

; *** "Welcome" wizard page
WelcomeLabel1=Welcome to the [flongname] Wizard
WelcomeLabel2=This will update and install various patches for Thief 2: The Metal Age.%n%nA full and unmodified installation of Thief 2: The Metal Age or the original CDs are required. The English, German, and French localizations are supported. This package is not guaranteed to function with any other installation media.%n%nNote: Many of the changes that are to be made are irreversable; should you decide you want to run the game in its original state, you must create a new installation.

; *** "Select Destination Location" wizard page
SelectDirDesc=Select either the location of your existing Thief 2 installation or the location to which you wish to install the game.
SelectDirLabel3=Setup will install [fname] into the following directory.

; *** "Select Components" wizard page
SelectComponentsLabel2=Select the components you want to install; ensure that the components you do not want to install or those you want to uninstall are cleared. Click Next when you are ready to continue.
ComponentsDiskSpaceGBLabel=Space Required: [gb] GB
ComponentsDiskSpaceMBLabel=Space Required: [mb] MB

; *** "Select Additional Tasks" wizard page
SelectTasksLabel2=Select the additional tasks you would like Setup to perform while installing [fname], then click Next.

; *** "Ready to Install" wizard page
ReadyLabel1=Setup is now ready to begin installing [fname] on your computer.

; *** "Preparing to Install" wizard page
PreparingDesc=Setup is preparing to install [fname] on your computer.

; *** "Installing" wizard page
InstallingLabel=Please wait while Setup installs [fname] on your computer.

; *** "Setup Completed" wizard page
FinishedHeadingLabel=[flongname] Setup Complete
FinishedLabelNoIcons=Setup has finished installing the selected components.
FinishedLabel=Setup has finished installing the selected components. Thief 2 may be launched by selecting the created shortcuts.

; *** T2Fix Custom English Messages

[CustomMessages]

; *** T2Fix custom messages
T2Invalid=A valid Thief 2 install was not detected. Please select a directory in which the game is installed or install the game by checking the box on this page.
NoDirWrite=[fname] cannot write to the specified directory. Please choose a directory to which you have write access.

; ISPP T2Fix

CD2Prompt=Please select the location of your second Thief 2 CD or the location in which its data resides:
T2Install=Installing Thief 2...
T2InstallButton=Install Thief 2 in the above directory from original install media.
T2InstallDirMemo=Install Media Directory:
T2InstallSelect=Please select the location of your first Thief 2 CD or the location in which your Thief 2 install data resides:
T2InstallRemoved=Thief 2 installation media was removed during install. Setup will now exit.
T2InstallNoMedia=Setup cannot locate the installation media. Please return to the directory selection page or exit setup.'
T2InstallFailed=Thief 2 installation data not detected. Please choose the correct location, or select cancel to abort setup.
T2InstallFailed2=Thief 2 installation data not detected. Please choose the correct location or continue without installing the game.
T2InstallSameDir=Installation directory and media location are identical. Please choose different locations or select cancel to abort setup.
T2InstallSameDir2=Installation directory and media location are identical. Please choose different locations.
T2MissingFiles=Critical files could not be installed. Please check your installation media. Setup will now exit.
T2Invalid2=Setup cannot locate the game installation in the previously selected directory. Please return to the directory selection page or exit setup.
T2InvalidProtected=You have selected a protected folder in which to install [fname]. This is not recommended. Would you like to continue anyway?
NoSelectedDir=No directory selected. Abort setup?
LangConfig=Configuring Language...
LangConfigWarn=The Thief 2 language detected is not one of the supported localizations.%nWhile Thief 2 may work without issue, it is advised to confirm that the value of the language field in darkinst.cfg is correct after setup is complete.
LangConfigApply=Configuring Language: Applying
VerConfig=Detecting Version...
PatchConfig=Applying Official Thief 2 Resource Patch
FinishConfig=Finishing Up...
CRFPatching=Patching
CRFNotFound=The following resources could not be located:
CRFNotFoundNotify=Please ensure these resources are present prior to running [fname].
CleanUp=Cleaning up installation directory...
PrepareDir=Preparing installation directory...
UninstallPrev=Uninstalling Components...
Extracting=Extracting...
ExtractingFiles=Extracting Files...
ConfigureGame=Configuring...
InstallComponents=Installing...
NoDirExist=does not exist. Would you like to create the folder now?
NoDirMake=[fname] cannot make the specified folder. Please manually create or choose an existing folder.
ComponentDesc=Description
ComponentRestore=Restore Previous Setup
CompNoneDesc=Position your mouse over a component to view its description.
CompNewDarkDesc=Required files for the NewDark 1.27 patch, which provides much better support for modern hardware.
CompDromEdDesc=The NewDark-patched version of the DromEd mission editor.
CompDromEdTKDesc=A toolkit for DromEd which includes improved menus and various utilities intended to aid in mapping and modding.
CompMPDesc=The latest beta release of the Thief 2 Multiplayer executable. Be warned that this is not in a finished state and everything may not be fully operational.
CompLegacyDesc=Includes the original Thief 2 executables and the ddfix patch. While this will not affect the rest of the installation, it is not recommended for average users.
AdvancedOps=Select Advanced Options
AdvancedOpsDesc=Which advanced options should be set?
AdvancedVideo=Video Configuration:
AdvancedGeneral=General Configuration:
AdvancedOp1=Enable Software Gamma
AdvancedOp2=Force Windowed Mode
AdvancedOp3=Force VSync
AdvancedOp4=Enable Multisampling
AdvancedOp5=Enable Postprocessing
AdvancedOp6=Enable HDR Rendering
AdvancedOp7=Enable New Mantle
AdvancedOp8=Disable Training Scripts
AdvancedOp9=Enable Legacy Gamesys Exploits
AdvancedOp10=Always Install 1.18 Resources
AdvancedOp11=Enable DromEd Hardware Rendering
AdvancedButton=Configuration Options

; *** T2Fix component/task names
CompNewDark=NewDark 1.27
CompDromEd=DromEd 1.27
CompDromEdTK=DromEd Basic Toolkit 1.14
CompMP=Thief 2 Multiplayer
CompLegacy=Legacy Executables
TaskVideo=Video Configuration:
TaskVideoL=Low Preset
TaskVideoM=Medium Preset
TaskVideoH=High Preset
TaskVideoNone=Do not modify existing configuration
TaskInst=Installation Options:
TaskIcon=Desktop Shortcuts:
TaskOALSoft=Install OpenAL Soft
TaskMP3=Install libmp3lame
TaskCleanUp=Clean up install directory
TaskIconThief2=Create a shortcut for Thief 2
TaskIconFMSel=Create a shortcut for the Thief 2 Fan Mission Selector
TaskIconDromEd=Create a shortcut for DromEd
TaskIconMP=Create a shortcut for Thief 2 Multiplayer
IconThief2=Thief 2 The Metal Age
IconFMSel=Thief 2 FMs
IconDromEd=Dromed [Thief 2]
IconMP=Thief 2 Multiplayer

; ISPP Mods

; *** T2Fix Custom English Messages
CompScriptsDesc=Common script modules used in fan missions and mods. Includes NVScript, tnhScript, and the Public Scripts.
CompDMMDesc=An easy-to-use mod manager for NewDark that allows fine control over installed mods and mod priorities. Requires Windows Vista SP2 or newer.
CompModsDesc=Game modifications.
CompT2FDesc=Complete Thief 2 mission and resource patch. Fixes numerous issues present in the original missions and provides updated resources. This is highly recommended.
CompCarryBodyDesc=High-detail models for carried bodies that properly match the AIs.
CompCandlesDesc=Interactive candles that add extinguishable flames to lit candles in the original missions. The common script modules and Thief2 Fixed are required for proper functionality.
CompT2SkiesDesc=Improved dynamic skies.
CompT2WaterDesc=Improved water surfaces.
CompEPDesc=High-definition textures and objects.
CompSoundDesc=Resampled and remastered Thief 2 sound effects.
CompSubtitlesDesc=English subtitles for spoken lines in the original missions.
CompT2FMDMLDesc=A large collection of fixes for known issues in many Thief 2 fan missions. The common script modules are required for proper functionality.
AdvancedOp12=Enable Improved Arm Meshes

; *** T2Fix component/task names
CompScripts=Common Script Modules
CompDMM=Dark Mod Manager
CompMods=Mods
CompT2F=Thief2 Fixed 1.3b
CompCarryBody=Carry Body Mod
CompCandles=Interactive Candles
CompT2Skies=T2 Skies
CompT2Water=T2 Water
CompEP=Thief Enhancement Pack
CompSound=Sound Effects Enhancement Pack
CompSubtitles=English Subtitles
CompT2FMDML=T2FMDML
