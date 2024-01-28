local internal_keyboard = "AT Translated Set 2 keyboard"

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local widget = wibox.widget.textbox()

local function get_enabled (callback)
    awful.spawn.easy_async_with_shell('xinput list-props "' .. internal_keyboard ..  '" | grep "Device Enabled" | awk \'{print $4}\'', function (stdout, stderr)
        callback(stdout == "1\n")
    end)
end

local function daemon ()
    get_enabled(function(status)
        if status then
            widget:set_text("  on")
        else
            widget:set_text("  off")
        end
    end)
end

local function toggle ()
    get_enabled(function(status)
        local new
        if status then
            new = 0
        else
            new = 1
        end

        awful.spawn.easy_async_with_shell('xinput set-prop "' .. internal_keyboard .. '" "Device Enabled" ' .. new, function()
            daemon()
            awful.spawn.easy_async_with_shell("~/.config/scripts/manage-keyboards")
        end)
    end)
end

widget:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        toggle()
    end
end)

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = daemon
}

return widget
