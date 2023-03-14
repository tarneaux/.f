-- This file configures the keybindings of awesome.

local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

ModKey = "Mod4"

local globalkeys = gears.table.join(
    -- Applications launcher
    awful.key({ ModKey,           }, "p", function() awful.spawn.with_shell("dmenu_run") end),
    -- Dmscripts
    awful.key({ ModKey,           }, "y", function() awful.spawn.with_shell("bash ~/.config/dmscripts/main.sh") end),
    -- Brave browser
    awful.key({ ModKey,           }, "b", function() awful.spawn.with_shell("librewolf") end),
    -- Emacs
    awful.key({ ModKey,           }, "g", function() awful.spawn.with_shell("emacsclient -c -a emacs") end),
    -- Zathura
    awful.key({ ModKey,           }, "z", function() awful.spawn.with_shell("zathura") end),
    -- ncmpcpp
    awful.key({ ModKey,           }, "slash", function() awful.spawn.with_shell(terminal_cmd .. " ncmpcpp") end),

    -- Open terminal
    awful.key({ ModKey,           }, "Return", function () awful.spawn.with_shell(terminal) end),

    -- Open project in terminal
    awful.key({ ModKey, "Shift"   }, "Return", function () awful.spawn.with_shell("/bin/ls ~/repo/ | dmenu -p 'repository:' -i -l 10 | xargs -I {} -r alacritty --working-directory ~/repo/{}") end),

    -- Reload awesome
    awful.key({ ModKey,  }, "q", awesome.restart),

    -- Shutdown the computer
    awful.key({ ModKey, "Control" }, "q", function() awful.spawn.with_shell("sudo shutdown now") end),

    -- Hibernate the computer
    awful.key({ ModKey, "Control" }, "h", function() awful.spawn.with_shell("sudo systemctl hibernate") end),

    -- Screenshot area / window
    awful.key({}, "Print", function() awful.spawn.with_shell("maim --select | xclip -selection clipboard -target image/png") end),

    -- change brightness. Only works on my laptop (asus something)
    awful.key({}, "XF86MonBrightnessUp", function() awful.spawn.with_shell('math "$(cat /sys/class/backlight/intel_backlight/brightness)+500" | sudo tee /sys/class/backlight/intel_backlight/brightness') end),
    awful.key({}, "XF86MonBrightnessDown", function() awful.spawn.with_shell('math "$(cat /sys/class/backlight/intel_backlight/brightness)-500" | sudo tee /sys/class/backlight/intel_backlight/brightness') end),

    -- Media keys
    awful.key({}, "XF86AudioRaiseVolume", function ()
              awful.spawn.with_shell("pactl set-sink-volume 0 +5%")
              end),
    awful.key({}, "XF86AudioLowerVolume", function ()
              awful.spawn.with_shell("pactl set-sink-volume 0 -5%")
              end),
    awful.key({}, "XF86AudioMute", function ()
              awful.spawn.with_shell("pactl set-sink-mute 0 toggle")
              end),
    awful.key({}, "XF86AudioNext", function ()
              awful.spawn.with_shell("mpc next")
              end),
    awful.key({}, "XF86AudioPrev", function ()
              awful.spawn.with_shell("mpc prev")
              end),
    awful.key({}, "XF86AudioPlay", function ()
              awful.spawn.with_shell("mpc toggle")
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

    -- Bookmarks with dmenu (lets you choose a line from ~/.config/awesome/bookmarks and types it for you)
    awful.key({ ModKey }, "m", function ()
        awful.spawn.with_shell("grep -v '^#' ~/.config/awesome/bookmarks | dmenu -p 'Select bookmark:' -i -l 10 | xargs -r xdotool type")
    end)
)

ClientKeys = gears.table.join(
    awful.key({ ModKey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end),
    awful.key({ ModKey,           }, "w",      function (c) c:kill()                         end),
    awful.key({ ModKey            }, "c",  awful.client.floating.toggle                     ),
    -- awful.key({ ModKey, "Shift"   }, "y",      function (c) c:move_to_screen()               end),
    awful.key({ ModKey,           }, "l",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ ModKey,           }, ".",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end)
)

-- Bind all key numbers to tags.
local tagkeys = { "a", "r", "s", "t", "d"}
for i = 1, 9 do
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
        -- Toggle tag display.
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
        -- Toggle tag on focused client.
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

-- Set keys
root.keys(globalkeys)
