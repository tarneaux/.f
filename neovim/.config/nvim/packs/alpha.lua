require'alpha'.setup(require'alpha.themes.dashboard'.config)

local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'
dashboard.section.buttons.val = {
    dashboard.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "spc f f", "  Find file" , ":Telescope find_files<CR>"),
    dashboard.button( "spc f r", "  Recently used files" , ":Telescope oldfiles<CR>"),
    dashboard.button( "q", "  Quit NVIM" , ":qa<CR>"),
}
local handle = io.popen('fortune linux softwareengineering -s')
local fortune = handle:read("*a")
handle:close()
dashboard.section.header.val = fortune

dashboard.config.opts.noautocmd = true

vim.cmd[[autocmd User AlphaReady echo 'ready']]

alpha.setup(dashboard.config)
