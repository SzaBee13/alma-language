# Alma Chocolatey Package Builder
# This script helps build and test the Chocolatey package

param(
    [Parameter(Position=0)]
    [ValidateSet('build', 'test', 'clean', 'help')]
    [string]$Action = 'help'
)

$ErrorActionPreference = 'Stop'
$packageDir = $PSScriptRoot
$packageName = 'alma'

function Show-Help {
    Write-Host @"
Alma Chocolatey Package Builder
================================

Usage: .\build-package.ps1 <action>

Actions:
  build   - Build the Chocolatey package (.nupkg file)
  test    - Install the package locally for testing
  clean   - Remove built packages and test installations
  help    - Show this help message

Examples:
  .\build-package.ps1 build
  .\build-package.ps1 test
  .\build-package.ps1 clean

"@ -ForegroundColor Cyan
}

function Build-Package {
    Write-Host "Building Chocolatey package..." -ForegroundColor Green
    
    # Check if choco is installed
    try {
        $chocoVersion = choco --version
        Write-Host "Chocolatey version: $chocoVersion" -ForegroundColor Gray
    } catch {
        Write-Host "ERROR: Chocolatey is not installed!" -ForegroundColor Red
        Write-Host "Install it from: https://chocolatey.org/install" -ForegroundColor Yellow
        exit 1
    }
    
    # Verify required files exist
    $requiredFiles = @(
        'alma.nuspec',
        'tools\chocolateyinstall.ps1',
        'tools\chocolateyuninstall.ps1',
        'tools\alma.cmd',
        'tools\alma_transpiler.py'
    )
    
    foreach ($file in $requiredFiles) {
        $path = Join-Path $packageDir $file
        if (!(Test-Path $path)) {
            Write-Host "ERROR: Required file missing: $file" -ForegroundColor Red
            exit 1
        }
    }
    
    Write-Host "All required files present." -ForegroundColor Gray
    
    # Build the package
    Push-Location $packageDir
    try {
        choco pack
        
        $nupkgFiles = Get-ChildItem -Filter "*.nupkg"
        if ($nupkgFiles) {
            Write-Host "`nPackage built successfully!" -ForegroundColor Green
            foreach ($pkg in $nupkgFiles) {
                Write-Host "  - $($pkg.Name)" -ForegroundColor Cyan
            }
        } else {
            Write-Host "ERROR: Package file (.nupkg) was not created!" -ForegroundColor Red
            exit 1
        }
    } finally {
        Pop-Location
    }
}

function Test-Package {
    Write-Host "Testing Chocolatey package locally..." -ForegroundColor Green
    
    $nupkgFiles = Get-ChildItem $packageDir -Filter "*.nupkg" | Sort-Object LastWriteTime -Descending
    
    if (!$nupkgFiles) {
        Write-Host "ERROR: No .nupkg file found. Run 'build' first." -ForegroundColor Red
        exit 1
    }
    
    $packageFile = $nupkgFiles[0].Name
    Write-Host "Installing package: $packageFile" -ForegroundColor Gray
    
    # Check if already installed
    $installed = choco list --local-only $packageName --exact
    if ($installed -match $packageName) {
        Write-Host "Package already installed. Uninstalling first..." -ForegroundColor Yellow
        choco uninstall $packageName -y
    }
    
    # Install from local directory
    Push-Location $packageDir
    try {
        choco install $packageName -s . -y
        
        Write-Host "`nTesting installation..." -ForegroundColor Gray
        Write-Host "Running: alma -v" -ForegroundColor Gray
        
        # Refresh environment variables
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        # Test the command
        $almaPath = Join-Path $env:ProgramFiles "AlmaLanguage\alma.cmd"
        if (Test-Path $almaPath) {
            & $almaPath -v
            Write-Host "`nPackage tested successfully!" -ForegroundColor Green
        } else {
            Write-Host "WARNING: alma.cmd not found at expected location." -ForegroundColor Yellow
            Write-Host "You may need to restart your terminal." -ForegroundColor Yellow
        }
    } finally {
        Pop-Location
    }
}

function Clean-Package {
    Write-Host "Cleaning up..." -ForegroundColor Yellow
    
    # Remove .nupkg files
    $nupkgFiles = Get-ChildItem $packageDir -Filter "*.nupkg"
    if ($nupkgFiles) {
        Write-Host "Removing package files..." -ForegroundColor Gray
        foreach ($pkg in $nupkgFiles) {
            Remove-Item $pkg.FullName -Force
            Write-Host "  - Removed $($pkg.Name)" -ForegroundColor Gray
        }
    }
    
    # Check if package is installed and offer to uninstall
    $installed = choco list --local-only $packageName --exact
    if ($installed -match $packageName) {
        Write-Host "`nPackage '$packageName' is currently installed." -ForegroundColor Yellow
        $response = Read-Host "Do you want to uninstall it? (y/N)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            choco uninstall $packageName -y
            Write-Host "Package uninstalled." -ForegroundColor Gray
        }
    }
    
    Write-Host "`nCleanup complete!" -ForegroundColor Green
}

# Main execution
switch ($Action) {
    'build' { Build-Package }
    'test'  { Test-Package }
    'clean' { Clean-Package }
    'help'  { Show-Help }
    default { Show-Help }
}
