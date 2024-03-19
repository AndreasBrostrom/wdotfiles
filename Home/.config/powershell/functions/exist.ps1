function exist {
    if ( ! $args[0] ) { return $false }
    
    if (Get-Command $args[0] -errorAction SilentlyContinue) {
        return $true
    } else {
        return $false
    }
}