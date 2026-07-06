# Enable oh-my-posh
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/pure.omp.json" | Invoke-Expression

# Enable starship
Invoke-Expression (&starship init powershell)
# Enable-TransientPrompt

# Enable zoxide
Invoke-Expression (& { (zoxide.exe init powershell | Out-String) })

# Let microsoft/coreutils win over built-in PowerShell aliases of the same name
# (PowerShell resolves Alias > Function > Cmdlet > Application, so PATH order alone
# never lets these .exe's take precedence; the aliases must be removed instead)
$coreutilsAliases = 'cat','cp','echo','ls','mv','pwd','rm','rmdir','sleep','sort','tee'
foreach ($name in $coreutilsAliases) {
    if (Test-Path "Alias:$name") {
        Remove-Item "Alias:$name" -Force -ErrorAction SilentlyContinue
    }
}

$env:ROSETTA_DIR=".afk\rosetta"
$env:SLATE_DIR=".afk\slate"
$env:ROSETTA_SLATE_ROOT=".afk\slate"