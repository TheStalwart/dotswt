colo elflord

set nocp

set number
set nobackup
set smartindent
set textwidth=0

if has("unix")
	command -nargs=? Swrite :w !sudo tee %
endif

