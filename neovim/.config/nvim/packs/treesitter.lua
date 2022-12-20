require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "lua", "rust", "python"},
    highlight = {
        enable = true
    }
}

require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
