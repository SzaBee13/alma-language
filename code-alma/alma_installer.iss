#define MyAppVersion "1.4"

[Setup]
AppName=Alma Language
AppVersion={#MyAppVersion}
DefaultDirName={pf}\AlmaLanguage
DefaultGroupName=Alma Language
OutputDir=Output
OutputBaseFilename=alma-installer-v{#MyAppVersion}
Compression=lzma
SolidCompression=yes
AppSupportURL=https://almalang.pages.dev
AppUpdatesURL=https:///almalang.pages.dev/download
AppPublisher=SzaBee13

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"; LicenseFile: "./eula-en.txt"
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"; LicenseFile: "./eula-hu.txt"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"; LicenseFile: "./eula-de.txt"

[Files]
Source: "alma.cmd"; DestDir: "{app}"; Flags: ignoreversion
Source: "run_alma.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "alma_transpiler.py"; DestDir: "{app}"; Flags: ignoreversion
Source: "logo.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{userdesktop}\Run Alma Compiler"; Filename: "{app}\run_alma.bat"; WorkingDir: "{app}"
Name: "{group}\Run Alma Compiler"; Filename: "{app}\run_alma.bat"; WorkingDir: "{app}"

[Registry]
; PATH bővítése a telepítési mappával
Root: HKCU; Subkey: "Environment"; ValueType: expandsz; ValueName: "Path"; ValueData: "{reg:HKCU\Environment,Path|};{app}"

; .alma fájlok társítása
Root: HKCU; Subkey: "Software\Classes\.alma"; ValueType: string; ValueData: "AlmaFile"
Root: HKCU; Subkey: "Software\Classes\AlmaFile"; ValueType: string; ValueData: "Alma Script File"
Root: HKCU; Subkey: "Software\Classes\AlmaFile\DefaultIcon"; ValueType: string; ValueData: "{app}\logo.ico"
Root: HKCU; Subkey: "Software\Classes\AlmaFile\shell\open\command"; ValueType: string; ValueData: """{app}\alma.cmd"" ""%1"""