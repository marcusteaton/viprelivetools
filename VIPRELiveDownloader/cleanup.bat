@echo off
REM Tell user we're cleaning up some files
echo This will remove any of the following files from this directory, if they exist.
echo Removing "VIPRERescue*.*"

REM Delete the scanner exe or it's duplicates from wget (VIPRERescue12345.exe.1... etc.)
del VIPRERescue*.* /q
echo Removing "links-.txt"

REM Delete text file that's used as input for wget's url to download the scanner file
del links-.txt
echo Removing "index.html"

REM Delete html file that contains the direct URL to the scanner file
del index.html

REM Tell user we're done and wait for input, then quit
echo Done, press a key to quit. If there were errors the files are either currently in use or don't exist.
pause > NUL