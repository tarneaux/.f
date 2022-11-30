local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local mpd = wibox.widget.textbox()
mpd:set_text(" ")


local function update_mpd()
    awful.spawn.easy_async_with_shell("mpc current", function(stdout)
        if stdout ~= "" then
            mpd:set_text(" " .. stdout)
        else
            mpd:set_text(" ")
        end
    end)
end


local buttons = gears.table.join(
    awful.button({}, 1, function()
        awful.spawn.with_shell("mpc toggle")
        update_mpd()
    end),
    awful.button({}, 3, function()
        awful.spawn.with_shell("mpc prev")
        update_mpd()
    end),
    awful.button({}, 4, function()
        awful.spawn.with_shell("mpc next")
        update_mpd()
    end),
    awful.button({}, 5, function()
        awful.spawn.with_shell("mpc prev")
        update_mpd()
    end)
)

mpd:buttons(buttons)


gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback = update_mpd
}

return mpd
