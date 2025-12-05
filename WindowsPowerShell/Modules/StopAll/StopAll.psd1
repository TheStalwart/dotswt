@{
    RootModule        = 'StopAll.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'd3d7a61a-8c5d-4cfd-9c2c-89bcd2e0f1f5'
    Author            = 'ChatGPT-5.1'
    CompanyName       = 'Private'
    PowerShellVersion = '5.1'
    Description       = 'Provides Stop-All: a killall-like command for Windows.'

    FunctionsToExport = @('Stop-All')
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()

    PrivateData       = @{ }
}
