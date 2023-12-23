local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local level_icons = {
    "  ",
    "  ",
    "  ",
    "  ",
    "  "
}

local charging_icon = ""

local notification_shown = 100

local icon_widget = wibox.widget.textbox()
icon_widget:set_text("")

local charging_widget = wibox.widget.textbox()
charging_widget:set_text("")

local percentage_widget = wibox.widget.textbox()
percentage_widget:set_text("")

local combo_widget = wibox.widget {
    charging_widget,
    {
        icon_widget,
        left = 5,
        widget = wibox.container.margin
    },
    percentage_widget,
    layout = wibox.layout.fixed.horizontal
}

local function update_icon_and_percentage_widgets(upower_output)
    local percentage = tonumber(upower_output:match("percentage:%s*(%d+)")) or 0

    -- Round to the nearest 20 to get the icon index
    -- The +0.5 is to round to the nearest integer instead of the floor
    local level = math.floor(percentage/25 + 0.5)
    local icon = level_icons[level+1]

    -- is_red is for alternating the color of the percentage widget
    -- (blinking red/white)
    if percentage <= 15 then
        percentage_widget.markup = "<span color='red'>" .. percentage .. "%</span>"
        icon_widget.markup = "<span color='red'>" .. icon .. "</span>"
        if notification_shown - percentage >= 10 then
            awful.spawn.with_shell(
                "notify-send -u critical 'Battery Low' 'Battery is at " .. percentage .. "%'"
            )
            -- Avoid sending another notification until the next 5% step
            -- (5, 10, 15)
            notification_shown = math.ceil(percentage/5) * 5
        end
    else
        percentage_widget.markup = percentage .. "%"
        icon_widget.markup = icon
        notification_shown = 100 -- Reset
    end
end

local update_charging_widget = function(upower_output)
    local charging = upower_output:match("state:%s*(%a+)")
    if charging == "charging" then
        charging_widget:set_text(charging_icon)
    else
        charging_widget:set_text("")
    end
end

local function check_laptop_and_update()
    awful.spawn.easy_async_with_shell(
        "upower -i /org/freedesktop/UPower/devices/battery_BAT1",
        function(output)
            if output:match("(should be ignored)") then
                -- No battery found!
                combo_widget.visible = false
                return
            end
            update_icon_and_percentage_widgets(output)
            update_charging_widget(output)
        end
    )
end

gears.timer {
    timeout = 1,    -- It's good to update the charging status often for quick 
                    -- feedback
    autostart = true,
    call_now = true,
    callback = check_laptop_and_update
}

return combo_widget
