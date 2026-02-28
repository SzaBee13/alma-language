$ErrorActionPreference = 'Stop'

$packageName = 'alma'
$installDir = Join-Path $env:ProgramFiles 'AlmaLanguage'

Write-Host "Uninstalling Alma Language..." -ForegroundColor Cyan

# Remove file association
Write-Host "Removing .alma file association..." -ForegroundColor Cyan

$almaFileType = "AlmaFile"

# Remove registry keys for file association
Remove-Item "HKCU:\Software\Classes\.alma" -ErrorAction SilentlyContinue -Force
Remove-Item "HKCU:\Software\Classes\$almaFileType" -Recurse -ErrorAction SilentlyContinue -Force

# Remove from PATH
Write-Host "Removing from PATH..." -ForegroundColor Cyan

# Get current user PATH
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')

if ($userPath -like "*$installDir*") {
    # Remove the Alma directory from PATH
    $newPath = ($userPath.Split(';') | Where-Object { $_ -ne $installDir }) -join ';'
    [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
    Write-Host "Removed from PATH"
}

# Remove installation directory
if (Test-Path $installDir) {
    Write-Host "Removing installation directory..." -ForegroundColor Cyan
    Remove-Item $installDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Removed $installDir"
}

Write-Host "Alma Language has been uninstalled successfully!" -ForegroundColor Green
Write-Host "Note: You may need to restart your terminal for PATH changes to take effect." -ForegroundColor Yellow
