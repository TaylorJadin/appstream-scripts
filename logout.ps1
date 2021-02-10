## Script copies files from user's Desktop, Downloads, and Documents folders to their home folder.
## We do this so their content doesn't accidentally get deleted.
## Runs at login in SNCStudent stack
$visDesk="C:\PhotonUser\Desktop"
$visDocs="C:\PhotonUser\Documents"
$visDown="C:\PhotonUser\Downloads"

## Content in $homeFolder is stored in an S3 bucket when the user logs out.
$homeFolder="D:\PhotonUser\My Files\Home Folder"

$deskPath="$homeFolder\Desktop"
$docsPath="$homeFolder\Documents"
$downPath="$homeFolder\Downloads"

if ( Test-Path $deskPath ){
    Robocopy.exe "$visDesk" "$deskPath" /mir /it /xf *.lnk
}
else {
    mkdir "$deskPath"
    $hideDesk=get-item "$deskPath" -Force
    $hideDesk.attributes="Hidden"
    Robocopy.exe "$visDesk" "$deskPath" /mir /it /xf *.lnk
}
if ( Test-Path $docsPath ){
    Robocopy.exe "$visDocs" "$docsPath" /mir /it /xf *.lnk
}
else {
    mkdir "$docsPath"
    $hideDocs=get-item "$docsPath" -Force
    $hideDocs.attributes="Hidden"
    Robocopy.exe "$visDocs" "$docsPath" /mir /it /xf *.lnk
}
if ( Test-Path $downPath ){
    Robocopy.exe "$visDown" "$downPath" /mir /it /xf *.lnk
}
else {
    mkdir "$downPath"
    $hideDown=get-item "$downPath" -Force
    $hideDesk.attributes="Hidden"
    Robocopy.exe "$visDown" "$downPath" /mir /it /xf *.lnk
}
