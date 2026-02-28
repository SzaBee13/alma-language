param(
    [string]$inputFile
)

# Alma verzió
$VERSION = "1.4"

# Verzió ellenőrzése
if ($inputFile -eq "-v" -or $inputFile -eq "--version") {
    Write-Host "Alma Language v$VERSION"
    exit 0
}

if (-not $inputFile) {
    Write-Host "Usage: alma <input.alma>"
    exit 1
}

# Python transpiler futtatása
python "C:\Program Files (x86)\AlmaLanguage\alma_transpiler.py" $inputFile "temp_output.js"

# Ellenőrzi a hibát
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Transpilation failed."
    exit $LASTEXITCODE
}

# Lefuttatja a Node.js fájlt
node "temp_output.js"
del "temp_output.js"