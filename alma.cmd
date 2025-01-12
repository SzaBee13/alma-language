@echo off
set VERSION=1.0

if "%1"=="-v" (
    echo Alma Language v%VERSION%
    pause
    exit /b
)

if "%1"=="" (
    echo Error: Specify an .alma file to run.
    pause
    exit /b
)

python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Python is not installed. Visit: https://www.python.org
    pause
    exit /b
)

node --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Node.js is not installed. Visit: https://nodejs.org
    pause
    exit /b
)

python "%~dp0alma_transpiler.py" "%~1" temp_output.js
node temp_output.js
del temp_output.js

pause