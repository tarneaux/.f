local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local taglist = require("bar/widgets/taglist")
local clock = require("bar/widgets/clock")
local vpn = require("bar/widgets/vpn")
local spacer = require("bar/widgets/spacer")
local layout = require("bar/widgets/layout")
local battery = require("bar/widgets/battery")
local unison = require("bar/widgets/unison")
local togglekeyboard = require("bar/widgets/togglekeyboard")


local bar = function(s)
    local wb = awful.wibar {
        position = "top",
        height = beautiful.bar_height,
        screen = s,
        bg = beautiful.background
    }
    wb:setup {
        {
            {
                layout = wibox.layout.align.horizontal,
                {
                    layout = wibox.layout.align.horizontal,
                    taglist(s),
                    layout(s)
                },
                nil,
                {
                    layout = wibox.layout.align.horizontal,
                    battery,
					{
						layout = wibox.layout.align.horizontal,
                        spacer,
						unison,
						spacer,
					},
                    {
                        layout = wibox.layout.align.horizontal,
                        togglekeyboard,
                        spacer,
                        vpn,
                    }
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
