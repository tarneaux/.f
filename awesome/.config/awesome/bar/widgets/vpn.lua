local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
-- local lain = require("lain")

local widget = wibox.widget.textbox()

local function get_vpn_status (callback)
    awful.spawn.easy_async_with_shell('ip a | grep -q "scope global vpn"', function(_, _, _, exit_code)
        if exit_code == 0 then
            callback(true)
        else
            callback(false)
        end
    end)
end

local function daemon ()
    get_vpn_status(function(status)
        if status then
            widget:set_text("󰌾 ")
        else
            widget:set_text("󰿆 ")
        end
    end)
end

-- local function toggle ()
--     get_vpn_status(function(status)
--         local new
--         if status then
--             new = "down"
--         else
--             new = "up"
--         end

--         local quake = lain.util.quake({
--             app = "alacritty --class VpnQuake",
--             argname = "--title %s -e sudo wg-quick " .. new .. " vpn",
--             followtag = true,
--             height = 0.3,
--             width = 0.3,
--             vert = "center",
--             horiz = "center",
--             border = 2,
--             name = "VpnQuake",
--             settings = function(c) c.sticky = true end
--         })
--         quake:toggle()
--     end)
-- end

-- widget:connect_signal("button::press", function(_, _, _, button)
--     if button == 1 then
--         toggle()
--     end
-- end)

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = daemon
}

return widget
