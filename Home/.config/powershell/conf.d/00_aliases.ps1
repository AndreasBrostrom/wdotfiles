
# LS binary vs alias usage
if ( !(exist ls) ) {
    if ($PSVersionTable.PSVersion.major -gt 6) {
        function alias_fnc_ls { Invoke-Expression "Get-ChildItem $args | Format-Wide -AutoSize" }
        Set-Alias -Name ls -Value alias_fnc_ls
    }
    function ll   { Invoke-Expression "Get-ChildItem $args -Force" }
    function la   { Invoke-Expression "Get-ChildItem $args -Force | Format-Wide -AutoSize" }
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

# Extended ls
function global:cdls() {
    [string]$path = $args[0]
    cd -Path $path
    ls
}
function global:cdll() {
    [string]$path = $args[0]
    cd -Path $path
    ll
}

Set-Alias -Name clr -value clear -Scope 'Global'
