@echo on

rem All Dart dependencies ship in the recipe pub cache; pub resolves offline,
rem keeping the build free of pub.dev access (PBP win workers have no egress)
set "PUB_CACHE=%SRC_DIR%\pub-cache"
mkdir "%PUB_CACHE%" 2>nul
rem extract with the system bsdtar: it handles drive-letter paths, unlike the
rem GNU tar on PATH, which reads the C: in a windows path as a remote host
%SystemRoot%\System32\tar.exe -xzf "%RECIPE_DIR%\dart-sass-pub-cache.tar.gz" -C "%PUB_CACHE%"
if %ERRORLEVEL% NEQ 0 exit 1
dart pub get --offline
if %ERRORLEVEL% NEQ 0 exit 1

rem The embedded language spec ships as a git bundle pinned to the sass/sass
rem commit the release was built against (EMBEDDED_PROTOCOL_VERSION 3.3.0)
set "UPDATE_SASS_PROTOCOL=false"
git clone "%RECIPE_DIR%\sass-language-88142a47.bundle" build\language
if %ERRORLEVEL% NEQ 0 exit 1

rem Generate the protobuf sources (requires buf from the host environment)
dart run grinder protobuf
if %ERRORLEVEL% NEQ 0 exit 1

rem Compile the sass CLI to a self-contained AOT executable
dart compile exe --define="version=%PKG_VERSION%" bin\sass.dart -o %LIBRARY_BIN%\sass.exe
if %ERRORLEVEL% NEQ 0 exit 1
