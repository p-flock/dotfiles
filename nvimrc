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

set updatetime=500
" normal copy
xnoremap <C-c> "*y :let @+=@*<CR>



" save files when focus is lost
filetype on                  " required



call plug#begin('~/.local/share/nvim/plugged')
" pretty typing for notes etc
Plug 'junegunn/goyo.vim'

" run prettier
Plug 'sbdchd/neoformat'

" lint support with built-in language server
Plug 'mfussenegger/nvim-lint'

" jsx ugh
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" tree sitter and telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
Plug 'ThePrimeagen/harpoon'

" Generate github links to code snippets
Plug 'ruifm/gitlinker.nvim'


" nerdtree
Plug 'preservim/nerdtree'
"comment me
Plug 'scrooloose/nerdcommenter'

" Copilot
Plug 'github/copilot.vim'

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

" vim wiki
Plug 'https://github.com/vimwiki/vimwiki'

"Plug 'RRethy/vim-illuminate'

"ctags viewing
Plug 'majutsushi/tagbar'

Plug 'rust-lang/rust.vim'

" brrrrrackt matching
Plug 'Raimondi/delimitMate'

call plug#end()

" use local prettier config and run on save
let g:neoformat_try_node_exe = 1

" completion setup
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    enabled = function()
      local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
      if in_prompt then  -- this will disable cmp in the Telescope window (taken from the default config)
          return false
      end
      local context = require("cmp.config.context")
      return not(context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
      end,
    window = {
      completion = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
      },
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    performance = {
      debounce = 60,
      throttle = 30,
      confirm_resolve_timeout = 80,
      max_view_entries = 15,
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })


  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end


  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }

   -- Function to check if a floating dialog exists and if not
  -- then check for diagnostics under the cursor
  function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    -- THIS IS FOR BUILTIN LSP
    vim.diagnostic.open_float(0, {
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
  end
  -- Show diagnostics under the cursor when holding position
  vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    command = "lua OpenDiagnosticIfNoFloat()",
    group = "lsp_diagnostics_hold",
  })

  -- set up eslint for js and ts
  require('lint').linters_by_ft = {
     javascript = {'eslint'},
     typescript = {'eslint'},
     javascriptreact = {'eslint'},
     typescriptreact = {'eslint'}
  }

EOF


let js_fixers = ['prettier', 'eslint']




nnoremap <leader>d :lua =vim.lsp.buf.definition()<CR>
nnoremap <leader>s :vsplit<CR> :lua =vim.lsp.buf.definition()<CR>
nnoremap <leader>rn :lua =vim.lsp.buf.rename()<CR>
nnoremap K :lua =vim.lsp.buf.hover()<CR>
nnoremap <leader>co :lua =vim.lsp.buf.code_action()<CR>
nnoremap <leader>rf :lua =vim.lsp.buf.references()<CR>
nnoremap <leader>l :LspRestart<CR>


" Harpoon commands
nnoremap <leader>h :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>


" Use <TAB> to select the popup menu:
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()

" :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone


"NERDtree settings
nnoremap <leader>t :NERDTreeClose<CR>
nnoremap <C-t> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <C-f> :NERDTreeFind<CR>

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
  max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 1, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = '-',
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

require"gitlinker".setup()
EOF


" telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>

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
" move through quickfix/reference list
nnoremap <C-o> :cn<CR>
nnoremap <C-p> :cp<CR>

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

set textwidth=80

" split management
set splitbelow
set splitright

"format on save
augroup fmt
  autocmd!
  autocmd BufWritePre *.ts* undojoin | Neoformat
augroup END

au BufWritePost * lua require('lint').try_lint()


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
