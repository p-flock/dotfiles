call plug#begin('~/.local/share/nvim/plugged')
-- pretty typing for notes etc
Plug 'junegunn/goyo.vim'

-- tree sitter and telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  -- We recommend updating the parsers on update
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

-- nerdtree
Plug 'preservim/nerdtree'
--comment me
Plug 'scrooloose/nerdcommenter'

-- vue syntax highlighting
Plug 'posva/vim-vue'

-- colo scheme
Plug 'morhetz/gruvbox'
Plug 'yashguptaz/calvera-dark.nvim'
Plug 'cocopon/iceberg.vim'
Plug 'tomasr/molokai'
Plug 'fmoralesc/molokayo'
Plug 'sts10/vim-pink-moon'

--git stuff
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'

-- assuming your using vim-plug: https://github.com/junegunn/vim-plug
--Plug 'ncm2/ncm2'
--ncm2 requires nvim-yarp
Plug 'roxma/nvim-yarp'
--some completion sources

--Plug 'ncm2/ncm2-path'
--Plug 'ncm2/ncm2-tern',  {'do':'npm install'}

Plug 'vim-airline/vim-airline'
-- vim wiki
Plug 'https://github.com/vimwiki/vimwiki'

--Plug 'RRethy/vim-illuminate'
--linting
Plug 'w0rp/ale'

--ctags viewing
Plug 'majutsushi/tagbar'

Plug 'rust-lang/rust.vim'

-- brrrrrackt matching
Plug 'Raimondi/delimitMate'

call plug#end()
