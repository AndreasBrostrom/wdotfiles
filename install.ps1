#!/bin/pwsh

$SCRIPT_DIR = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('./')
Set-Location "$SCRIPT_DIR"

$IS_ADMIN = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

if ( -not $IS_ADMIN ) {
    Write-Host "Not running as admin will copy files instead of linking them."
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

if ( $IS_ADMIN ) {
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
        New-Item -ItemType "Directory" -Path $(Split-Path "$HOME/$FilenamePath") -Force 2>&1 | out-null
        Write-Host " Creating softlink for $FileName" -ForegroundColor "DarkGray"
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
} else {
    if ( $IsLinux ) {
        Write-Host "Non admin mode cant be used for installing." -ForegroundColor "DarkGreen"
        exit 0
    }
    Write-Host "Setting up home" -ForegroundColor "Yellow"
    Set-Location "$SCRIPT_DIR/Home"
    Get-ChildItem -Force -File -Recurse | Foreach-Object {
        $Fullpath = $_.FullName
        $FilenamePath = $_.FullName | Resolve-Path -Relative
        $FileName = $_.Name

        if ( $fileName -eq "settings.json" )  { return } # continue used for Foreach-Object

        Write-Host " Setting up path to $(Split-Path "$HOME/$FilenamePath")" -ForegroundColor "DarkGray"
        Write-Host " Creating copy for $FileName" -ForegroundColor "DarkGray"
        New-Item -ItemType "Directory" -Path $(Split-Path "$HOME/$FilenamePath") -Force 2>&1 | out-null
        Copy-Item -Destination "$HOME/$FilenamePath" -Path $Fullpath -Force 2>&1 | out-null
    }

    Set-Location "$SCRIPT_DIR"

    # Windows ssh
    if (Test-Path -Path "$SCRIPT_DIR/../secure/ssh") {
        Write-Host "Setting ssh" -ForegroundColor "Yellow"
        Write-Host "Warning! This might not work..." -ForegroundColor "Gray"

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
}

