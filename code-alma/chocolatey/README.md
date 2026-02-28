# Alma Language - Chocolatey Package

This directory contains the Chocolatey package for Alma Language.

## Package Structure

```
chocolatey/
├── alma.nuspec                          # Package metadata
├── tools/
│   ├── chocolateyinstall.ps1           # Installation script
│   ├── chocolateyuninstall.ps1         # Uninstallation script
│   ├── VERIFICATION.txt                # Verification instructions
│   ├── alma.cmd                        # Alma command line interface
│   ├── run_alma.bat                    # Alma runner batch file
│   ├── alma.ps1                        # Alma PowerShell script
│   └── alma_transpiler.py              # Alma transpiler Python script
└── README.md                           # This file
```

## Building the Package

### Prerequisites

1. Install Chocolatey (if not already installed):
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

2. Install Chocolatey package builder:
   ```powershell
   choco install checksum -y
   ```

### Build Steps

1. Navigate to the chocolatey directory:
   ```powershell
   cd d:\other\alma\code-alma\chocolatey
   ```

2. Pack the package:
   ```powershell
   choco pack
   ```

   This will create a `.nupkg` file (e.g., `alma.1.4.0.nupkg`)

### Testing the Package Locally

1. Install the package locally:
   ```powershell
   choco install alma -s . -y
   ```

2. Test the installation:
   ```powershell
   alma -v
   ```

3. To uninstall:
   ```powershell
   choco uninstall alma -y
   ```

## Publishing to Chocolatey Community Repository

### Prerequisites

1. Create an account at https://community.chocolatey.org/
2. Get your API key from https://community.chocolatey.org/account

### Publishing Steps

1. Set your API key (only needed once):
   ```powershell
   choco apikey --key YOUR_API_KEY_HERE --source https://push.chocolatey.org/
   ```

2. Push the package:
   ```powershell
   choco push alma.1.4.0.nupkg --source https://push.chocolatey.org/
   ```

3. Wait for moderation approval (first-time packages require manual approval)

### Important Notes for Publishing

Before publishing to the public repository:

1. **Update URLs**: If you have a public download URL for the installer, update the `url` in `chocolateyinstall.ps1` with the actual download link and add proper checksums.

2. **Checksums**: Calculate checksums for any downloaded files:
   ```powershell
   checksum -t sha256 -f path/to/file
   ```

3. **Icon**: Ensure the iconUrl in the nuspec points to a publicly accessible icon (recommended: 128x128 PNG with transparent background)

4. **License**: Ensure the licenseUrl and requireLicenseAcceptance are correct

5. **Testing**: Thoroughly test the package in a clean environment before publishing

6. **Package Description**: The chocolatey team may request changes to the package description or metadata

## Version Updates

When updating to a new version:

1. Update the version in:
   - `alma.nuspec` (version field)
   - `alma_transpiler.py` (VERSION constant)
   - `alma.cmd` (VERSION variable)
   - `alma.ps1` (if version is hardcoded)

2. Rebuild the package:
   ```powershell
   choco pack
   ```

3. Test locally before publishing

## Support

- Alma Language Website: https://almalang.pages.dev
- Issues: Report on the main Alma repository
- Chocolatey Package Issues: https://community.chocolatey.org/packages/alma

## License

See the EULA files in the main code-alma directory for license information.
