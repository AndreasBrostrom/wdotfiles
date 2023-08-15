# Programs
Set-Alias -Name vim -value nvim -Scope 'Global'
Set-Alias -Name py -value python -Scope 'Global'

Set-Alias -Name htop -value ntop -Scope 'Global'
Set-Alias -Name top -value ntop -Scope 'Global'


# Misc
Set-Alias -Name clr -Value clear
function global:pkill() {
    sudo Stop-Process -force -name $args
}
function global:skill() {
    sudo Stop-Service -force -name $args
}


# Extended ls
function global:cdls() {
    [string]$path = $args[0]
    cd -Path $path
    ls
}
function global:cdll() {
    [string]$path = $args[0]
    cd -Path $path
    ll
}


# Git aliases
if ($PSVersionTable.PSVersion.major -gt 6) {
    if (Test-Path alias:gc) { Remove-Alias gc -Force }
    if (Test-Path alias:gp) { Remove-Alias gp -Force }
    if (Test-Path alias:gcm) { Remove-Alias gcm -Force }
}

function global:gs()        { git status $args }
function global:gc()        { git checkout $args }
function global:gcm()       { git checkout $(split-path $( git symbolic-ref "refs/remotes/origin/HEAD" ) -Leaf) }
function global:gcpr()      { gh pr checkout $args }
function global:gb()        { git branch $args }
function global:gf()        { git fetch --all --prune $args }
function global:gr()        { git rebase $args }
function global:grm()       { git rebase $(split-path $( git symbolic-ref "refs/remotes/origin/HEAD" ) -Leaf) }
function global:gpu()       { git push $args }
function global:gpuf()      { git push fork $args }
function global:gpuff()     { git push --set-upstream fork $(git rev-parse --abbrev-ref HEAD) $args }
function global:gpull       { git pull }

function global:gp()        { git stash $args }
function global:gpp()       { git stash pop $args }

function global:gfr()       { gf; gr }
function global:gfrm()      { gf; grm }
function global:gfm()       { gf; grm }
function global:gfrp()      { gp; gfr }
function global:gfrpp()     { gfrp; gpp }
function global:gcp()       { gp; gc $args }
function global:gcpp()      { gcp $args; gpp }
function global:gcmp()      { gp; gcm $args }
function global:gcmpp()     { gcmp $args; gpp }
function global:gcprfr()    { gp; gc $args; gpp }
function global:gpullp()    { gp; gpull }
function global:gpullpp()   { gpullp; gpp }
function global:gclean()    { Write-Host 'git clean script is not implemented on windows.' }

function global:gtar()      { git ls-files -m | tar -cvf unsraged.tar -T - }

# GitHub-Cli
function global:ghc()       { gcpr }
function global:ghr()       { gh pr review }
function global:ghm()       { gh pr merge }
