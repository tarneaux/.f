local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local widget = wibox.widget.textbox()

local function daemon ()
    awful.spawn.easy_async_with_shell(
        'playerctl -p $(playerctl -l | grep mpd | head -n 1) metadata --format "{{ artist }} - {{ title }}"',
        function(stdout)
            stdout = stdout:gsub('%\n$', '')
            if stdout ~= "" and stdout ~= " - " then
                widget:set_markup("󰝚 " .. stdout)
            else
                widget:set_markup("󰝚 Not playing")
            end
        end
    )
end

local function toggle ()
    awful.spawn.with_shell(
        'playerctl play-pause'
    )
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

-- Put the widget in a container to allow for scrolling when the text is too
-- long (like this comment :-)).
local scrolling_widget = wibox.widget {
   layout = wibox.container.scroll.horizontal,
   max_size = 300,
   step_function = wibox.container.scroll.step_functions
                   .waiting_nonlinear_back_and_forth,
   speed = 100,
   widget
}

scrolling_widget:set_fps(60)

return scrolling_widget
