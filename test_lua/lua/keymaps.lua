local opts = { noremap = true, silent = true }
-- -- -- -- --
--  KEYMAPS --
-- -- -- -- --

local keymap = vim.api.nvim_set_keymap

-- space is leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal       = "n"
--   insert       = "i"
--   visual       = "v"
--   visual_block = "x"
--   term         = "t"
--   command      = "x"


-- Normal Mode --
-- Window nav / split management
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)


-- Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? --\<C-n>-- : --\<Tab>--
inoremap <expr> <S-Tab> pumvisible() ? --\<C-p>-- : --\<S-Tab>--
--
-- open tagbar with f8
nmap <F8> :TagbarToggle<CR>
--
--NERDtree settings
nnoremap <leader>t :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>


-- telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>df <cmd>lua require'telescope.builtin'.grep_string{}<cr>

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


-- esc terminal mode in a sane way
tnoremap <c-\> <c-\><c-n>

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
map N Nzz
map n nzz
map gg ggzz
map G Gzz

