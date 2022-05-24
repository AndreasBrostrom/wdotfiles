# Test paths if so they are not added if exist
function TEST_PATHENV([string]$path="", [string]$scope="User") {
    if ( $path -eq "" ) { return $False }
    $CurrentPath = [Environment]::GetEnvironmentVariable('Path',$scope)
    $SplittedPath = $CurrentPath -split ';'
    if ($SplittedPath.contains("$path")) {
        return $True
    }
    return $False
}

# Home bin
if( !(TEST_PATHENV "$env:userprofile\.bin") ) { $env:Path += ";$env:userprofile\.bin" }