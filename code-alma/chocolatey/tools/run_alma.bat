@echo off
if "%1"=="" (
    echo Please provide an Alma file to run.
    exit /b 1
)

python "C:\Program Files (x86)\AlmaLanguage\alma_transpiler.py" %1 temp_output.js
if %errorlevel% neq 0 (
    echo Error occurred during transpilation.
    exit /b 1
)

node temp_output.js
if %errorlevel% neq 0 (
    echo Error occurred while running the transpiled JavaScript.
)
