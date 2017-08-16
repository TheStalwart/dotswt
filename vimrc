if has('nvim')
	language messages en_US
endif

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
set laststatus=2
set wildmenu
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
Plug 'vim-airline/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'
Plug 'benjifisher/matchit.zip'
Plug 'molok/vcscommand.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'mhinz/vim-signify'
Plug 'cfdrake/vim-pbxproj'
Plug 'tomtom/tlib_vim'
Plug 'endel/flashdevelop.vim'
call plug#end()

let g:SuperTabDefaultCompletionType="context"

let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 'ra'

nnoremap t :NERDTreeToggle<CR>

nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprev<CR>

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" vim-better-whitespace
autocmd BufWritePre * StripWhitespace

nnoremap <C-l> :set list!<CR>

if has("unix")
	command -nargs=? Swrite :w !sudo tee %
endif

