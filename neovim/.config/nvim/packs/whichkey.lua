local wk = require("which-key")


wk.register({
    ["<space>"] = {
        f = {
            name = "Find",
            f = { "<cmd>Telescope find_files<cr>", "Files" },
            g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
            r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
        },
        g = {
            name = "Git",
            c = { "<cmd>Git commit<cr>", "Commit" },
            a = { "<cmd>Git add " .. vim.fn.expand('%:p') .. " <cr>", "Add current file" },
            p = { "<cmd>Git push<cr>", "Push" },
            s = { "<cmd>Git status<cr>", "Status" }
        },
        q = { "<cmd>q<cr>", "Quit" },
        w = { "<cmd>w<cr>", "Write" }
    }
})
