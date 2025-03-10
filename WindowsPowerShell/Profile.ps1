function l {
    eza -G
}

function la {
    eza -aG
}

function gds {
    git diff; if ($?) { git status }
}

# https://stackoverflow.com/questions/19663202/how-do-you-open-sourcetree-from-the-command-line
function stree {
    # https://pureinfotech.com/list-environment-variables-windows-10/
    & $Env:LocalAppData\SourceTree\SourceTree.exe -f (Get-Location)
}

function uptime {
    try {
        Get-Uptime
    }
    Catch { 
        Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime
    }
}

# alias for GNU diff
function gdiff {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    & "C:\Program Files\git\usr\bin\diff" "--color=auto" @Args
}

# Make Ctrl+D exit shell, among other familiar keybinds
# https://stackoverflow.com/a/63022342
Set-PSReadlineOption -EditMode Emacs
