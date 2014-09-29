colo elflord

set nocp

set number
set nobackup
set smartindent
set textwidth=0
set ts=4 sw=4
set hlsearch
syntax on
filetype plugin on

if has("unix")
	command -nargs=? Swrite :w !sudo tee %
endif

