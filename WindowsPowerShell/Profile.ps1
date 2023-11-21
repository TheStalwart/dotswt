function l {
    eza -G
}

function la {
    eza -aG
}

# https://stackoverflow.com/questions/19663202/how-do-you-open-sourcetree-from-the-command-line
function stree {
    # https://pureinfotech.com/list-environment-variables-windows-10/
    & $Env:LocalAppData\SourceTree\SourceTree.exe -f (Get-Location)
}
