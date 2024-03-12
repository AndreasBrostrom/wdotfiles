if (Test-Path "$Env:USERPROFILE/Documents/PowerShell/profile.ps1" -PathType leaf) {
    . "$Env:USERPROFILE/Documents/PowerShell/profile.ps1"
}