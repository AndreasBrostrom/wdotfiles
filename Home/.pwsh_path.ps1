# Test paths if so they are not added if exist
function PATH_TEST([string]$path="", [string]$scope="User") {
    if ( $path -eq "" ) { return $False }
    $CurrentPath = [Environment]::GetEnvironmentVariable('Path',$scope)
    $SplittedPath = $CurrentPath -split ';'
    if ($SplittedPath.contains("$args")) {
        return $True
    }
    return $False
}

# Home bin
if( PATH_TEST "$env:userprofile\.bin" ) { $env:Path += ";$env:userprofile\.bin" }