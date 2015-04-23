SET PLAT=%1
SET GDAL_ROOT=
SET OUTPUT=%CD%\build
IF "%PLAT" == "" (
    echo Usage: build.bat [32|64]
    exit /B 1
)
IF "%PLAT%" == "32" (
    SET GDAL_ROOT=release-1700
    goto build
)
IF "%PLAT%" == "64" (
    SET GDAL_ROOT=release-1700-x64
    goto build
)
:error
echo Unknown platform option: %PLAT%
exit /B 1
:build
pushd "%GDAL_ROOT%\bin"
REM remove existing gdal dir as these are existing compiled GDAL 1.11 binaries and plugins
if exist curl rd /S /Q curl
if exist gdal rd /S /Q gdal
if exist ms rd /S /Q ms
REM remove irrelevant dlls
if exist gdal111.dll del /Q gdal111.dll
if exist mapserver.dll del /Q mapserver.dll
popd
nmake gdal PLATFORM_BITS=%PLAT%
nmake gdalplugins PLATFORM_BITS=%PLAT%
if not exist "%OUTPUT%" mkdir "%OUTPUT%"
if not exist "%OUTPUT%\gdal-data" mkdir "%OUTPUT%\gdal-data"
if not exist "%OUTPUT%\gdalplugins" mkdir "%OUTPUT%\gdalplugins"
copy /Y "%GDAL_ROOT%\bin\*.dll" "%OUTPUT%"
copy /Y "%GDAL_ROOT%\bin\gdal\apps\*.exe" "%OUTPUT%"
copy /Y "%GDAL_ROOT%\bin\gdal\plugins\*.dll" "%OUTPUT%\gdalplugins"
copy /Y "%GDAL_ROOT%\bin\gdal\plugins-optional\*.dll" "%OUTPUT%\gdalplugins"
xcopy /S /Y /I "%GDAL_ROOT%\bin\gdal-data" "%OUTPUT%\gdal-data"
xcopy /S /Y /I "%GDAL_ROOT%\bin\proj" "%OUTPUT%\proj"
popd
:done