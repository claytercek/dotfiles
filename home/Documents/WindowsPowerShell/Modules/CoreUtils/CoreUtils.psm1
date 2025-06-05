# CoreUtils PowerShell Module
# Provides wrapper functions for GNU CoreUtils commands

# Module initialization
$script:CoreUtilsCommands = @()

function Get-CoreUtilsCommand {
    [CmdletBinding()]
    param()
    
    return $script:CoreUtilsCommands
}

# Initialize coreutils commands
try {
    # Check if coreutils is available
    if (-not (Get-Command coreutils -ErrorAction SilentlyContinue)) {
        Write-Warning "coreutils command not found. CoreUtils module will not be fully functional."
        return
    }

    $commands = (coreutils --list) -split '\s+' | Where-Object { $_ -ne '' -and $_ -ne '[' }
    
    foreach ($cmd in $commands) {
        # Skip if the command name is invalid, empty, or contains invalid characters
        if ([string]::IsNullOrWhiteSpace($cmd) -or $cmd -match '[^\w-]') { 
            continue 
        }
        
        # Store command in module variable for reference
        $script:CoreUtilsCommands += $cmd

        # Save original alias if it exists
        if ($overrideAlias = Test-Path -Path "Alias:$cmd") {
            $script:originalAlias = (Get-Item -Path "Alias:$cmd").Definition
            Write-Verbose "Overriding existing alias: $cmd (was pointing to $($script:originalAlias))"
        }

        # Create the function in script scope first
        $scriptBlock = [ScriptBlock]::Create("
            function script:$cmd {
                [CmdletBinding()]
                param(
                    [Parameter(ValueFromRemainingArguments=`$true)]
                    [string[]]`$Arguments
                )
                
                & coreutils.exe $cmd @Arguments
            }
        ")
        
        # Execute the scriptblock to create the function
        . $scriptBlock
        
        # Export both function and alias
        Export-ModuleMember -Function $cmd

        if ($overrideAlias) {
            # Override Alias
            New-Alias -Name $cmd -Value "script:$cmd" -Force -Scope Global -Option AllScope
            Export-ModuleMember -Alias $cmd
        }
    }
    
    Write-Verbose "CoreUtils module loaded with $($script:CoreUtilsCommands.Count) commands"
}
catch {
    Write-Warning "Failed to initialize CoreUtils module: $($_.Exception.Message)"
}

# Export the helper function
Export-ModuleMember -Function Get-CoreUtilsCommand
