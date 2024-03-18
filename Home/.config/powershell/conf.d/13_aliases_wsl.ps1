
if ( !$IsLinux ) {
    function arch { wsl -d arch $args }
    function ubuntu { wsl -d ubuntu $args }

    function fish {
        $distPackageManagers = "eval 'fish -C $args'"
        Start-Process -NoNewWindow -Wait -FilePath wsl.exe -ArgumentList "--distribution arch", "-- $distPackageManagers"
    }
    function bash {
        $distPackageManagers = "eval 'bash -c $args'"
        Start-Process -NoNewWindow -Wait -FilePath wsl.exe -ArgumentList "--distribution arch", "-- $distPackageManagers"
    }

    function cal { wsl -d arch eval "cal -C $args"} 
}
