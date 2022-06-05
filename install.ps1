#!/bin/pwsh
#Requires -RunAsAdministrator

$SCRIPT_DIR = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('./')

Set-Location "$SCRIPT_DIR"
Write-Host "Installing $((Get-Item $SCRIPT_DIR).Name)..." -ForegroundColor "DarkBlue"
 

Write-Host "Linking up home" -ForegroundColor "Yellow"
Set-Location "$SCRIPT_DIR/Home"
Get-ChildItem -Force -File -Recurse | Foreach-Object {
    $Fullpath = $_.FullName
    $FilenamePath = $_.FullName | Resolve-Path -Relative
    $FileName = $_.Name
    if ( $IsLinux ) { # used to block sertain configs in linux assuming .files allready exist.
        if ( $FileName -eq "starship.toml" )      { return } # continue used for Foreach-Object
        if ( $FileName -eq ".gitconfig" )         { return } # continue used for Foreach-Object
        if ( $FileNamePath.Contains('AppData') )  { return } # continue used for Foreach-Object
    }
    Write-Host " Setting up path to $(Split-Path "$HOME/$FilenamePath")" -ForegroundColor "DarkGray"
    Write-Host " Creating softlink for $FileName" -ForegroundColor "DarkGray"
    New-Item -ItemType "Directory" -Path $(Split-Path "$HOME/$FilenamePath") -Force 2>&1 | out-null
    New-Item -ItemType "SymbolicLink" -Path "$HOME/$FilenamePath" -Target $Fullpath -Force 2>&1 | out-null
}

Set-Location "$SCRIPT_DIR"

if ( $IsLinux ) {
    Write-Host "Nothing more to do on a linux system, we are done!" -ForegroundColor "DarkGreen"
    exit 0
}

# Windows ssh
if (Test-Path -Path "$SCRIPT_DIR/../secure/ssh") {
    Write-Host "Setting ssh" -ForegroundColor "Yellow"
    Set-Location "$SCRIPT_DIR/../secure/ssh"
    New-Item -ItemType "Directory" -Path "$HOME/.ssh" -Force 2>&1 | out-null

    Get-ChildItem -Force -File -Recurse | Foreach-Object {
        $Fullpath = $_.FullName
        $FilenamePath = $_.FullName | Resolve-Path -Relative
        $FileName = $_.Name
        Write-Host " Copying $FileName" -ForegroundColor "DarkGray"
        Copy-Item $FileName -Destination "$HOME/.ssh"
    }    
}

Set-Location "$SCRIPT_DIR"
