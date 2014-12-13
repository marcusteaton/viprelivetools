@echo off

REM Set window title
title VIPRERescueTempClean - http://marcus.crisisresponseunit.com/

REM Warn user that this will delete files
echo.
echo WARNING! This will delete all files inside of the C:\VIPRERESCUE folder!

REM /s paramater will ask if it will be ok to remove all files in specified directories and sub-directories
rmdir /s C:\VIPRERESCUE

REM Let user know we're done and wait for input before exiting
echo Removal Complete. Press a key to close this window.
pause > NUL