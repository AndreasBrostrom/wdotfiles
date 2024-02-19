# RC if one exist
if (Test-Path "$ENV:USERPROFILE/.pwshrc.ps1" -PathType leaf) {
    . "$ENV:USERPROFILE/.pwshrc.ps1"
}
if (Test-Path "$ENV:USERPROFILE/.config/powershell/rc.ps1" -PathType leaf) {
    . "$ENV:USERPROFILE/powershell/rc.ps1"
}
if (Test-Path "$ENV:USERPROFILE/.config/powershell/aliases.ps1" -PathType leaf) {
    . "$ENV:USERPROFILE/powershell/aliases.ps1"
}