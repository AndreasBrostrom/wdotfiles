

Set-Alias -Name vim -value nvim -Scope 'Global'
Set-Alias -Name py -value python -Scope 'Global'

if ( !$IsLinux ) {
    Set-Alias -Name htop -value ntop -Scope 'Global'
    Set-Alias -Name top -value ntop -Scope 'Global'
}
