#################################################################################################
## logout.ps1
## Runs when user logs out of AppStream, and machine starts the process of complete annihilation.
## Script will try to copy a user's files from their Desktop, Downloads, and Documents folders
## Script is meant to copy any files a user has created, so they don't get deleted accidentally
## Script is pulled to computer during the login process.
## Login.json triggers a script (ScriptPull.ps1) that pulls our repo down. 
## This script runs as system, triggered by config.json in C:\AppStream\SessionScripts\config.json
##
## St. Norbert College
## 02/10/21
## Nick Plank and Taylor Jadin
#################################################################################################

## Script copies files from user's Desktop, Downloads, and Documents folders to their home folder.
## We do this so their content doesn't accidentally get deleted.
## Runs at login in SNCStudent stack
#$visDesk="D:\PhotonUser\Desktop"
#$visDocs="D:\PhotonUser\Documents"
#$visDown="D:\PhotonUser\Downloads"

## Content in $homeFolder is stored in an S3 bucket when the user logs out.
#$homeFolder="D:\PhotonUser\My Files\Home Folder"

## Updated path to C:\Users, because apparently this breaks
$visDesk="C:\Users\PhotonUser\Desktop"
$visDocs="C:\Users\PhotonUser\Documents"
$visDown="C:\Users\PhotonUser\Downloads"

## Content in $homeFolder is stored in an S3 bucket when the user logs out.
$homeFolder="C:\Users\PhotonUser\My Files\Home Folder"


$deskPath="$homeFolder\Desktop"
$docsPath="$homeFolder\Documents"
$downPath="$homeFolder\Downloads"

if ( Test-Path $deskPath ){
    Robocopy.exe "$visDesk" "$deskPath" /s /it /xf *.lnk
}
else {
    mkdir "$deskPath"
    Robocopy.exe "$visDesk" "$deskPath" /s /it /xf *.lnk
}
if ( Test-Path $docsPath ){
    Robocopy.exe "$visDocs" "$docsPath" /s /it /xf *.lnk
}
else {
    mkdir "$docsPath"
    Robocopy.exe "$visDocs" "$docsPath" /s /it /xf *.lnk
}
if ( Test-Path $downPath ){
    Robocopy.exe "$visDown" "$downPath" /s /it /xf *.lnk
}
else {
    mkdir "$downPath"
    Robocopy.exe "$visDown" "$downPath" /s /it /xf *.lnk
}
