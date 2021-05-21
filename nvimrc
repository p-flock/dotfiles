".vimrc file for FreshPeter
"
" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" so shit will work
set modifiable

" see commands in the bottom
set showcmd

set noswapfile

" save files when focus is lost
filetype off                  " required


call plug#begin('~/.local/share/nvim/plugged')
" pretty typing for notes etc
Plug 'junegunn/goyo.vim'

"comment me
Plug 'scrooloose/nerdcommenter'
" colo scheme
Plug 'morhetz/gruvbox'
"git stuff
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'

" assuming your using vim-plug: https://github.com/junegunn/vim-plug
Plug 'ncm2/ncm2'
"ncm2 requires nvim-yarp
Plug 'roxma/nvim-yarp'
"some completion sources

Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}

Plug 'vim-airline/vim-airline'
" vim wiki
Plug 'https://github.com/vimwiki/vimwiki'

"Plug 'RRethy/vim-illuminate'
"linting
Plug 'w0rp/ale'

"ctags viewing
Plug 'majutsushi/tagbar'

Plug 'rust-lang/rust.vim'

" brrrrrackt matching
Plug 'Raimondi/delimitMate'

call plug#end()

" airline
"let g:airline_extensions = ['vimagit']
let g:airline#extensions#vimagit#enabled = 1
let g:airline#extensions#fugitive = 1

"Linting for python and js
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['autopep8'],
\   'haskell': ['ghc'],
\}
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" open tagbar with f8
nmap <F8> :TagbarToggle<CR>
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone


let g:Illuminate_delay = 500
"Don't highlight word under cursor (default: 1)
let g:Illuminate_highlightUnderCursor = 0

" colorscheme of choice
syntax enable
set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
hi Normal ctermbg=NONE
colorscheme gruvbox
"
"turns syntax highlighting on
syntax on
filetype plugin indent on
set nocompatible
set number
" leader is comma
let mapleader=","
" enable all Python syntax highlighting features
let python_highlight_all = 1


"mappings"
"jk gets to escape
inoremap jk <Esc>
nnoremap <leader>e :set wrap!<CR>
" complete w/ tab for nvim completion manager
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ; is : so I don't have to shift
nnoremap ; :
nnoremap : ;


"swap areas of text
vnoremap <C-X> <Esc>`.`gvP``P

" split management
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable mouse use in all modes
set mouse=a

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz
map gg ggzz
map G Gzz


" esc terminal mode in a sane way
tnoremap <c-\> <c-\><c-n>

" Spaces are better than a tab character
set expandtab
set smarttab

set shiftwidth=2
set softtabstop=2
set tabstop=2

" split management
set splitbelow
set splitright


" netrw / file browser stuff
let g:netrw_browse_split = 3
let g:netrw_liststyle = 3
let g:netrw_winsize = 18
" tab stuff
nnoremap <C-M> :tabNext<cr>

" vimwiki remaps
nmap <Leader>wq <Plug>VimwikiVSplitLink


" " If two files are loaded, switch to the alternate file, then back.
" " That sets # (the alternate file).
if argc() == 2
    n
    e #
endif

