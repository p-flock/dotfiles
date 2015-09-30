".vimrc file for FreshPeter
"
" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" so shit will work
set modifiable

" colorscheme of choice
syntax enable
set t_Co=256
"set background=dark
"let g:solarized_termcolors=256
colorscheme behelit
hi Normal ctermbg=NONE

" let vundle handle my (plugins)
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" My Bundles
"
" close my parenthesis for me
Plugin 'Raimondi/delimitMate'
" So it looks fresh af
Plugin 'aflock/vim-colorpack'
" checks for errors
Plugin 'Syntastic'
" specific for looking fresh af
Plugin 'altercation/vim-colors-solarized'
Plugin 'atweiden/vim-colors-behelit'
" Sick completion engine so I do less work
"Plugin 'Valloric/YouCompleteMe' "doesn't work idk why
" Easy motion
Plugin 'Lokaltog/vim-easymotion'
" visually identify indent level
Plugin 'nathanaelkane/vim-indent-guides'
" NerdTree but is broken?
Plugin 'scrooloose/nerdtree'
" Snippets
Plugin 'UltiSnips'
" Indent lines
Plugin 'Yggdroot/indentLine'
" Supertab
Plugin 'Supertab'
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine.
Plugin 'honza/vim-snippets'
" Lumberjack colors
Plugin 'yamafaktory/lumberjack.vim'
" Orgasmic commenting, I'm told
Plugin 'scrooloose/nerdcommenter'
" Gotham colorscheme when I feel like Brooding
Plugin 'whatyouhide/vim-gotham'
" in case things get *too* easy
Plugin 'wikitopian/hardmode'
" semantic highlighting
Plugin 'jaxbot/semantic-highlight.vim'
" goyo, distraction free writing
Plugin 'junegunn/goyo.vim'

call vundle#end()


"turns syntax highlighting on
syntax on
filetype plugin indent on
set nocompatible
set number
"set relativenumber

" enable all Python syntax highlighting features
let python_highlight_all = 1

"mappings"
"jk gets to escape
inoremap jk <Esc>

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" (comma-m) map to save my code and compile it (Java)
map <silent> ,m :wall<CR>:make<CR>

" NerdTree Toggle
nmap t :NERDTreeToggle<CR>
"nmap tt :NerdTreeClose<CR> " turns out not necessary

" Trigger Ultisnips
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" UltiSnipsEdit splits window
let g:UltiSnipsEditSplit="vertical"

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

" toggle semantic highlighting with \s
nnoremap <Leader>s :SemanticHighlightToggle<cr>

" Spaces are better than a tab character
set expandtab
set smarttab

set shiftwidth=4
set softtabstop=4
set tabstop=4

" split management
set splitbelow
set splitright

" Ever want to write java? cool, compile and run in buffer
" F9/F10 compile/run default file.
" F11/F12 compile/run alternate file.

map <F9> :set makeprg=javac\ %<CR>:make<CR>
map <F10> :!echo %\|awk -F. '{print $1}'\|xargs java<CR>
map <F11> :set makeprg=javac\ #<CR>:make<CR>
map <F12> :!echo #\|awk -F. '{print $1}'\|xargs java<CR>

map! <F9> <Esc>:set makeprg=javac\ %<CR>:make<CR>
map! <F10> <Esc>:!echo %\|awk -F. '{print $1}'\|xargs java<CR>
map! <F11> <Esc>set makeprg=javac\ #<CR>:make<CR>
map! <F12> <Esc>!echo #\|awk -F. '{print $1}'\|xargs java<CR>

" Tip: load a file into the default buffer, and its driver
" " into the alternate buffer, then use F9/F12 to build/run.
" " Note: # (alternate filename) isn't set until you :next to it!
" " Tip2: You can make then run without hitting ENTER to continue. F9-F12
"
" " With these you can cl/cn/cp (quickfix commands) to browse the errors
" " after you compile it with :make

set makeprg=javac\ %
set errorformat=%A:%f:%l:\ %m,%-Z%p^,%-C%.%#

" " If two files are loaded, switch to the alternate file, then back.
" " That sets # (the alternate file).
if argc() == 2
    n
    e #
endif
