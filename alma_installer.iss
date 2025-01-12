[Setup]
AppName=Alma Language
AppVersion=1.1
DefaultDirName={pf}\AlmaLanguage
DefaultGroupName=Alma Language
OutputDir=Output
OutputBaseFilename=AlmaInstaller
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"

[Files]
Source: "run_alma.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "alma_transpiler.py"; DestDir: "{app}"; Flags: ignoreversion
Source: "logo.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{userdesktop}\Run Alma Compiler"; Filename: "{app}\run_alma.bat"; WorkingDir: "{app}"
Name: "{group}\Run Alma Compiler"; Filename: "{app}\run_alma.bat"; WorkingDir: "{app}"

[Registry]
; Hozzáadjuk a telepítési mappát a PATH-hoz
Root: HKCU; Subkey: "Environment"; ValueType: expandsz; ValueName: "Path"; ValueData: "{app}"

; Regisztráljuk a .alma kiterjesztést
Root: HKCU; Subkey: "Software\Classes\.alma"; ValueType: string; ValueData: "AlmaFile"
Root: HKCU; Subkey: "Software\Classes\AlmaFile"; ValueType: string; ValueData: "Alma Script File"
Root: HKCU; Subkey: "Software\Classes\AlmaFile\DefaultIcon"; ValueType: string; ValueData: "{app}\logo.ico"
Root: HKCU; Subkey: "Software\Classes\AlmaFile\shell\open\command"; ValueType: string; ValueData: """{app}\run_alma.bat"" ""%1"""