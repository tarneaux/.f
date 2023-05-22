-- This file configures the keybindings of awesome.
-- I have made it so that it matches my keyboard layout (colemak).
-- This means that you may have to change some shortcuts.
-- arstdhneio is the whole colemak home row, from left to right. Change those keys to match your keyboard layout.
-- Remember that almost all the keys are bound to something, so changing one you might need to change another.

local awful = require("awful")
local gears = require("gears")
require("awful.hotkeys_popup.keys")

ModKey = "Mod4"

local previous_layout = nil

local globalkeys = gears.table.join(
    -- Applications launcher: dmenu. Archlinux package: dmenu
    awful.key({ ModKey,           }, "p", function() awful.spawn.with_shell("dmenu_run") end),
    -- Dmscripts (my own scripts): see the dotfile's README for more info
    awful.key({ ModKey,           }, "y", function() awful.spawn.with_shell("bash ~/.config/dmscripts/main.sh") end),
    -- Qutebrowser (web browser). You can change this to match your browser (don't use chrome, opera, vivaldi, brave, firefox, etc.)
    -- nice alternatives include GNU icecat and librewolf.
    awful.key({ ModKey,           }, "b", function() awful.spawn.with_shell("qubebrowser") end),
    -- Emacs: I use emacsclient to open emacs. You can change this to match your editor, or just remove it.
    awful.key({ ModKey,           }, "g", function() awful.spawn.with_shell("emacs") end),
    -- Zathura: PDF viewer. Archlinux package: zathura.
    awful.key({ ModKey,           }, "z", function() awful.spawn.with_shell("zathura") end),
    -- Ranger: terminal file manager. Archlinux package: ranger.
    awful.key({ModKey,            }, "j", function() awful.spawn.with_shell(TerminalCmd .. "ranger") end),
    -- ncmpcpp: terminal music player/mpd frontend. Archlinux package: ncmpcpp.
    awful.key({ ModKey,           }, "slash", function() awful.spawn.with_shell(TerminalCmd .. " ncmpcpp") end),

    -- Open terminal (I use alacritty)
    awful.key({ ModKey,           }, "Return", function () awful.spawn.with_shell(Terminal) end),

    -- Reload awesomewm. This is useful when you change the config file.
    awful.key({ ModKey,  }, "q", awesome.restart),

    -- Shutdown the computer
    awful.key({ ModKey, "Control" }, "q", function() awful.spawn.with_shell("sudo shutdown now") end),

    -- Hibernate the computer: you need some configuration for this to work. See the archwiki, page on hibernation.
    awful.key({ ModKey, "Control" }, "h", function() awful.spawn.with_shell("sudo systemctl hibernate") end),

    -- Screenshot area / window
    awful.key({}, "Print", function() awful.spawn.with_shell("maim --select | xclip -selection clipboard -target image/png") end),

    -- change brightness. Only works on my laptop (asus something)
    awful.key({}, "XF86MonBrightnessUp", function() awful.spawn.with_shell('math "$(cat /sys/class/backlight/intel_backlight/brightness)+500" | sudo tee /sys/class/backlight/intel_backlight/brightness') end),
    awful.key({}, "XF86MonBrightnessDown", function() awful.spawn.with_shell('math "$(cat /sys/class/backlight/intel_backlight/brightness)-500" | sudo tee /sys/class/backlight/intel_backlight/brightness') end),

    -- Media keys
    awful.key({}, "XF86AudioRaiseVolume", function ()
              awful.spawn.with_shell("pactl set-sink-volume 0 +2%")
              end),
    awful.key({}, "XF86AudioLowerVolume", function ()
              awful.spawn.with_shell("pactl set-sink-volume 0 -2%")
              end),
    awful.key({}, "XF86AudioMute", function ()
              awful.spawn.with_shell("pactl set-sink-mute 0 toggle")
              end),
    awful.key({}, "XF86AudioNext", function ()
              awful.spawn.with_shell("playerctl next")
              end),
    awful.key({}, "XF86AudioPrev", function ()
              awful.spawn.with_shell("playerctl previous")
              end),
    awful.key({}, "XF86AudioPlay", function ()
              awful.spawn.with_shell("playerctl play-pause")
              end),

    -- Focus (colemak hjkl=neio)
    awful.key({ ModKey,           }, "i",
        function ()
            awful.client.focus.byidx( 1)
        end
    ),
    awful.key({ ModKey,           }, "e",
        function ()
            awful.client.focus.byidx(-1)
        end
    ),

    -- Layout manipulation (still colemak keys)
    awful.key({ ModKey, "Shift"   }, "i",     function () awful.client.swap.byidx(  1)        end), -- Swap with next client
    awful.key({ ModKey, "Shift"   }, "e",     function () awful.client.swap.byidx( -1)        end), -- Swap with previous client
    awful.key({ ModKey, "Shift"   }, "o",     function () awful.tag.incmwfact( 0.05)          end), -- Increase master width factor
    awful.key({ ModKey, "Shift"   }, "n",     function () awful.tag.incmwfact(-0.05)          end), -- Decrease master width factor
    awful.key({ ModKey,           }, "n",     function () awful.tag.incnmaster( 1, nil, true) end), -- Increase the number of master clients
    awful.key({ ModKey,           }, "o",     function () awful.tag.incnmaster(-1, nil, true) end), -- Decrease the number of master clients
    awful.key({ ModKey, "Shift"   }, "m",     function () awful.tag.incncol( 1, nil, true)    end), -- Increase the number of columns
    awful.key({ ModKey, "Shift"   }, "/",     function () awful.tag.incncol(-1, nil, true)    end), -- Decrease the number of columns

    -- Change layout
    awful.key({ ModKey,           }, ",", function () awful.layout.inc( 1)                end),

    -- Toggle maximized layout
    -- This will just crash if you set the default layout to maximized, but else it works well.
    awful.key({ ModKey,           }, ".", function ()
        local screen = awful.screen.focused()
        local tag = screen.selected_tag
        local current_layout = tag.layout

        local toggled_layout = awful.layout.suit.max

        if current_layout.name == toggled_layout.name then
            awful.layout.set(previous_layout, tag)
        else
            previous_layout = current_layout
            awful.layout.set(toggled_layout, tag)
        end
    end),

    -- Restore last minimized client
    awful.key({ ModKey, }, "u",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end),

    -- Bookmarks with dmenu (lets you choose a line from ~/.config/awesome/bookmarks and types it for you using xdotool)
    awful.key({ ModKey }, "m", function ()
        awful.spawn.with_shell("grep -v '^#' ~/.config/awesome/bookmarks | grep -v -e '^$' | dmenu -p 'Select bookmark:' -i -l 10 | xargs -r xdotool type")
    end)
)

-- Keys for clients (windows)
ClientKeys = gears.table.join(
    -- Toggle fullscreen = no borders, bar, titlebar, or gaps
    awful.key({ ModKey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end),
    -- Close client
    awful.key({ ModKey,           }, "w",      function (c) c:kill()                         end),
    -- Toggle floating
    awful.key({ ModKey            }, "c",  awful.client.floating.toggle                     ),
    -- Minimize client
    awful.key({ ModKey,           }, "l",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end)
)

-- Bind all key numbers to tags.
-- Colemak's "arstd" = qwerty's "asdfg"
local tagkeys = { "a", "r", "s", "t", "d"}
-- Here change the number 5 to the number of buttons you set just above.
for i = 1, 5 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ ModKey }, tagkeys[i],
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end),
        -- Toggle tag display. (in awesomewm you can view multiple tags at once)
        awful.key({ ModKey, "Control" }, tagkeys[i],
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ ModKey, "Shift" }, tagkeys[i],
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end),
        -- Toggle tag on focused client. (clients/windows can be tagged with multiple tags)
        awful.key({ ModKey, "Control", "Shift" }, tagkeys[i],
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end)
    )
end

-- Mouse bindings. You shouldn't need to change these.
ClientButtons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ ModKey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ ModKey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys. Without this line all of this file is useless!
root.keys(globalkeys)
