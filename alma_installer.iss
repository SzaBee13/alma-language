[Setup]
AppName=Alma Language
AppVersion=1.0
DefaultDirName={pf}\AlmaLanguage
DefaultGroupName=Alma Language
OutputBaseFilename=AlmaInstaller
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"

[Files]
; Fordító és szükséges fájlok
Source: "alma_transpiler.py"; DestDir: "{app}"; Flags: ignoreversion
Source: "run_alma.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "alma.cmd"; DestDir: "{app}"; Flags: ignoreversion
Source: "logo.png"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Asztali ikon a fordításhoz és futtatáshoz
Name: "{desktop}\Run Alma"; Filename: "{app}\alma.cmd"

[Registry]
; Társítás a .alma fájlokhoz
Root: HKCR; Subkey: ".alma"; ValueType: string; ValueData: "AlmaFile"; Flags: createvalueifdoesntexist
Root: HKCR; Subkey: "AlmaFile"; ValueType: string; ValueData: "Alma Script File"; Flags: createvalueifdoesntexist
Root: HKCR; Subkey: "AlmaFile\DefaultIcon"; ValueType: string; ValueData: "{app}\logo.png"; Flags: createvalueifdoesntexist
Root: HKCR; Subkey: "AlmaFile\shell\open\command"; ValueType: string; ValueData: """{app}\alma.cmd"" ""%1"""; Flags: createvalueifdoesntexist

[Run]
; Figyelmeztetés: Node.js és Python szükséges, de nem települnek automatikusan
Filename: "{app}\alma.cmd"; Description: "Run alma translator!"; Flags: shellexec skipifsilent
