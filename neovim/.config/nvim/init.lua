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

  use 'jiangmiao/auto-pairs'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
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

end)

vim.cmd [[colorscheme gruvbox]]
dofile(root .. "packs/treesitter.lua")
dofile(root .. "packs/lualine.lua")
dofile(root .. "packs/whichkey.lua")
dofile(root .. "packs/lsp.lua")
dofile(root .. "packs/alpha.lua")
vim.opt.termguicolors = true
require'colorizer'.setup()


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
