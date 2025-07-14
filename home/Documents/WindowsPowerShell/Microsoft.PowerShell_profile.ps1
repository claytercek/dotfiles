# Enable oh-my-posh
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/pure.omp.json" | Invoke-Expression

# Enable starship
Invoke-Expression (&starship init powershell)
# Enable-TransientPrompt

# enable Uutils CoreUtils
Import-Module CoreUtils -Global -DisableNameChecking

# Enable zoxide
Invoke-Expression (& { (zoxide.exe init powershell | Out-String) })
