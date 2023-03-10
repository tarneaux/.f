require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "lua", "rust", "python", "javascript", "markdown", "yaml"}
}

require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
