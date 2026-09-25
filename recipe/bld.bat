@echo on

rem Resolve Dart dependencies from pub.dev (same as conda-forge build)
dart pub get
if %ERRORLEVEL% NEQ 0 exit 1

rem Generate the protobuf sources (requires buf from the host environment)
dart run grinder protobuf
if %ERRORLEVEL% NEQ 0 exit 1

rem Compile the sass CLI to a self-contained AOT executable
dart compile exe --define="version=%PKG_VERSION%" bin\sass.dart -o %LIBRARY_BIN%\sass.exe
if %ERRORLEVEL% NEQ 0 exit 1
