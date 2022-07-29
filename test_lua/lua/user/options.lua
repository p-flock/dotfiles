--.vimrc file for FreshPeter
--

-- -- -- -- --
--  OPTIONS --
-- -- -- -- --

local options = {
  modifiable = true,
  showcmd = true

  swapfile = false

  ignorecase = true
  smartcase = true
  -- split management
  splitbelow = true
  splitright = true

  compatible = false
  number = true
}
-- set options
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Remove any trailing whitespace that is in the file
vim.cmd "autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif"


-- see commands in the bottom
set showcmd

-- save files when focus is lost
filetype off                  -- required



-- airline
--let g:airline_extensions = ['vimagit']
let g:airline#extensions#vimagit#enabled = 1
let g:airline#extensions#fugitive = 1

let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {'vue': ['eslint', 'vls']}
-- Enable completion where available.
-- This setting must be set before ALE is loaded.
--
-- You should not turn this setting on if you wish to use ALE as a completion
-- source for other completion plugins, like Deoplete.
let g:ale_completion_enabled = 1

-- Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? --\<C-n>-- : --\<Tab>--
inoremap <expr> <S-Tab> pumvisible() ? --\<C-p>-- : --\<S-Tab>--

-- open tagbar with f8
nmap <F8> :TagbarToggle<CR>
-- enable ncm2 for all buffers
--autocmd BufEnter * call ncm2#enable_for_buffer()

-- :help Ncm2PopupOpen for more information
--set completeopt=noinsert,menuone


--NERDtree settings
nnoremap <leader>t :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

let g:Illuminate_delay = 500
--Don't highlight word under cursor (default: 1)
let g:Illuminate_highlightUnderCursor = 0


-- colorscheme of choice
syntax enable
--set t_Co=256
--let $NVIM_TUI_ENABLE_TRUE_COLOR=1
--set background=dark
--hi Normal ctermbg=NONE
colorscheme iceberg
--
--turns syntax highlighting on
syntax on
filetype plugin indent on
-- space is leader
noremap <Space> <Nop>
map <Space> <Leader>
-- enable all Python syntax highlighting features
let python_highlight_all = 1


-- tree sitter stuff
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = --maintained--, -- one of --all--, --maintained-- (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

-- telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>df <cmd>lua require'telescope.builtin'.grep_string{}<cr>

-- highlight on yank
au TextYankPost * lua vim.highlight.on_yank {higroup=--IncSearch--, timeout=150, on_visual=true}

--mappings--
--jk gets to escape
inoremap jk <Esc>
nnoremap <leader>e :set wrap!<CR>
-- complete w/ tab for nvim completion manager
inoremap <expr> <Tab> pumvisible() ? --\<C-n>-- : --\<Tab>--
inoremap <expr> <S-Tab> pumvisible() ? --\<C-p>-- : --\<S-Tab>--

-- ; is : so I don't have to shift
nnoremap ; :
nnoremap : ;

-- <leader>af to run ALEFix , <leader>aa to go to first error
nnoremap <leader>af :ALEFix<CR>
nnoremap <leader>aa :ALEFirst<CR>

-- leader r refreshes current file
nnoremap <leader>r :e! %<CR>

-- leader = to indent whole file
nnoremap <leader>= gg=G``

-- open Magit buffer
nnoremap <leader>g :Magit<CR>

-- split management
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

-- Enable mouse use in all modes
set mouse=a

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
map N Nzz
map n nzz
map gg ggzz
map G Gzz


-- esc terminal mode in a sane way
tnoremap <c-\> <c-\><c-n>

-- Spaces are better than a tab character
set expandtab
set smarttab

set shiftwidth=2
set softtabstop=2
set tabstop=2



-- netrw / file browser stuff
let g:netrw_browse_split = 3
let g:netrw_liststyle = 3
let g:netrw_winsize = 18
-- tab stuff
nnoremap <C-M> :tabNext<cr>


-- -- If two files are loaded, switch to the alternate file, then back.
-- -- That sets # (the alternate file).
if argc() == 2
  n
  e #
endif

