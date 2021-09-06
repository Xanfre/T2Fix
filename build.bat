@echo off
call :getIS
if ERRORLEVEL 1 goto failure
call :getResources
if ERRORLEVEL 1 goto failure
echo Building T2Fix...
"%~dp0IS\ISCC" "%~dp0T2Fix.iss"
echo Building T2Fix with mods...
"%~dp0IS\ISCC" /DMods "%~dp0T2Fix.iss"
echo Done.
exit /b 0

:getIS
if exist "%~dp0IS\ISCC.exe" exit /b 0
choice /C YN /M "Inno Setup compiler not detected. Fetch the latest binaries now?"
if ERRORLEVEL 2 exit /b 1
mkdir "%~dp0IS"
curl -L https://github.com/Xanfre/is5src/releases/download/v5.6.1/innosetup-5.6.1-unicode.zip --output "%~dp0IS\innosetup-unicode.zip"
tar -xf "%~dp0IS\innosetup-unicode.zip" -C "%~dp0IS"
del "%~dp0IS\innosetup-unicode.zip"
if not exist "%~dp0IS\ISCC.exe" exit /b 1
exit /b 0

:getResources
if exist "%~dp0Resources" exit /b 0
choice /C YN /M "Resources not found. Fetch them now?"
if ERRORLEVEL 2 exit /b 1
mkdir "%~dp0Resources"
curl https://github.com/Xanfre/T2FixResources/raw/main/T2FixResources127e.zip --location --output "%~dp0Resources\Resources.zip"
tar -xf "%~dp0Resources\Resources.zip" -C "%~dp0Resources"
del "%~dp0Resources\Resources.zip"
if not exist "%~dp0Resources" exit /b 1
exit /b 0

:failure
echo Build cannot continue.
exit /b 1
