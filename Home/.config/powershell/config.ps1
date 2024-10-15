# Set prompt title
if ( !$IsLinux ) {
    if ( [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) {
        $host.ui.RawUI.WindowTitle = "Administrator: PowerShell Core"
    } else {
        $host.ui.RawUI.WindowTitle = "PowerShell Core"
    }
}

# Read Functions
$functionDir = "$Env:USERPROFILE\.config\powershell\functions\"
if (Test-Path -Path $functionDir) {
    $functions = Get-ChildItem $functionDir -File -Filter "*.ps1"
    foreach ($function in $functions) {
        if ($PSVersionTable.PSVersion.Major -gt 5) {
            . "$function"
        } else {
            $fullFuncPath = join-path $functionDir $function
            . "$fullFuncPath"
        }
    }
}

# Read Configs
$configDir = "$Env:USERPROFILE\.config\powershell\conf.d\"
if (Test-Path -Path $configDir) {
    $configs = Get-ChildItem $configDir -File -Filter "*.ps1"
    foreach ($config in $configs) {
        if ($PSVersionTable.PSVersion.Major -gt 5) {
            . "$config"
        } else {
            $fullConfPath = join-path $configDir $config
            . "$fullConfPath"
        }
    }
}
 
if (!$IsLinux -and $PSVersionTable.PSVersion.major -gt 6) {
    #f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
    Import-Module -Name Microsoft.WinGet.CommandNotFound
}

$Env:STARSHIP_CONFIG = "$Env:LOCALAPPDATA\starship_pwsh.toml"
Invoke-Expression (&starship init powershell)