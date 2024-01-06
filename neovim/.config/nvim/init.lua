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
            'windwp/nvim-ts-autotag',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        init = function ()
            require('orgmode').setup_ts_grammar()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {"c", "lua", "rust", "python", "javascript", "typescript", "markdown", "yaml", "org", "nix", "html", "css", "scss", "bash", "haskell", "kotlin", "arduino", "latex", "svelte"},
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = {"org", "python"},
                },
                autotag = {
                    enable = true,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                },
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
            local servers = {"clangd", "rust_analyzer", "pyright", "bashls", "html", "jsonls", "astro", "rust_analyzer", "lua_ls", "hls", "eslint", "ansiblels", "yamlls"}
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
            require("which-key").register({
                ["<leader>l"] = {
                    name = "LSP actions",
                    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
                    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
                    D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration" },
                    i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation" },
                    r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Go to references" },
                    R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
                    h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
                    H = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },
                    s = { "<cmd>lua vim.lsp.buf.document_symbol()<cr>", "Document symbols" },
                    S = { "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", "Workspace symbols" },
                    t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition" },
                    x = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Show line diagnostics" },
                }
            })
        end
    },
    -- cmp (autocomplete)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
        },
        init = function ()
            local cmp = require("cmp")
            local has_words_before = function()
              if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
              local line, col = unpack(vim.api.nvim_win_get_cursor(0))
              return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
            end
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<C-CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        local luasnip = require("luasnip")
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item()
                        -- elseif luasnip.expand_or_jumpable() then
                        --     luasnip.expand_or_jump()
                        elseif require("copilot.suggestion").is_visible() then
                            require("copilot.suggestion").accept()
                        else
                            fallback()
                        end
                    end, {"i", "s"}),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "orgmode" },
                    { name = "buffer" },
                    { name = "luasnip" }
                },
            })
        end
    },
    -- Luasnip: snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        init = function ()
            -- local luasnip = require("luasnip")
            -- luasnip.config.set_config({
            --     history = true,
            --     updateevents = "TextChanged,TextChangedI",
            -- })
            require("luasnip/loaders/from_vscode").load()
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
			filetypes = {
				["*"] = true,
				["markdown"] = false,
				["org"] = false,
			}
        },
		init = function()
			require("which-key").register({
				["<leader>c"] = {
				    ":silent Copilot! toggle<cr>",
					"Copilot",
				}
			})
		end
    },
    -- trouble: show errors with :Trouble
    {
        'folke/trouble.nvim',
        init = function ()
            require("which-key").register({
                ["<leader>T"] = { ":TroubleToggle<cr>", "Open/close Trouble" },
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
                ["<leader>"] = {
                    w = { ":w<cr>", "Save" },
                    q = { ":q<cr>", "Quit" },
                    e = { ":Explore<cr>", "Netrw" },
                    O = {
                        name = "Options",
                        t = {
                            function ()
                                local width = vim.ui.input({ prompt = 'Set tab width to: '}, function (input)
                                    if not input then
                                        return
                                    end
                                    input = tonumber(input)
                                    vim.opt.shiftwidth = input
                                    vim.opt.tabstop = input
                                    vim.opt.softtabstop = input
                                end)
                            end,
                            "Set tab width for current buffer"
                        },
                        c = {
                            function ()
                                if vim.opt.colorcolumn:get()[1] == "81" then
                                    vim.opt.colorcolumn = ""
                                else
                                    vim.opt.colorcolumn = "81"
                                end
                            end,
                            "Toggle colorcolumn between none and 81 for current buffer",
                        },
                        w = {
                            function ()
                                if vim.opt.textwidth:get() == 0 then
                                    vim.opt.textwidth = 80
                                else
                                    vim.opt.textwidth = 0
                                end
                            end,
                            "Toggle text width for current buffer",
                        },
                    },
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
                ["<leader>t"] = {
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
    -- change project root to git root
    "airblade/vim-rooter",
    -- Git helper
    {
        "tpope/vim-fugitive",
        init = function ()
            require("which-key").register({
                ["<leader>g"] = {
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
            vim.cmd [[ au FileType markdown silent TableModeEnable ]]
            -- According to my tests there is no problem with other filetypes, even when 
            -- opening a non-org file after an org file.
        end
    },
    -- Easily comment/decomment code
    "tpope/vim-commentary",
    -- Fountain (screenplay magkup language) support
    {
        "kblin/vim-fountain",
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
    -- Leap.nvim: jump to any word in the buffer
    {
        "ggandor/leap.nvim",
        dependencies = {
            "tpope/vim-repeat"
        },
        init = function ()
            require('leap').add_default_mappings()
        end
    },
    -- Editorconfig: parse .editorconfig files
    "editorconfig/editorconfig-vim",
    -- DiffView: see git diffs
    {
        "sindrets/diffview.nvim",
        init = function ()
            require("which-key").register({
                ["<leader>d"] = { "<cmd>DiffviewOpen<cr>", "Open diffview" },
            })
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
vim.opt.expandtab = true

-- Use two spaces for indentation when editing HTML, TS, JS, CSS, SCSS.
vim.cmd [[ au FileType html,typescript,javascript,css,scss,typescriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2 ]]

-- Enable mouse support just in case I turn into a normie (magic!)
vim.opt.mouse = "a"

-- Enable system clipboard support
vim.opt.clipboard = "unnamedplus"

-- Word wrap
vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.scrolloff = 2

-- Add french to spellcheck and keep english
-- For this we need to add the classic vim RTP (for neovim to find the spell files)
vim.opt.runtimepath:append("/usr/share/vim/vimfiles/")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown,org",
    callback = function ()
        vim.opt.spelllang:append("fr")
    end
})

-- When editing a git commit message, org or markdown file, enable spellcheck
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit,markdown,org",
    callback = function ()
        vim.opt.spell = true
    end
})

-- When editing a git commit message, set the textwidth and colorcolumn to the recommended values
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "gitcommit",
    callback = function ()
        vim.opt.textwidth = 72
        vim.opt.colorcolumn = "73"
    end
})

-- python formatter
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "python",
    callback = function ()
        vim.keymap.set("n", "<leader>f", ":!black %<cr>", {desc = "Format python file"})
    end
})

-- <leader>s to search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>]], {desc = "Search and replace"})
-- Case insensitive
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Search and replace (case insensitive)"})

-- <leader>p to paste in visual & select modes without changing the register
vim.keymap.set("x", "<leader>p", '"_dP')

-- Shift+Up/Down to move lines
vim.keymap.set("n", "<S-Up>", "<cmd>m .-2<cr>==")
vim.keymap.set("n", "<S-Down>", "<cmd>m .+1<cr>==")

-- Shift+Up/Down to move selected lines in visual mode
vim.keymap.set("x", "<S-Up>", ":move'<-2<CR>gv=gv")
vim.keymap.set("x", "<S-Down>", ":move'>+1<CR>gv=gv")

-- Add signature at bottom of email files
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "mail",
    callback = function ()
        vim.keymap.set("n", ",s", function () vim.cmd [[ :r ~/.config/aerc/signature.txt ]] end, { buffer = true })
    end
})

vim.g.pyindent_open_paren = "shiftwidth()"

-- Enable colorcolumn in all programming files
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "python,html,css,scss,typescript,javascript,rust,sh",
    callback = function ()
        vim.opt.colorcolumn = "81"
    end
})
