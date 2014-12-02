colo elflord

set nocp
set colorcolumn=120
set number
set ruler
set nobackup
set smartindent
set textwidth=0
set ts=4 sw=4
set hlsearch
set incsearch
syntax on
filetype plugin indent on

set foldmethod=syntax
set foldnestmax=2
let xml_syntax_folding=1

let g:SuperTabDefaultCompletionType="context"

nnoremap t :NERDTreeToggle<CR>

nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprev<CR>

if has("unix")
	command -nargs=? Swrite :w !sudo tee %
endif

