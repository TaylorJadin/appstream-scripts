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

$visDesk="D:\PhotonUser\Desktop"
$visDocs="D:\PhotonUser\Documents"
$visDown="D:\PhotonUser\Downloads"

$homeFolder="D:\PhotonUser\My Files\Home Folder"

$deskPath="$homeFolder\Desktop"
$docsPath="$homeFolder\Documents"
$downPath="$homeFolder\Downloads"

## Loop until D:\PhotonUsers 

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

if ( Test-Path $deskPath ){
    Robocopy.exe "$deskPath" "$visDesk" /mir /xf *.lnk
}
else {
    Write-Host "Must be first login"
    #mkdir "$deskPath"
    #$hideDesk=get-item "$deskPath" -Force
    #$hideDesk.attributes="Hidden"
}
if ( Test-Path $docsPath ){
    Robocopy.exe "$docsPath" "$visDocs" /mir /xf *.lnk
}
else {
    Write-Host "Must be first login"
    #mkdir "$docsPath"
    #$hideDocs=get-item "$docsPath" -Force
    #$hideDocs.attributes="Hidden"
}
if ( Test-Path $downPath ){
    Robocopy.exe "$downPath" "$visDown" /mir /xf *.lnk
}
else {
    Write-Host "Must be first login"
    #mkdir "$downPath"
    #$hideDown=get-item "$downPath" -Force
    #$hideDesk.attributes="Hidden"
}
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /sethst:license.knight.domains
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /act
