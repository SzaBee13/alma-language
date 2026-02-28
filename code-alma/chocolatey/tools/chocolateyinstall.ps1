$ErrorActionPreference = 'Stop'

$packageName = 'alma'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Join-Path $env:ProgramFiles 'AlmaLanguage'

# Package parameters
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installDir
  fileType      = 'exe'
  url           = ''
  
  softwareName  = 'Alma Language*'
  
  checksum      = ''
  checksumType  = 'sha256'
  
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Write-Host "Installing Alma Language to $installDir" -ForegroundColor Cyan

# Create install directory if it doesn't exist
if (!(Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
}

# Copy files from the package to the install directory
$filesToCopy = @(
    'alma.cmd',
    'run_alma.bat',
    'alma.ps1',
    'alma_transpiler.py'
)

foreach ($file in $filesToCopy) {
    $sourcePath = Join-Path $toolsDir $file
    if (Test-Path $sourcePath) {
        Copy-Item $sourcePath $installDir -Force
        Write-Host "Copied $file to $installDir"
    } else {
        Write-Warning "File $file not found in package"
    }
}

# Add to PATH
Install-ChocolateyPath -PathToInstall $installDir -PathType 'User'

# Create file association for .alma files
Write-Host "Setting up .alma file association..." -ForegroundColor Cyan

# Register .alma extension
$almaFileType = "AlmaFile"
$almaCmd = Join-Path $installDir "alma.cmd"

# Set file association in registry
Install-ChocolateyFileAssociation -Extension ".alma" -Executable $almaCmd

Write-Host "Alma Language has been installed successfully!" -ForegroundColor Green
Write-Host "You can now run Alma files using: alma yourfile.alma" -ForegroundColor Green
Write-Host "Check version with: alma -v" -ForegroundColor Green
Write-Host ""
Write-Host "Note: You may need to restart your terminal for PATH changes to take effect." -ForegroundColor Yellow
