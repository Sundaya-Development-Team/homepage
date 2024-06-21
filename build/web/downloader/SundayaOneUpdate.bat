
@echo off

:: Define the URL of the new file you want to download
set "sourceUrl=https://apps.sundaya.com/downloader/SundayaOne1.12.3.zip"

:: Define the file name for the new file
set "fileName=Release.zip"

:: Define the full file path for the new file
set "destinationFolder=%CD%"
set "filePath=%destinationFolder%\%fileName%"

:: Close the SundayaOne or SundayaDesktop application if it's running
taskkill /im SundayaOne.exe /f
taskkill /im SundayaDesktop.exe /f

:: Check if the folder exists and delete it
if exist "%destinationFolder%" (
    echo Deleting existing folder...
    rmdir /s /q "%destinationFolder%"
)

:: Create the destination folder
mkdir "%destinationFolder%"

:: Download the new file using BITSAdmin (Windows built-in tool)
bitsadmin /transfer "Updater SundayaOne" "%sourceUrl%" "%filePath%"

:: Check if download is complete
:CHECK_DOWNLOAD
bitsadmin /info "DownloadJob" | find "TRANSFERRING" > nul
if %errorlevel%==0 (
    timeout /t 5 /nobreak > nul
    goto CHECK_DOWNLOAD
)

:: Extract the downloaded file (assumes it's a zip file)
powershell -command "Expand-Archive -Path \"%filePath%\" -DestinationPath \"%destinationFolder%\""

:: Create a shortcut for SundayaOne.exe on the desktop
set "shortcutTarget=%destinationFolder%\SundayaOne.exe"
set "shortcutName=SundayaOne.lnk"
set "desktopFolder=%USERPROFILE%\Desktop"
set "shortcutPath=%desktopFolder%\%shortcutName%"

echo Creating shortcut on desktop...
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%temp%\CreateShortcut.vbs"
echo sLinkFile = "%shortcutPath%" >> "%temp%\CreateShortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%temp%\CreateShortcut.vbs"
echo oLink.TargetPath = "%shortcutTarget%" >> "%temp%\CreateShortcut.vbs"
echo oLink.Save >> "%temp%\CreateShortcut.vbs"
cscript /nologo "%temp%\CreateShortcut.vbs"
del "%temp%\CreateShortcut.vbs" /q

:: Exit the batch script
exit /b 0

