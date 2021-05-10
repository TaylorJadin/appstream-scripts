$repo="https://github.com/TaylorJadin/appstream-scripts/archive/main.zip"
$repoLoc="C:\AppStream\SessionScripts\RepoCopy"
$zipLoc="$repoLoc\main.zip"
$exZip="$repoLoc\Scripts"
$logLoc="D:\PhotonUser\My Files\Home Folder\Logs\login.log"

mkdir "$repoLoc"
mkdir "$exZip"

Invoke-WebRequest -Uri $repo -OutFile $zipLoc
Expand-Archive -LiteralPath $zipLoc -DestinationPath $exZip

Invoke-Expression "$exZip\appstream-scripts-main\login.ps1" > $logLoc
