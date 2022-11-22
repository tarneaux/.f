local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")


local taglist = function(s)
    local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

    mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style = {shape = gears.shape.circle},
        layout = {
            spacing = 1,
            layout = wibox.layout.flex.horizontal
        },
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                margins = 4,
                widget  = wibox.container.margin
            },
            widget = wibox.container.background,
            shape = gears.shape.circle,
            id    = 'background_role',
            create_callback = function(self, c3, index, objects)
                self:connect_signal('mouse::enter', function()
                    if self.bg ~= beautiful.bg_accent then
                        self.backup     = self.bg
                        self.has_backup = true
                    end
                    self.bg = beautiful.bg_accent
                end)
                self:connect_signal('mouse::leave', function()
                    if self.has_backup then self.bg = self.backup end
                end)
                self:connect_signal('button::press', function(self, lx, ly, button, data, tags)
                    if button == 1 then
                    end
                end)
            end,
            update_callback = function(self, c3, _)
                -- Prevent the bug where there is on tag with a background because the mouse was on the tag before the user switched to it
                if c3.selected then
                    self.backup = beautiful.bg_accent
                else
                    self.backup = beautiful.bg_normal
                end
            end

        },
        buttons = taglist_buttons
    }
    mytaglist_with_margins = mytaglist
    return mytaglist_with_margins
end

return taglist
