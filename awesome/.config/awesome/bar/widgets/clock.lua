local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local clock = wibox.widget {
        format = "%a %d %b %H:%M",
        widget = wibox.widget.textclock,
}

return clock
