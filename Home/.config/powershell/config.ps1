# Set prompt title
if ( !$IsLinux ) {
    if ( [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) {
        $host.ui.RawUI.WindowTitle = "Administrator: PowerShell Core"
    } else {
        $host.ui.RawUI.WindowTitle = "PowerShell Core"
    }
}

# Read Configs
$configDir = "$Env:USERPROFILE/.config/powershell/conf.d//"
if (Test-Path -Path $configDir) {
    $configs = Get-ChildItem "$Env:USERPROFILE/.config/powershell/conf.d/" -File -Filter "*.ps1"
    foreach ($config in $configs) { . "$config" }
}

# Read Functions
$functionDir = "$Env:USERPROFILE/.config/powershell/functions/"
if (Test-Path -Path $functionDir) {
    $functions = Get-ChildItem $functionDir -File -Filter "*.ps1"
    foreach ($function in $functions) { . "$function" }
}

$Env:STARSHIP_CONFIG = "$Env:LOCALAPPDATA/starship_pwsh.toml"
Invoke-Expression (&starship init powershell)