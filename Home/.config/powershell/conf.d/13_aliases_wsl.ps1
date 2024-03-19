
if ( !$IsLinux ) {

    function arch { wsl -d arch $args }
    function ubuntu { wsl -d ubuntu $args }

    function fish {
        if ($args.count -eq 0) { wsl -d arch fish; return}
        $command = "eval 'fish -c $args'"
        Start-Process -NoNewWindow -Wait -FilePath wsl.exe -ArgumentList "-d arch", "-- $command"
    }
    function bash {
        if ($args.count -eq 0) { wsl -d arch bash; return}
        $command = "eval 'bash -c $args'"
        Start-Process -NoNewWindow -Wait -FilePath wsl.exe -ArgumentList "-d arch", "-- $command"
    }

    # Programs
    function cal { wsl -d arch cal $args }

}
