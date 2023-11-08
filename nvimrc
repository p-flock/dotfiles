".vimrc file for FreshPeter
"
" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" so shit will work
set modifiable

" see commands in the bottom
set showcmd

set noswapfile

set ignorecase
set smartcase


" save files when focus is lost
filetype on                  " required


let g:ale_set_balloons = 1
let g:ale_hover_cursor = 1
let g:ale_hover_to_floating_preview = 1
let g:ale_floating_preview = 1
let g:ale_cursor_detail = 1
let g:ale_close_preview_on_insert = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
call plug#begin('~/.local/share/nvim/plugged')
" pretty typing for notes etc
Plug 'junegunn/goyo.vim'

" tree sitter and telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'ThePrimeagen/harpoon'



" nerdtree
Plug 'preservim/nerdtree'
"comment me
Plug 'scrooloose/nerdcommenter'

" colo scheme
Plug 'morhetz/gruvbox'
Plug 'yashguptaz/calvera-dark.nvim'
Plug 'cocopon/iceberg.vim'
Plug 'tomasr/molokai'
Plug 'fmoralesc/molokayo'
Plug 'sts10/vim-pink-moon'
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
Plug 'tanvirtin/monokai.nvim'

"git stuff
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'

" assuming your using vim-plug: https://github.com/junegunn/vim-plug
"Plug 'ncm2/ncm2'
"ncm2 requires nvim-yarp
Plug 'roxma/nvim-yarp'
"some completion sources

"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-tern',  {'do':'npm install'}

Plug 'vim-airline/vim-airline'
" vim wiki
Plug 'https://github.com/vimwiki/vimwiki'

"Plug 'RRethy/vim-illuminate'
"linting
Plug 'dense-analysis/ale'

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

let js_fixers = ['prettier', 'eslint']

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': js_fixers,
\   'javascript.jsx': js_fixers,
\   'typescript': js_fixers,
\   'typescriptreact': js_fixers,
\   'css': ['prettier'],
\   'json': ['prettier'],
\}


" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.

nnoremap <leader>sd :ALEGoToDefinition -vsplit<CR>
nnoremap <leader>d :ALEGoToDefinition<CR>
nnoremap <leader>a :ALEHover<CR>
nnoremap <leader>co :ALECodeAction<CR>


" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()

" :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone


"NERDtree settings
nnoremap <leader>t :NERDTreeClose<CR>
nnoremap <C-t> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


let g:Illuminate_delay = 500
"Don't highlight word under cursor (default: 1)
let g:Illuminate_highlightUnderCursor = 0


" colorscheme of choice
syntax enable
"set t_Co=256
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"set background=dark
"hi Normal ctermbg=NONE
colorscheme monokai
"
"turns syntax highlighting on
syntax on
filetype plugin indent on
set nocompatible
set number relativenumber
" space is leader
noremap <Space> <Nop>
map <Space> <Leader>
" enable all Python syntax highlighting features
let python_highlight_all = 1


lua <<EOF
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    vim.bo[ev.buf].formatexpr = nil
    vim.bo[ev.buf].omnifunc = nil
    vim.keymap.del("n", "K", { buffer = ev.buf })
  end,
})
EOF

" tree sitter stuff
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF
lua <<EOF
require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 3, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = '-',
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
EOF


" telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>df <cmd>lua require'telescope.builtin'.grep_string{}<cr>

" highlight on yank
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

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

" <leader>af to run ALEFix , <leader>aa to go to first error
nnoremap <leader>af :ALEFix<CR>
nnoremap <leader>aa :ALEFirst<CR>

" leader r refreshes current file
nnoremap <leader>r :e! %<CR>

" leader = to indent whole file
nnoremap <leader>= gg=G``

" open Magit buffer
nnoremap <leader>g :Magit<CR>

" split management
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Zoom in / out of a split
noremap ZZ <c-w>_ \| <c-w>\|
noremap ZO <c-w>=

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


" " If two files are loaded, switch to the alternate file, then back.
" " That sets # (the alternate file).
if argc() == 2
  n
  e #
endif
