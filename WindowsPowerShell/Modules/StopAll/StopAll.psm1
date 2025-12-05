# StopAll.psm1
# Enhanced "killall"-style process killer
# Generated using ChatGPT-5.1

function Stop-All {
    <#
    .SYNOPSIS
    Kill processes by executable name (similar to Linux killall).

    .DESCRIPTION
    Supports:
      - Exact match (implicit ".exe")
      - Regex patterns
      - Case-insensitive match
      - Returns objects for scripting
      - Supports ShouldProcess (-WhatIf / -Confirm)

    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string[]]$Name,

        [string]$Pattern,

        [switch]$Force
    )

    begin {
        $results = @()
    }

    process {
        $all = Get-Process -ErrorAction SilentlyContinue

        foreach ($p in $all) {
            $exeLeaf = $null
            try {
                $exeLeaf = Split-Path -Leaf $p.MainModule.FileName
            }
            catch {
                $exeLeaf = "$($p.ProcessName).exe"
            }

            $match = $false

            # Exact name match
            if ($Name) {
                foreach ($n in $Name) {
                    if (-not ($n -like '*.exe')) { $n = "$n.exe" }
                    if ($exeLeaf -ieq $n) { $match = $true }
                }
            }

            # Regex pattern match
            if ($Pattern) {
                if ($exeLeaf -imatch $Pattern) { $match = $true }
            }

            if ($match) {
                $display = "PID $($p.Id) - $exeLeaf"
                if ($PSCmdlet.ShouldProcess($display, "Stop process")) {
                    try {
                        Stop-Process -Id $p.Id -Force:($Force.IsPresent) -ErrorAction Stop
                        Start-Sleep -Milliseconds 150
                        $stillRunning = Get-Process -Id $p.Id -ErrorAction SilentlyContinue

                        $results += [PSCustomObject]@{
                            ProcessId = $p.Id
                            Name      = $exeLeaf
                            Stopped   = ($null -eq $stillRunning)
                        }
                    }
                    catch {
                        $results += [PSCustomObject]@{
                            ProcessId = $p.Id
                            Name      = $exeLeaf
                            Stopped   = $false
                            Error     = $_.Exception.Message
                        }
                    }
                }
            }
        }
    }

    end {
        return $results
    }
}

# Register argument completer for Stop-All
Register-ArgumentCompleter -CommandName Stop-All -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete)

    Get-Process -ErrorAction SilentlyContinue |
    ForEach-Object {
        try {
            Split-Path -Leaf $_.MainModule.FileName
        }
        catch {
            "$($_.ProcessName).exe"
        }
    } |
    Sort-Object -Unique |
    Where-Object { $_ -like "$wordToComplete*" } |
    ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}
