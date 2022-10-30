
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
map <Leader>ff <cmd>Telescope file_browser<cr>

Plug 'ervandew/supertab'

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

Plug 'Vimjas/vim-python-pep8-indent'

" Always show the signcolumn, otherwise it would shift the text each time
set signcolumn=yes

Plug 'github/copilot.vim'
