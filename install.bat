@echo off
setlocal

set "ZIP_URL=https://github.com/Muiqy/Elysiumv2.0/releases/download/v2.2/Elysium-v2.2.zip"
set "ZIP_NAME=Elysium-v2.2.zip"
set "SCRIPT_DIR=%~dp0"

cd /d "%SCRIPT_DIR%"

echo Downloading %ZIP_NAME%...
if exist "%ZIP_NAME%" del /f /q "%ZIP_NAME%"

if exist "%SystemRoot%\System32\curl.exe" (
    curl -L --progress-bar -o "%ZIP_NAME%" "%ZIP_URL%"
) else (
    echo curl.exe not found. Trying certutil...
    certutil -urlcache -split -f "%ZIP_URL%" "%ZIP_NAME%"
)

if not exist "%ZIP_NAME%" (
    echo Failed to download %ZIP_NAME%
    pause
    exit /b 1
)

echo Extracting...
if exist "%SystemRoot%\System32\tar.exe" (
    tar -xf "%ZIP_NAME%"
) else (
    echo tar.exe not found. Cannot extract zip.
    pause
    exit /b 1
)
if errorlevel 1 (
    echo Failed to extract %ZIP_NAME%
    pause
    exit /b 1
)

echo Cleaning up...
del /f /q "%ZIP_NAME%"

echo Done.
start "" "%SCRIPT_DIR%elysium-fix.exe"
if not exist "%SCRIPT_DIR%elysium-fix.exe" (
    echo EXE not found after extract.
    pause
    exit /b 1
)

set "SELF=%~f0"
ren "%SELF%" "delete.me"
exit /b
