require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "lua", "rust", "python", "javascript", "astro"},
    highlight = {
        enable = true
    }
}

require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
