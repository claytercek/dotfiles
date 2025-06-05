oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/pure.omp.json" | Invoke-Expression
Import-Module CoreUtils -Global -DisableNameChecking

Invoke-Expression (& { (zoxide.exe init powershell | Out-String) })
