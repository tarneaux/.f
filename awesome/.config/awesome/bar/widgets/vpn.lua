local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local status = wibox.widget {
    text = "",
    widget = wibox.widget.textbox
}


local is_running = function ()
    awful.spawn.easy_async('doas wg show', function(stdout)
        if stdout == '' then
            status.text = "vpn: down"
            return false
        else
            status.text = "vpn: up"
            return true
        end
    end)
end


gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = is_running
}

return status
