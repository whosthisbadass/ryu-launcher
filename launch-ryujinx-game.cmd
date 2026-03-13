@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" (
    echo Usage: %~nx0 "ROM_PATH"
    exit /b 1
)

set "BASE_DIR=%~dp0"
if "%BASE_DIR:~-1%"=="\" set "BASE_DIR=%BASE_DIR:~0,-1%"

set "PS_SCRIPT=%BASE_DIR%\launch-ryujinx-game.ps1"
set "EMU_EXE=%BASE_DIR%\Ryujinx.exe"
set "ROM_PATH=%~1"
set "PORTABLE_FOLDER="

for /f "usebackq delims=" %%I in (`powershell -NoProfile -ExecutionPolicy Bypass -File "%PS_SCRIPT%"`) do (
    set "PORTABLE_FOLDER=%%I"
)

if not defined PORTABLE_FOLDER (
    echo Failed to resolve portable folder from PowerShell script.
    exit /b 1
)

set "RUNAS_CMD=\"%EMU_EXE%\" -r \"%PORTABLE_FOLDER%\" \"%ROM_PATH%\""

runas /machine:amd64 /trustlevel:0x20000 "%RUNAS_CMD%"
exit /b %errorlevel%
