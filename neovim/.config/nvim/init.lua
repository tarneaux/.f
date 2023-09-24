---------------------
-- Setup lazy.nvim --
---------------------

cfg_root = vim.fn.stdpath("config")


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- We need to set this before lazy so our mappings are set
vim.g.mapleader = " "


-- enable hex colors. This needs to come before plugins, because
-- some (like cmp) will render ugly colors else
vim.opt.termguicolors = true

-------------
-- Plugins --
-------------

require("lazy").setup({
    -- Gruvbox colorscheme
    {
        "ellisonleao/gruvbox.nvim",
        init = function()
            vim.cmd [[colorscheme gruvbox]]
        end
    },
    -- Lualine statusline
    {
        "hoob3rt/lualine.nvim",
        opts = {
            options = {
                component_separators = {"", ""},
                section_separators = {"", ""},
            }
        },
        dependencies = {"kyazdani42/nvim-web-devicons"}
    },
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            'windwp/nvim-ts-autotag'
        },
        init = function ()
            require('orgmode').setup_ts_grammar()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {"c", "lua", "rust", "python", "javascript", "typescript", "markdown", "yaml", "org", "nix", "html", "css", "scss", "bash", "haskell", "kotlin", "arduino", "latex"},
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = {"org"},
                },
                autotag = {
                    enable = true,
                }
            }
            -- Enable folding
            vim.opt.foldmethod = "expr"
            -- Enable folding based on treesitter
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            -- Prevent automatic folding
            vim.opt.foldlevel = 99
        end
    },
    -- LSP (completion, diagnostics, etc)
    {
        "neovim/nvim-lspconfig",
        init = function ()
            local lspconfig = require("lspconfig")
            local servers = {"clangd", "rust_analyzer", "pyright", "bashls", "html", "jsonls", "astro", "rust_analyzer", "lua_ls", "hls", "eslint"}
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup{
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                }
            end
            -- arduino_language_server specific setup
            lspconfig.arduino_language_server.setup{
                cmd = { "arduino-language-server", "--fqbn", "esp32:esp32:XIAO_ESP32C3" },
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            }
			-- texlab specific setup
			lspconfig.texlab.setup{
				cmd = { "texlab" },
				filetypes = { "tex", "bib", "markdown" },
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			}
        end
    },
    -- cmp (autocomplete)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        init = function ()
            local cmp = require("cmp")
            local has_words_before = function()
              if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
              local line, col = unpack(vim.api.nvim_win_get_cursor(0))
              return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
            end
            cmp.setup({
                mapping = {
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item()
                        elseif require("copilot.suggestion").is_visible() then
                            require("copilot.suggestion").accept()
                        else
                            fallback()
                        end
                    end, {"i", "s"}),
                    ["<C-space>"] = cmp.mapping(function(fallback)
                        if require("copilot.suggestion").is_visible() then
                            require("copilot.suggestion").accept_word()
                        else
                            fallback()
                        end
                    end, {"i", "s"}),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "orgmode"},
                    { name = "copilot" },
                    { name = "buffer" },
                },
            })
        end
    },
    -- Github copilot (AI code completion)
    {
        "zbirenbaum/copilot.lua",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true
            },
            panel = { enabled = false },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        opts = {},
    },
    -- inc-rename: Rename variables more easily
    {
        "smjonas/inc-rename.nvim",
        opts = {},
        init = function ()
            require("which-key").register({
                ["<space>r"] = { ":IncRename ", "Rename variable" },
            })
        end
    },
    -- trouble: show errors with :Trouble
    {
        'folke/trouble.nvim',
        init = function ()
            require("which-key").register({
                ["<space>T"] = { ":TroubleToggle<cr>", "Open/close Trouble" },
            })
        end
    },
    -- which-key: shortcuts
    {
        "folke/which-key.nvim",
        init = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require('which-key')
            wk.setup{}
            wk.register({
                ["<space>"] = {
                    w = { ":w<cr>", "Save" },
                    q = { ":q<cr>", "Quit" },
                }
            })
        end
    },
    -- Telescope: fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "joaomsa/telescope-orgmode.nvim",
        },
        init = function()
            local telescope = require("telescope")
            -- Telescope orgmode integration: search headings and refile
            telescope.load_extension("orgmode")
            require("which-key").register({
                ["<space>t"] = {
                    name = "Go to",
                    f = {"<cmd>Telescope find_files<cr>", "Files in project"},
                    g = {"<cmd>Telescope live_grep<cr>", "Text (grep)"},
                    b = {"<cmd>Telescope buffers<cr>", "Open buffers"},
                    h = {"<cmd>Telescope help_tags<cr>", "Vim help pages"},
                    m = {"<cmd>Telescope man_pages<cr>", "Manpages"},
                    s = {"<cmd>Telescope treesitter<cr>", "Treesitter symbols"},
                    r = {"<cmd>Telescope lsp_references<cr>", "References (under cursor)"},
                    d = {"<cmd>Telescope lsp_definitions<cr>", "Jump to definition (under cursor)"},
                    c = {"<cmd>Telescope lsp_code_actions<cr>", "Code actions (under cursor)"},
                }
            })
        end
    },
    -- NvimTree: file explorer
    {
        "nvim-tree/nvim-tree.lua",
        init = function ()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("which-key").register({
                ["<space>e"] = { ":NvimTreeToggle<cr>", "Open/close NvimTree" },
            })
        end,
        opts = {}
    },
    -- change project root to git root
    "airblade/vim-rooter",
    -- Git helper
    {
        "tpope/vim-fugitive",
        init = function ()
            require("which-key").register({
                ["<space>g"] = {
                    name = "Git",
                    c = { "<cmd>Git commit<cr>", "Commit" },
                    a = { "<cmd>Git add " .. vim.fn.expand('%:p') .. "<cr>", "Stage current file" },
                    A = { "<cmd>Git add --patch " .. vim.fn.expand('%:p') .. "<cr>", "Stage current file selectively" },
                    u = { "<cmd>Git restore --staged " .. vim.fn.expand('%:p') .. "<cr>", "Unstage current file" },
                    p = { "<cmd>Git push<cr>", "Push" },
                    s = { "<cmd>Git status<cr>", "Status" },
                    -- d = { "<cmd>Git diff<cr>", "Diff" },
                    d = { "<cmd>Telescope git_status<cr>", "Diff" }, -- I think the telescope version is a bit more usable
                    r = { "<cmd>Git restore ".. vim.fn.expand('%:p') .."<cr>", "Restore current file" },
                    R = { "<cmd>Git restore --patch ".. vim.fn.expand('%:p') .."<cr>", "Restore current file selectively" },
                }
            })
        end
    },
    -- Gitgutter
    {
        "lewis6991/gitsigns.nvim",
        opts = {
        }
    },
    -- Auto close brackets that aren't annoying (= closing already closed brackets)
    {
        "windwp/nvim-autopairs",
        -- Actually call require("nvim-autopairs").setup()
        opts = {}
    },
    -- Automatically add, change, and remove pairs of quotes, brackets, etc.
    "tpope/vim-surround",
    -- orgmode
    {
        "nvim-orgmode/orgmode",
        opts = {
            org_agenda_files = {"~/org/**"},
            org_default_notes_file = "~/org/refile.org",
            org_todo_keywords = {"DOING", "TODO", "NEXT", "LATER", "TOREAD", "TOWRITE", "WAITING", "DONE"},
            org_hide_emphasis_markers = true,
            -- Org ellipsis with a chevron
            org_ellipsis = " ",
            org_indent_mode = "noindent",
            org_archive_location = "~/org/archive.org::/",
            org_blank_before_new_entry = {heading = false, plain_list_item = false},
        },
        init = function ()
            require("which-key").register({
                ["<leader>o"] = {
                    name = "Org",
                    r = { "<cmd>Telescope orgmode refile_heading<cr>", "org refile to heading" },
                    s = { "<cmd>Telescope orgmode search_headings<cr>", "org search" },
                }
            })
            -- We need to enable conceal for org_hide_emphasis_markers to work
            vim.cmd [[ au FileType org setlocal conceallevel=3 ]]
        end
    },
    -- prettier orgmode bullets
    {
        "akinsho/org-bullets.nvim",
        opts = {
            symbols = {
                headlines = {"*"},
            },
            concealcursor = true
        }
    },
    -- orgmode and markdown tables. See the repo's README for more info
    {
        "dhruvasagar/vim-table-mode",
        init = function ()
            -- Enable table mode in orgmode
            vim.cmd [[ au FileType org silent TableModeEnable ]]
            -- Same for markdown
            vim.cmd [[ au FileType markdown TableModeEnable ]]
            -- According to my tests there is no problem with other filetypes, even when 
            -- opening a non-org file after an org file.
        end
    },
    -- Easily comment/decomment code
    "tpope/vim-commentary",
    -- Fountain (screenplay magkup language) support
    {
		"kblin/vim-fountain",
		init = function ()
			-- Disable textwidth and colorcolumn in fountain
			vim.cmd [[ au FileType fountain setlocal textwidth=0 colorcolumn=0 ]]
		end
	},
    -- True zen: distraction-free writing
    {
        "Pocco81/TrueZen.nvim",
        opts = {},
        init = function ()
            require("which-key").register({
                ["<leader>z"] = { "<cmd>TZAtaraxis<cr>", "Zen mode" },
            })
        end
    },
    -- Rust integration
    {
        "rust-lang/rust.vim",
        init = function ()
            vim.g.rustfmt_autosave = 1
        end
    },
})


