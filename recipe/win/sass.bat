@echo off
REM Launcher for the bundled dart-sass standalone distribution
"%~dp0..\share\dart-sass\src\dart.exe" "%~dp0..\share\dart-sass\src\sass.snapshot" %*
