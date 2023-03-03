local wk = require("which-key")


wk.register({
    ["<space>"] = {
        f = {
            name = "Find",
            f = { "<cmd>Telescope find_files<cr>", "Files" },
            g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            h = { "<cmd>Telescope find_files hidden=true<cr>", "Hidden files" },
            r = { "<cmd>Telescope repo list<cr>", "Git repos" },
        },
        g = {
            name = "Git",
            c = { "<cmd>Git commit<cr>", "Commit" },
            a = { "<cmd>Git add " .. vim.fn.expand('%:p') .. "<cr>", "Add current file" },
            p = { "<cmd>Git push<cr>", "Push" },
            s = { "<cmd>Git status<cr>", "Status" },
            d = { "<cmd>Git diff<cr>", "Diff" },
            r = { "<cmd>Git restore ".. vim.fn.expand('%:p') .."<cr>", "Restore state of current file to the one in the last commit" },
        },
        b = {
            name = "Buffers",
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            d = { "<cmd>bd<cr>", "Delete" },
            c = { "<cmd>enew<cr>", "Close" },
            p = { "<cmd>bp<cr>", "Previous" },
            n = { "<cmd>bn<cr>", "Next" }
        },
        o = { "<cmd>NvimTreeToggle<cr>", "Open nvimtree" },
        i = { "<cmd>NvimTreeFocus<cr>", "Focus nvimtree" },
        q = { "<cmd>q<cr>", "Quit" },
        w = { "<cmd>w<cr>", "Write" },
        r = { "<cmd>Telescope repo list<cr>", "Registers" },
        t = { "<cmd>TroubleToggle<cr>", "Show errors" },
    }
})
