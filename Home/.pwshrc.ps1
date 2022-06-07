# Set prompt title
#$host.ui.RawUI.WindowTitle = "Powershell Core"

# Set prompt to unix like
function prompt { (Write-Host ("$pwd".replace("$($home)", "~")) -ForegroundColor Blue -NoNewline) + (Write-Host ' PS>' -ForegroundColor DarkGray -NoNewline) + ' '}

# Windows linux conversions
$curren_path = ($pwd).path
if (!(Compare-Object "$curren_path" "C:\Windows\system32")) { set-location "$env:userprofile" }

# LS handling
if ((Get-Command ls -CommandType "Application" -ErrorAction SilentlyContinue) -eq $null ) {
    if ($PSVersionTable.PSVersion.major -gt 6) {
        function alias_fnc_ls { Invoke-Expression "Get-ChildItem $args | Format-Wide -AutoSize" }
        Set-Alias -Name ls -Value alias_fnc_ls
    }
    function ll   { Invoke-Expression "Get-ChildItem $args -Force" }
    function la   { Invoke-Expression "Get-ChildItem $args -Force| Format-Wide -AutoSize" }
    function l    { Invoke-Expression "Get-ChildItem $args" }
} else {
    # if you have coreutils ls
    if ($PSVersionTable.PSVersion.major -gt 6) {
        function application_alias_fnc_ls {
            Invoke-Expression "$( (Get-Command ls -CommandType "Application" | Select -First 1).Source) --color=auto $args"
        }
        Set-Alias -Name ls -Value application_alias_fnc_ls
    }
    function ll   { Invoke-Expression "ls -alF $args" }
    function lsl  { Invoke-Expression "ls -lF $args" }
    function la   { Invoke-Expression "ls -A $args" }
    function lsa  { Invoke-Expression "la $args" }
    function l    { Invoke-Expression "ls -CF $args" }
    function lr   { Invoke-Expression "ls -ltrh $args" }
    function lra  { Invoke-Expression "ls -ltrha $args" }
}

if ($PSVersionTable.PSVersion.major -gt 6) {
    if ((Get-Command rm    -CommandType "Application" -ErrorAction SilentlyContinue) -eq $null ) { Remove-Alias -Name rm }
    if ((Get-Command rmdir -CommandType "Application" -ErrorAction SilentlyContinue) -eq $null ) { Remove-Alias -Name rmdir }
}


# Windows Unix extentions
function reboot { shutdown -r -t 0 $args }
Set-Alias -Name ifconfig -Value Get-NetIPConfiguration -Scope 'Global'


# Aliases and Path
if (Test-Path "$env:userprofile\.pwsh_aliases.ps1" -PathType leaf) {
    . "$env:userprofile\.pwsh_aliases.ps1"
}
if (Test-Path "$env:userprofile\.pwsh_path.ps1" -PathType leaf) {
    . "$env:userprofile\.pwsh_path.ps1"
}

$ENV:STARSHIP_CONFIG = "$HOME\.config\pwsh_starship.toml"

Invoke-Expression (&starship init powershell)
