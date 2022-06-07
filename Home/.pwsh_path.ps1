# Test paths if so they are not added if exist
function ADD_PATH_ENV([string]$path="", [string]$scope="User") {
    function TEST_PATH_ENV([string]$path="", [string]$scope="User") {
        if ( $path -eq "" ) { return $False }
        $CurrentPath = [Environment]::GetEnvironmentVariable('Path', $scope)
        $SplittedPath = $CurrentPath -split ';'
        if ($SplittedPath.contains("$path")) {
            return $True
        }
        return $False
    }
    if (TEST_PATH_ENV $path $scope) {
        $ENV:Path += $path
    }
}

# Home bin
ADD_PATH_ENV ";$ENV:userprofile/.bin"