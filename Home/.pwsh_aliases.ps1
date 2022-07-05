# Programs
Set-Alias -Name vim -value nvim -Scope 'Global'
Set-Alias -Name py -value python -Scope 'Global'

Set-Alias -Name htop -value ntop -Scope 'Global'
Set-Alias -Name top -value ntop -Scope 'Global'

# Misc
Set-Alias -Name clr -Value clear


# Git aliases
if ($PSVersionTable.PSVersion.major -gt 6) {
    if (Test-Path alias:gp) { Remove-Alias gp -Force }
    if (Test-Path alias:gcm) { Remove-Alias gcm -Force }
}

function global:gs()    { git status }
function global:gc()    { git checkout }
function global:gcm()   { git checkout $(split-path ( git symbolic-ref "refs/remotes/origin/HEAD" ) -Leaf) }
function global:gcpr()  { gh pr checkout $args }
function global:gb()    { git branch }
function global:gf()    { git fetch --all --prune }
function global:gr()    { git rebase }
function global:grm()   { git rebase origin/main }
function global:gpu     { git push }
function global:gpuf    { git push fork }
function global:gpuff   { git push --set-upstream fork $(git rev-parse --abbrev-ref HEAD) }

function global:gp()    { git stash }
function global:gpp()   { git stash pop }

function global:gfr()   { gf; gr }
function global:gfm()   { gf; grm }
function global:gfrp()  { gp; gfr }
function global:gfrpp() { gfrp; gpp }
function global:gcp()   { gp; gc }
function global:gcpp()  { Write-Host '"eval gp; eval gc $1; eval gpp ;" is not implemented on windows.' }
function global:gcmp    { gp; gcm }
function global:gcmpp   { gp; gcm; gpp }
function global:gcprfr  { Write-Host '"eval gp; eval gc $1; eval gpp ;" is not implemented on windows.' }
function global:gclean  { Write-Host 'git clean script is not implemented on windows.' }

# GitHub-Cli
function global:ghc()   { gcpr }
function global:ghr()   { gh pr review }
function global:ghm()   { gh pr merge }

# Linux commands
function global:cal { bash -c "cal $args" }
