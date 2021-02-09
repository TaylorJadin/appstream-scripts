$repo="https://github.com/TaylorJadin/appstream-scripts/archive/main.zip"
$zipLoc="C:\AppStream\SessionScripts\RepoCopy\main.zip"
$exZip="C:\AppStream\SessionScripts\RepoCopy\Scripts"

Invoke-WebRequest -Uri $repo -OutFile $zipLoc
Expand-Archive -LiteralPath $zipLoc -DestinationPath $exZip

Invoke-Expression "$exZip\appstream-scripts-main\login.ps1"