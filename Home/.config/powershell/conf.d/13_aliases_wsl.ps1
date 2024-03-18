
if ( !$IsLinux ) {
    function arch { wsl -d arch $args }
    function ubuntu { wsl -d ubuntu $args }

    function fish {
        if ($args.count -eq 0) { wsl -d arch fish; return}
        $distPackageManagers = "eval 'fish -C $args'"
        Start-Process -NoNewWindow -Wait -FilePath wsl.exe -ArgumentList "-d arch", "-- $distPackageManagers"
    }
    function bash {
        if ($args.count -eq 0) { wsl -d arch bash; return}
        $distPackageManagers = "eval 'bash -c $args'"
        Start-Process -NoNewWindow -Wait -FilePath wsl.exe -ArgumentList "-d arch", "-- $distPackageManagers"
    }

    function cal { wsl -d arch cal $args} 
}
