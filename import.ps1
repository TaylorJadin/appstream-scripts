$homeFolder = "D:\PhotonUser\My Files\Home Folder"
$sessionHome = # need a path yet

robocopy $homeFolder\Desktop$ $sessionHome\Desktop /mir /xf *.lnk
