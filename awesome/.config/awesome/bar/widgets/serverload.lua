local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local icon = "󰇅 "

local widget = wibox.widget.textbox()

local function daemon ()
    awful.spawn.easy_async('zsh -c \'ssh ' .. Server .. ' "uptime" 2> /dev/null | cut -d "," -f 3- | cut -d ":" -f 2- | sed "s/^[ \t]*//"\'', function(stdout)
        if stdout == '' then
            widget:set_markup('<span color="#ff0000">' .. icon .. 'DOWN</span>')
            return false
        else
            widget:set_text(icon .. stdout)
            return true
        end
    end)
end


gears.timer {
    timeout = 10,
    call_now = true,
    autostart = true,
    callback = daemon
}

return widget
