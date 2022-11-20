local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local clock = wibox.widget {
        {
            {
                format = "%a %d %b %H:%M",
                widget = wibox.widget.textclock,
            },
            widget = wibox.container.margin,
            left = 5,
            right = 5,
        },
        widget = wibox.container.background,
        bg = beautiful.bar_bg,
        fg = beautiful.bar_fg,
        shape = beautiful.bar_shape
}

return clock
