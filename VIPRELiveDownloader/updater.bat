@echo off

REM Let user know about cleanup.bat
echo If the program abnormally terminates without finishing, run cleanup.bat.
echo.

REM Set window title
title VIPRERescueGet - http://marcus.crisisresponseunit.com/

REM Check if a scanner file already exists, if it does, go to "fileexist", if not, go to "yes" 
if exist "VIPRERescue*.exe" goto fileexist else goto yes
:yes
REM Remove existing scanner file to prevent wget's noclobber function from happening (send errors to NUL)
del /q VIPRERescue*.* 2> NUL

REM Get the index.html file in this directory, which contains a meta-refresh to the direct link
wget http://vipreantivirus.com/live/Download2/

REM Wget resets the window title so we will set it again
title VIPRERescueGet - http://marcus.crisisresponseunit.com/

REM Run the VBS script to extract the URL for the direct link to the scanner, and save it to a text file
links.vbs index.html

REM run wget again with the url input set to a text file, which contains the url we extracted earlier
wget -i links-.txt

REM Wget resets the window title so we will set it again
title VIPRERescueGet - http://marcus.crisisresponseunit.com/

REM Clean up temporary files after download is complete, tell the user we're done, wait for input, and exit
del links-.txt
del index.html
echo Press a key to quit. You can now run VIPRERescue and begin the virus scan.
pause > NUL
exit
:no

REM User selected no to update scanner, so we tell them so, wait for input, and quit
echo Update aborted. Press a key to close this window.
pause > NUL
exit
:fileexist

REM If we find a scanner file already there, ask if we want to overwrite
echo There is already a file in the current directory called VIPRERescue*.exe. Would you like to replace it? (Type "Y" for yes, "N" for no.)

REM Clear "choice" variable
set choice=

REM Prompt user for choice
set /p choice=Yes/No: 

REM List of valid choices
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='N' goto no
if '%choice%'=='n' goto no
if '%choice%'=='Y' goto yes
if '%choice%'=='y' goto yes

REM If choice isn't valid, tell user and send back to prompt
echo.
echo "%choice%" is not a valid choice. Please press a key to try again.
echo.
pause > NUL
cls
goto fileexist