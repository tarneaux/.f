local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local clock = wibox.widget {
    {
        {
            {
                format = "%a %d %b",
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
    },
    {
        widget = wibox.container.margin,
        right = 4,
    },
    {
        {
            {
                format = "%H:%M",
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
    },
    layout = wibox.layout.align.horizontal,
    widget = wibox.container.margin,
    left = 4,
    right = 4
}

return clock
