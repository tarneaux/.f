local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local widget = wibox.widget.textbox()


local function daemon ()
    awful.spawn.easy_async('sh -c \'ip a | grep -q "scope global vpn"\'', function(stdout, stderr, reason, exit_code)
        if exit_code == 0 then
            widget:set_text("󰌾 ")
        else
            widget:set_text("󰿆 ")
        end
    end)
end


gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = daemon
}

return widget
