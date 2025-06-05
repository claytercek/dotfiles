# CoreUtils PowerShell Module
# Provides wrapper functions for GNU CoreUtils commands

# Module initialization
$script:CoreUtilsCommands = @()


# Simple wrapper functions for GNU CoreUtils commands

function arch {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe arch @Arguments
}

function b2sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe b2sum @Arguments
}

function b3sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe b3sum @Arguments
}

function base32 {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe base32 @Arguments
}

function base64 {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe base64 @Arguments
}

function basename {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe basename @Arguments
}

function basenc {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe basenc @Arguments
}

function cat {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe cat @Arguments
}

function cksum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe cksum @Arguments
}

function comm {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe comm @Arguments
}

function cp {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe cp @Arguments
}

function csplit {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe csplit @Arguments
}

function cut {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe cut @Arguments
}

function date {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe date @Arguments
}

function dd {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe dd @Arguments
}

function df {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe df @Arguments
}

function dir {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe dir @Arguments
}

function dircolors {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe dircolors @Arguments
}

function dirname {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe dirname @Arguments
}

function du {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe du @Arguments
}

function echo {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe echo @Arguments
}

function env {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe env @Arguments
}

function expand {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe expand @Arguments
}

function expr {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe expr @Arguments
}

function factor {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe factor @Arguments
}

function false {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe false @Arguments
}

function fmt {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe fmt @Arguments
}

function fold {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe fold @Arguments
}

function hashsum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe hashsum @Arguments
}

function head {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe head @Arguments
}

function hostname {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe hostname @Arguments
}

function join {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe join @Arguments
}

function link {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe link @Arguments
}

function ln {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe ln @Arguments
}

function ls {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe ls @Arguments
}

function md5sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe md5sum @Arguments
}

function mkdir {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe mkdir @Arguments
}

function mktemp {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe mktemp @Arguments
}

function more {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe more @Arguments
}

function mv {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe mv @Arguments
}

function nl {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe nl @Arguments
}

function nproc {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe nproc @Arguments
}

function numfmt {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe numfmt @Arguments
}

function od {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe od @Arguments
}

function paste {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe paste @Arguments
}

function pr {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe pr @Arguments
}

function printenv {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe printenv @Arguments
}

function printf {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe printf @Arguments
}

function ptx {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe ptx @Arguments
}

function pwd {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe pwd @Arguments
}

function readlink {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe readlink @Arguments
}

function realpath {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe realpath @Arguments
}

function rm {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe rm @Arguments
}

function rmdir {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe rmdir @Arguments
}

function seq {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe seq @Arguments
}

function sha1sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sha1sum @Arguments
}

function sha224sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sha224sum @Arguments
}

function sha256sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sha256sum @Arguments
}

function sha3-224sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sha3-224sum @Arguments
}

function sha3-256sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sha3-256sum @Arguments
}

function sha3-384sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sha3-384sum @Arguments
}

function sha3-512sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sha3-512sum @Arguments
}

function sha384sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sha384sum @Arguments
}

function sha3sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sha3sum @Arguments
}

function sha512sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sha512sum @Arguments
}

function shake128sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe shake128sum @Arguments
}

function shake256sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe shake256sum @Arguments
}

function shred {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe shred @Arguments
}

function shuf {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe shuf @Arguments
}

function sleep {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sleep @Arguments
}

function sort {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sort @Arguments
}

function split {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe split @Arguments
}

function sum {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sum @Arguments
}

function sync {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe sync @Arguments
}

function tac {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe tac @Arguments
}

function tail {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe tail @Arguments
}

function tee {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe tee @Arguments
}

function test {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe test @Arguments
}

function touch {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe touch @Arguments
}

function tr {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe tr @Arguments
}

function true {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe true @Arguments
}

function truncate {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe truncate @Arguments
}

function tsort {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe tsort @Arguments
}

function uname {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe uname @Arguments
}

function unexpand {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe unexpand @Arguments
}

function uniq {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe uniq @Arguments
}

function unlink {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe unlink @Arguments
}

function vdir {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe vdir @Arguments
}

function wc {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe wc @Arguments
}

function whoami {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe whoami @Arguments
}

function yes {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments= $true)]
        [string[]]$Arguments
    )
    
    & coreutils.exe yes @Arguments
}


# Create aliases for GNU CoreUtils commands to override PowerShell built-in aliases

New-Alias -Name cat -Value "script:cat" -Force -Scope Global -Option AllScope
New-Alias -Name cp -Value "script:cp" -Force -Scope Global -Option AllScope
New-Alias -Name dir -Value "script:dir" -Force -Scope Global -Option AllScope
New-Alias -Name echo -Value "script:echo" -Force -Scope Global -Option AllScope
New-Alias -Name ls -Value "script:ls" -Force -Scope Global -Option AllScope
New-Alias -Name mv -Value "script:mv" -Force -Scope Global -Option AllScope
New-Alias -Name pwd -Value "script:pwd" -Force -Scope Global -Option AllScope
New-Alias -Name rm -Value "script:rm" -Force -Scope Global -Option AllScope
New-Alias -Name rmdir -Value "script:rmdir" -Force -Scope Global -Option AllScope
New-Alias -Name sleep -Value "script:sleep" -Force -Scope Global -Option AllScope
New-Alias -Name sort -Value "script:sort" -Force -Scope Global -Option AllScope
New-Alias -Name tee -Value "script:tee" -Force -Scope Global -Option AllScope
