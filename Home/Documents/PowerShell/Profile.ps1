# RC if one exist
if (Test-Path "$Env:USERPROFILE/.config/powershell/config.ps1" -PathType leaf) {
    . "$Env:USERPROFILE/.config/powershell/config.ps1"
}