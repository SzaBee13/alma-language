@echo off
set VERSION=1.4

if "%1"=="-v" (
    echo Alma Language v%VERSION%
    exit /b
)

if "%1"=="--version" (
    echo Alma Language v%VERSION
    exit /b
)

if "%1"=="" (
    echo Error: Specify an .alma file to run.
    exit /b
)

python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Python is not installed. Visit: https://www.python.org
    exit /b
)

node --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Node.js is not installed. Visit: https://nodejs.org
    exit /b
)

python "C:\Program Files (x86)\AlmaLanguage\alma_transpiler.py" %1 temp_output.js
if %errorlevel% neq 0 (
    echo Error occurred during transpilation.
)
node temp_output.js
del temp_output.js