oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/pure.omp.json" | Invoke-Expression

# Time the CoreUtils module import
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
Import-Module CoreUtils -Global -DisableNameChecking
$stopwatch.Stop()

# Log the result
$loadTime = $stopwatch.ElapsedMilliseconds
Write-Host "CoreUtils module loaded in $loadTime ms" -ForegroundColor Green