function exist {
    if ( -not $args[0] ) { return $false }
    
    if (Get-Command $args[0] -CommandType "Application" -errorAction SilentlyContinue) {
        return $true
    } else {
        return $false
    }
}