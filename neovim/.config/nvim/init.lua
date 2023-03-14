local root = vim.fn.expand('~/.config/nvim/')

vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Gruvbox theme
    use 'morhetz/gruvbox'

    -- Git diff in the sign column
    use 'airblade/vim-gitgutter'

    use 'nvim-treesitter/nvim-treesitter'

    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Autocomplete with github copilot
    use 'github/copilot.vim'

    -- Commenting with gcc
    use 'tpope/vim-commentary'

    -- Automatic closing of brackets, quotes, etc.
    use 'windwp/nvim-autopairs'

    -- Telescope for searching
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, { "cljoly/telescope-repo.nvim" } }
    }
    use 'nvim-telescope/telescope-file-browser.nvim'

    -- Which key: show keybindings when you don't know them
    -- (wait a little bit after pressing a key)
    use 'folke/which-key.nvim'

    -- Git integration: so useful it should be illegal
    use 'tpope/vim-fugitive'

    -- LSP (Language Server Protocol) for autocompletion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'ervandew/supertab'
    use 'nvim-lua/plenary.nvim'

    -- Dashboard
    use 'goolord/alpha-nvim'

    -- Colorizer: #ff0000 -> red
    use 'norcalli/nvim-colorizer.lua'

    -- Nerdtree (file explorer)
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons' -- optional, for file icons
        }
    }

    -- Changes Vim working directory to project root (git, mercurial, etc.)
    use 'airblade/vim-rooter'

    -- Highlight todos (write todo in all caps to highlight)
    use "folke/todo-comments.nvim"

    -- Guess indentation style of buffers
    use "NMAC427/guess-indent.nvim"

    -- Fountain screenplay format
    use 'kblin/vim-fountain'

    -- Some icons
    use 'nvim-tree/nvim-web-devicons'

    -- Show diagnostics with :Trouble
    use 'folke/trouble.nvim'

    -- orgmode like with emacs
    use "nvim-orgmode/orgmode"
end)

vim.cmd [[colorscheme gruvbox]]
dofile(root .. "packs/treesitter.lua")
dofile(root .. "packs/lualine.lua")
dofile(root .. "packs/whichkey.lua")
dofile(root .. "packs/lsp.lua")
dofile(root .. "packs/alpha.lua")
dofile(root .. "packs/nvim-tree.lua")
vim.opt.termguicolors = true
require'colorizer'.setup()
require'telescope'.load_extension'repo'
vim.g['rooter_cd_cmd'] = 'lcd'
require("nvim-autopairs").setup {}
dofile(root .. "packs/todo.lua")
require('guess-indent').setup {}
require('trouble').setup {}

-- enable copilot for yaml files
vim.cmd [[
let g:copilot_filetypes = {'yaml': v:true}
]]


vim.opt.rnu = true

vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.linebreak = true

vim.opt.swapfile = false

vim.opt.clipboard = "unnamedplus"

vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.local/share/nvim/undodir')


vim.opt.scrolloff = 1

vim.opt.autoread = true


vim.cmd.highlight('SignColumn', 'guibg=NONE')
-- same for gitgutter signs
vim.cmd.highlight('GitGutterAdd', 'guibg=NONE')
vim.cmd.highlight('GitGutterChange', 'guibg=NONE')
vim.cmd.highlight('GitGutterDelete', 'guibg=NONE')


vim.opt.signcolumn = 'number'


-- set cursor back to beam on exit
vim.cmd [[autocmd VimLeave * set guicursor=a:ver25-blinkon0]]



-- Bind S to replace every occurence (normal mode)
vim.cmd [[map S :%s//g<Left><Left>]]
