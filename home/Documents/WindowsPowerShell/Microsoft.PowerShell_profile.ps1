oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/pure.omp.json" | Invoke-Expression


# TODO: convert to powerhell module?
# Get all coreutils commands and create PowerShell aliases for them
try {
  # Check if coreutils is available before proceeding
  if (-not (Get-Command coreutils -ErrorAction SilentlyContinue)) {
    Write-Warning "coreutils command not found. Skipping coreutils aliases setup."
    return
  }

  $coreutilsCommands = (coreutils --list) -split '\s+' | Where-Object { $_ -ne '' -and $_ -ne '[' }
  
  foreach ($cmd in $coreutilsCommands) {
    # Skip if the command name is invalid, empty, or contains invalid characters
    if ([string]::IsNullOrWhiteSpace($cmd) -or $cmd -match '[^\w-]') { 
      continue 
    }
    
    # Create a function that points to the coreutils command
    $functionName = $cmd
    $scriptBlock = [ScriptBlock]::Create("param(`$args) & coreutils.exe $cmd @args")
    
    # Remove any existing alias with the same name to avoid conflicts
    Remove-Item -Path "Alias:$functionName" -Force -ErrorAction SilentlyContinue

    # Use Set-Item to create a function in the global scope
    Set-Item -Path "Function:Global:$functionName" -Value $scriptBlock -Force
  }
  
  Write-Verbose "Successfully created coreutils functions for $($coreutilsCommands.Count) commands"
}
catch {
  Write-Warning "Failed to create coreutils functions: $($_.Exception.Message)"
}