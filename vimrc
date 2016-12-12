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
set scrolloff=5
syntax on
filetype plugin indent on
au BufRead,BufNewFile Podfile set filetype=ruby

set wildignore+=*.png,*.jpg,*.atf,*.tps							" Images
set wildignore+=*.jar,*.class 									" Java
set wildignore+=*.fla,*.swf,*.swc,*.ane,*.as3proj,*/META-INF/* 	" Flash
set wildignore+=*/res/drawable/*,*/res/layout/*,*/smali/* 		" Android
set wildignore+=*/*.framework/*,*/*.bundle/*,*/xcuserdata/* 	" Xcode
set wildignore+=.DS_Store 										" OS X

"set foldmethod=syntax
"set foldnestmax=2
"let xml_syntax_folding=1

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
call plug#end()

let g:SuperTabDefaultCompletionType="context"

let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 'ra'

nnoremap t :NERDTreeToggle<CR>

nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprev<CR>

if has("unix")
	command -nargs=? Swrite :w !sudo tee %
endif

