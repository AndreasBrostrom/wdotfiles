
Set-Alias -Name vim -value nvim -Scope 'Global'
Set-Alias -Name py -value python -Scope 'Global'

# Git aliases
function global:gs()    { git status }
function global:gc()    { git checkout }
function global:gb()    { git branch }
function global:gf()    { git fetch --all --prune }
function global:gr()    { git rebase }
function global:gu()    { git rebase origin/master }

Remove-Alias gp -Force
function global:gp()    { git stash }
function global:gpp()   { git stash pop }

function global:gpu()   { git push }
function global:gpuf    { git push fork }
function global:gpuff   { git push --set-upstream fork $(git rev-parse --abbrev-ref HEAD) }

function global:gfr()   { gf; gr }
function global:grf()   { gfr }
function global:gfu()   { gf; gu }
function global:guf()   { gfu }

function global:gfrp()  { gp; grf }
function global:gfrpp() { gfrp; gpp }

function global:gcp()   { gp; gc }

# Linux commands
function global:cal { bash -c "cal $args" }