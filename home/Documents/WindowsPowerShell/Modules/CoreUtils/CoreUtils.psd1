@{
    RootModule = 'CoreUtils.psm1'
    ModuleVersion = '1.0.0'
    GUID = '68e9021e-4b8d-4eaa-8f0f-6c88c0f19c61'  # Generated GUID
    Author = 'Clay Tercek'
    Description = 'PowerShell module to create wrapper functions for uutils Coreutils commands'
    PowerShellVersion = '5.1'
    FunctionsToExport = @('*')  # Explicitly include helper function
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @('*')
    PrivateData = @{
        PSData = @{
            Tags = @('Coreutils', 'gnu', 'uutils')
        }
    }
}
