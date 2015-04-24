# gdal4fdo
Makefile modifications of gisinternals/buildsystem for use in FDO 3.9 and 4.0 (for MapGuide Open Source 2.6 and 3.0)

# Requirements

 * Visual Studio 2012 (can use Windows Desktop Express SKU)
 * GDAL Development SDK for MSVC 2012: http://www.gisinternals.com/sdk.php

# Build Instructions

1. Download the MSVC 2012 flavour of the GDAL development kit from here: http://www.gisinternals.com/sdk.php
2. Extract the downloaded zip to $SDK_ROOT
3. svn export Thirdparty\gdal from your FDO 3.9 or FDO 4.0 working copy to $SDK_ROOT\gdal
4. Run VS 2012 command prompt for x86 or x64
5. cd $SDK_ROOT
6. Run the following command:
    * For x86: `build.bat 32`
    * For x64: `build.bat 64`
7. Your custom GDAL binaries and plugins will be in the `build` directory

# Changes

 * Turned off OpenJPEG (FDO's GDAL references a version of OpenJPEG not included here) (GDAL_OPENJPEG=NO)
 * Turned off MySQL support (various compilation/linker errors) (GDAL_MYSQL=NO)
 * Turned on SQLite support (GDAL_SQLITE=YES)
 * Turned on Tiff support (GDAL_TIFF=YES)
