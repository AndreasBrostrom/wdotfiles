
if ( !$IsLinux ) {
    function arch { wsl -d arch $args}
    function ubuntu { wsl -d ubuntu $args}

    function fish { wsl -d arch eval "fish -C $args" }
    function bash { wsl -d arch eval "bash -c $args" }

    function cal { wsl -d arch eval "cal -C $args"} 
}
