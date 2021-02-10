## Script will try to copy a user's files from their Desktop, Downloads, and Documents folders
## Runs at login in SNCStudent stack
$visDesk="C:\PhotonUser\Desktop"
$visDocs="C:\PhotonUser\Documents"
$visDown="C:\PhotonUser\Downloads"

$homeFolder="D:\PhotonUser\My Files\Home Folder"

$deskPath="$homeFolder\Desktop"
$docsPath="$homeFolder\Documents"
$downPath="$homeFolder\Downloads"

## Check if D:\PhotonUser\My Files\Desktop exists.  If it doesn't, script will create the directory
## This is a hidden directory


if ( Test-Path $deskPath ){
    .\Robocopy.exe "$deskPath" "$visDesk" /e /it
}
else {
    mkdir "$deskPath"
    $hideDesk=get-item "$deskPath" -Force
    $hideDesk.attributes="Hidden"
}
if ( Test-Path $docsPath ){
    .\Robocopy.exe "$docsPath" "$visDocs" /e /it
}
else {
    mkdir "$docsPath"
    $hideDocs=get-item "$docsPath" -Force
    $hideDocs.attributes="Hidden"
}
if ( Test-Path $downPath ){
    .\Robocopy.exe "$downPath" "$visDown" /e /it
}
else {
    mkdir "$downPath"
    $hideDown=get-item "$downPath" -Force
    $hideDesk.attributes="Hidden"
}