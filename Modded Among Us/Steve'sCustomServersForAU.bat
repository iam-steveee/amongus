@echo off
setlocal EnableExtensions

title Steve's Custom Servers for Among Us

set "SOURCE=https://iam-steveee.github.io/moddedau/regioninfo.json"
set "TARGET=%LOCALAPPDATA%\..\LocalLow\Innersloth\Among Us\regionInfo.json"
set "TARGETDIR=%LOCALAPPDATA%\..\LocalLow\Innersloth\Among Us"
set "TEMPFILE=%TEMP%\Steve_regionInfo_%RANDOM%_%RANDOM%.tmp"

echo ====================================================
echo         Steve's Custom Servers for Among Us
echo ====================================================
echo.
echo Installing custom Among Us server regions...
echo.
call :watermark

echo.

if not exist "%TARGETDIR%\" (
    mkdir "%TARGETDIR%" >nul 2>&1
)

if not exist "%TARGETDIR%\" (
    echo ERROR: regionInfo.json was not created.
    echo Nothing was installed.
    echo.
    call :watermark
    echo.
    pause
    endlocal
    exit /b 1
)

where curl.exe >nul 2>&1
if errorlevel 1 (
    echo ERROR: curl is not available on this Windows installation.
    echo Windows 10/11 normally includes curl.
    echo Nothing was installed.
    echo.
    call :watermark
    echo.
    pause
    endlocal
    exit /b 1
)

curl.exe -L --fail --silent --show-error --retry 3 --retry-delay 1 --connect-timeout 15 "%SOURCE%" -o "%TEMPFILE%"
if errorlevel 1 (
    if exist "%TEMPFILE%" del /q "%TEMPFILE%" >nul 2>&1
    echo ERROR: Could not download regionInfo.json.
    echo Nothing was installed.
    echo.
    call :watermark
    echo.
    pause
    endlocal
    exit /b 1
)

if not exist "%TEMPFILE%" (
    echo ERROR: regionInfo.json was not created.
    echo.
    call :watermark
    echo.
    pause
    endlocal
    exit /b 1
)

for %%A in ("%TEMPFILE%") do if %%~zA LEQ 0 (
    del /q "%TEMPFILE%" >nul 2>&1
    echo ERROR: Downloaded file is empty.
    echo.
    call :watermark
    echo.
    pause
    endlocal
    exit /b 1
)

copy /Y "%TEMPFILE%" "%TARGET%" >nul 2>&1
if errorlevel 1 (
    del /q "%TEMPFILE%" >nul 2>&1
    echo ERROR: regionInfo.json was not created.
    echo.
    call :watermark
    echo.
    pause
    endlocal
    exit /b 1
)

del /q "%TEMPFILE%" >nul 2>&1

if not exist "%TARGET%" (
    echo ERROR: regionInfo.json was not created.
    echo.
    call :watermark
    echo.
    pause
    endlocal
    exit /b 1
)

for %%A in ("%TARGET%") do if %%~zA LEQ 0 (
    echo ERROR: Downloaded file is empty.
    echo.
    call :watermark
    echo.
    pause
    endlocal
    exit /b 1
)

echo ====================================================
echo Installation completed successfully.
echo ====================================================
echo.
echo Installed file:
echo %TARGET%
echo.
echo Close and reopen Among Us if it was already running.
echo.
call :watermark

echo.
pause
endlocal
exit /b 0

:watermark
echo IMPORTANT:
echo - This batch file only installs the custom server
echo   configuration on your device.
echo - The servers listed in this file are NOT owned,
echo   operated, or hosted by Steve.
echo - Steve is not responsible for the operation,
echo   availability, rules, or moderation of those servers.
echo.
echo Hi, I am Steve. This batch file was made by me to
echo make installing custom servers easier.
echo.
echo The servers themselves are not owned by Steve.
echo I only created this batch file and the related
echo installation system.
echo.
echo ====================================================
echo                     Made by Steve
echo ====================================================
echo.
echo Discord Username: iam._.steve
echo Website: https://iam-steveee.github.io/moddedau
echo.
echo ====================================================
exit /b 0
