local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local batt_icon = wibox.widget.imagebox()
local batt = wibox.widget {
    batt_icon,
    margins = 2,
    widget = wibox.container.margin
}


gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function()
        icon = awful.spawn.easy_async_with_shell('upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "icon-name:"', function(out)
            local icon_name = out:match("'[^'].*'"):gsub("'", "")
            batt_icon:set_image("/usr/share/icons/Tela-circle/symbolic/status/" .. icon_name .. ".svg")
        end)
    end
}

return batt
