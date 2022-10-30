local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local taglist = require("bar/widgets/taglist")
local clock = require("bar/widgets/clock")
local tasklist = require("bar/widgets/tasklist")
local tray = require("bar/widgets/tray")


local bar = function(s)
    wb = awful.wibar {
        position = "top",
        height = 23,
        screen = s,
        bg = '#0000'
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
                    tray,
                    clock
                }
            },
            {
                tasklist(s),
                valign = "center",
                halign = "center",
                layout = wibox.container.place
            },
            layout = wibox.layout.stack

        },
        left = 10,
        right = 10,
        top = 5,
        widget = wibox.container.margin
    }
end

return bar
