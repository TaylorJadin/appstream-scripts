#################################################################################################
## login.ps1
## Runs as part of the login process of AppStream for some fleets
## Script will try to copy a user's files from their Desktop, Downloads, and Documents folders
## Script is meant to copy any files from a user's previous session to their current session.
## Script is pulled to computer during the login process.
## Login.json triggers a script (ScriptPull.ps1) that pulls our repo down. 
## ScriptPull.ps1 runs this scripts during it's Invoke-Expression command, at the end.
##
## St. Norbert College
## 02/10/21
## Nick Plank and Taylor Jadin
#################################################################################################


### Config ###
# Apparently D: is where Amazon puts the home folder if you have settings profile enabled.
#$visDesk="D:\PhotonUser\Desktop"
#$visDocs="D:\PhotonUser\Documents"
#$visDown="D:\PhotonUser\Downloads"

#$homeFolder="D:\PhotonUser\My Files\Home Folder"

$visDesk="C:\Users\PhotonUser\Desktop"
$visDocs="C:\Users\PhotonUser\Documents"
$visDown="C:\Users\PhotonUser\Downloads"

$homeFolder="C:\Users\PhotonUser\My Files\Home Folder"

$deskPath="$homeFolder\Desktop"
$docsPath="$homeFolder\Documents"
$downPath="$homeFolder\Downloads"
$log="$homeFolder\login.log"

$repo="https://github.com/TaylorJadin/appstream-scripts/archive/main.zip"
$repoLoc="C:\AppStream\SessionScripts\RepoCopy"
$zipLoc="$repoLoc\main.zip"
$exZip="$repoLoc\Scripts"
$logLoc="D:\PhotonUser\My Files\Home Folder\Logs\login.log"

### Functions ###
function waitForFSMounts {
    do 
    {
        $firstLoop=( Test-Path "$visDesk" )
        Start-Sleep -s 5
    }
    while ( "$firstLoop" -eq "False" )

    do
    {
        $secondLoop=( Test-Path "$deskPath" )
        Start-Sleep -s 5
    }
    while ( "$secondLoop" -eq "False" )
}


function restoreFiles {
    if ( Test-Path $deskPath ){
        Robocopy.exe "$deskPath" "$visDesk" /s /xf *.lnk
        $hideDesk=get-item "$deskPath" -Force
        $hideDesk.attributes="Hidden"
    }
    else {
        Write-Host "Must be first login"
    }
    if ( Test-Path $docsPath ){
        Robocopy.exe "$docsPath" "$visDocs" /s /xf *.lnk
        $hideDocs=get-item "$docsPath" -Force
        $hideDocs.attributes="Hidden"
    }
    else {
        Write-Host "Must be first login"
    }
    if ( Test-Path $downPath ){
        Robocopy.exe "$downPath" "$visDown" /s /xf *.lnk
        $hideDown=get-item "$downPath" -Force
        $hideDesk.attributes="Hidden"
    }
    else {
        Write-Host "Must be first login"
    }
}

### Main ###
waitForFSMounts
restoreFiles
mkdir "C:\Users\PhotonUser\AppData\Roaming\rclone"
mv "$exZip\appstream-scripts-main\ArcClassDriveMount.bat" "C:Users\PhotonUser\"
mv "$exZip\appstream-scripts-main\rclone.conf" "C:\Users\PhotonUser\AppData\Roaming\rclone\"

#restoreFiles >> $log

#cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /sethst:ec2-23-20-94-46.compute-1.amazonaws.com
#cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /act
