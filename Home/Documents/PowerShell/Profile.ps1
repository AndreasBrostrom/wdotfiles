# RC if one exist
if (Test-Path "$Env:USERPROFILE/.pwshrc.ps1" -PathType leaf) {
    . "$Env:USERPROFILE/.pwshrc.ps1"
}
if (Test-Path "$Env:USERPROFILE/.config/powershell/rc.ps1" -PathType leaf) {
    . "$Env:USERPROFILE/powershell/rc.ps1"
}
if (Test-Path "$Env:USERPROFILE/.config/powershell/aliases.ps1" -PathType leaf) {
    . "$Env:USERPROFILE/powershell/aliases.ps1"
}