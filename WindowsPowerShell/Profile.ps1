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

# install a hack to disable Steam Big Picture startup animation
# https://www.reddit.com/r/Steam/comments/sf1jnr/disable_steam_big_pictures_annoying_intro_partial/
function dotswt_steamnointro {
    New-Item -ItemType Directory -Path 'C:\Program Files (x86)\Steam\config\uioverrides\movies' -ErrorAction SilentlyContinue
    Invoke-WebRequest -Uri 'https://github.com/freeload101/SCRIPTS/raw/master/MISC/blank.webm' -OutFile 'C:\Program Files (x86)\Steam\config\uioverrides\movies\bigpicture_startup.webm'
}

# Make Ctrl+D exit shell, among other familiar keybinds
# https://stackoverflow.com/a/63022342
Set-PSReadlineOption -EditMode Emacs

# expose just adb from Android SDK, i don't need the whole SDK in my $PATH
function adb {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    & $Env:LocalAppData\Android\Sdk\platform-tools\adb @Args
}