------------------------
-- Additional options --
------------------------

-- Enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show gutter in line numbers
vim.opt.signcolumn = "number"

-- Disable those annoying swap files
vim.opt.swapfile = false

-- Store undo history between sessions
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"

-- Set tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Use two spaces for indentation when editing HTML, TS, JS, CSS, SCSS.
vim.cmd [[ au FileType html,typescript,javascript,css,scss,typescriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2 ]]

-- Enable mouse support just in case I turn into a normie (magic!)
vim.opt.mouse = "a"

-- Enable system clipboard support
vim.opt.clipboard = "unnamedplus"

-- Word wrap
vim.opt.wrap = true
vim.opt.linebreak = true

-- Bind S to replace every occurence (normal mode)
vim.cmd [[map S :%s//g<Left><Left>]]

-- Add french to spellcheck and keep english
-- For this we need to add the classic vim RTP (for neovim to find the spell files)
vim.opt.runtimepath:append("/usr/share/vim/vimfiles/")
vim.cmd [[ au FileType markdown,org setlocal spelllang+=fr ]]

-- When editing a git commit message, org or markdown file, enable spellcheck
vim.cmd [[ au FileType gitcommit,markdown,org setlocal spell ]]

-- Add a line at 80 characters when we are writing code
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80

-- Disable textwidth and colorcolumn in orgmode documents
vim.cmd [[ au FileType org setlocal textwidth=0 colorcolumn=0 ]]
