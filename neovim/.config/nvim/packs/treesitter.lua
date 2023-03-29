require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "lua", "rust", "python", "javascript", "markdown", "yaml", "org", "nix"},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {'org'},
    },
}

require('orgmode').setup()

-- We don't enable treesitter indentation as it breaks orgmode
