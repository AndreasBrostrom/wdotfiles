if (Test-Path "$ENV:USERPROFILE/Documents/PowerShell/profile.ps1" -PathType leaf) {
    . "$ENV:USERPROFILE/Documents/PowerShell/profile.ps1"
}