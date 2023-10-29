local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local widget = wibox.widget.textbox()


local function daemon ()
    awful.spawn.easy_async('sudo wg show', function(stdout)
        if stdout == '' then
            widget:set_text("󰿆 ")
            return false
        else
            widget:set_text("󰌾 ")
            return true
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
