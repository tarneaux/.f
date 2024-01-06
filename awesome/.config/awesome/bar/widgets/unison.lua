local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local widget = wibox.widget.textbox()

local icon = " "

local function daemon ()
    awful.spawn.easy_async_with_shell('pgrep unison', function(stdout)
		-- Check we have at least 4 unison processes (4 lines)
		local _, process_count = stdout:gsub('\n', '\n')
		if process_count >= 4 then
			widget:set_markup(icon .. "OK")
		else
			widget:set_markup("<span color='#FF0000'>" .. icon .. "DOWN</span>")
		end
    end)
end


gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = daemon
}

return widget
