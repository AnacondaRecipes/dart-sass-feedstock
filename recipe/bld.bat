REM conda-build extracts the archive flat: src\ holds the dart runtime,
REM sass.snapshot and LICENSE
if not exist "%LIBRARY_PREFIX%\share\dart-sass\src" mkdir "%LIBRARY_PREFIX%\share\dart-sass\src"
if not exist "%LIBRARY_BIN%" mkdir "%LIBRARY_BIN%"
xcopy /e /i /y src "%LIBRARY_PREFIX%\share\dart-sass\src\"
if %ERRORLEVEL% NEQ 0 exit 1

copy /y "%RECIPE_DIR%\win\sass.bat" "%LIBRARY_BIN%\sass.bat"
if %ERRORLEVEL% NEQ 0 exit 1
