local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local taglist = require("bar/widgets/taglist")
local clock = require("bar/widgets/clock")
local vpn = require("bar/widgets/vpn")
local mpd = require("bar/widgets/mpd")
local spacer = require("bar/widgets/spacer")


local bar = function(s)
    local wb = awful.wibar {
        position = "top",
        height = 18,
        screen = s,
        bg = beautiful.background
    }
    wb:setup {
        {
            {
                layout = wibox.layout.align.horizontal,
                {
                    layout = wibox.layout.align.horizontal,
                    taglist(s)
                },
                nil,
                {
                    layout = wibox.layout.align.horizontal,
                    mpd,
                    spacer,
                    vpn
                }
            },
            widget = wibox.container.margin,
            right = 5,
            left = 5
        },
        {
            layout = wibox.container.place,
            halign = "center",
            clock
        },
        layout = wibox.layout.stack,
    }
end

return bar
