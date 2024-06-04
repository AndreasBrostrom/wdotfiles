
if ( !$IsLinux ) {

    function reboot { shutdown.exe /r /t 0 $args }
    Set-Alias -Name ifconfig -Value Get-NetIPConfiguration -Scope 'Global'

    function global:pkill() {
        sudo Stop-Process -force -name $args
    }
    function global:skill() {
        sudo Stop-Service -force -name $args
    }

    function global:cal() {
        if ($args) {
            python -m calendar $args
            exit 0
        }
        $month = (Get-Date -Format "MM")
        $year = (Get-Date -Format "yyyy")
        python -m calendar $year $month
    }

}
