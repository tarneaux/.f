local root = vim.fn.expand('~/.config/nvim/')

vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Gruvbox theme
    use 'morhetz/gruvbox'

    use 'airblade/vim-gitgutter'

    use 'nvim-treesitter/nvim-treesitter'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use 'github/copilot.vim'

    use 'tpope/vim-commentary'

    use 'windwp/nvim-autopairs'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, { "cljoly/telescope-repo.nvim" } }
    }
    use 'nvim-telescope/telescope-file-browser.nvim'

    use 'folke/which-key.nvim'

    use 'tpope/vim-fugitive'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'ervandew/supertab'
    use 'nvim-lua/plenary.nvim'

    use 'goolord/alpha-nvim'

    use 'norcalli/nvim-colorizer.lua'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons' -- optional, for file icons
        }
    }

    use 'airblade/vim-rooter'

    use "folke/todo-comments.nvim"

    use "NMAC427/guess-indent.nvim"

    use 'kblin/vim-fountain'

    use 'nvim-tree/nvim-web-devicons'
    use 'folke/trouble.nvim'
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
vim.opt.undodir = root .. "undodir"


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
