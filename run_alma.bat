@echo off

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

if "%~1"=="" (
    echo Error: Enter an .alma file as an argument!
    echo Usage: run_alma.bat input.alma
    pause
    exit /b
)

set INPUT_FILE=%~1
set OUTPUT_FILE=temp_output.js


python "%~dp0alma_transpiler.py" "%INPUT_FILE%" "%OUTPUT_FILE%"
if not exist "%OUTPUT_FILE%" (
    echo Error: Compiler did not create %OUTPUT_FILE%.
    pause
    exit /b
)

node "%OUTPUT_FILE%"
if %ERRORLEVEL% neq 0 (
    echo An error occurred while running Node.js.
    del "%OUTPUT_FILE%"
    pause
    exit /b
)

rem Takarítás
del "%OUTPUT_FILE%"
