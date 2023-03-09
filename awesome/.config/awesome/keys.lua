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

    -- change the screen layout
    awful.key({ ModKey   }, "1", function () awful.spawn.with_shell("xrandr --output eDP-1 --mode 1366x768 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off --output DP-2 --off --output HDMI-3 --off") end),

    -- change the screen layout
    awful.key({ ModKey   }, "2", function () awful.spawn.with_shell("xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --mode 2560x1080 --pos 0x0 --rotate normal --output DP-2 --off --output HDMI-3 --off") end),

    -- Shutdown the computer
    awful.key({ ModKey, "Control" }, "q", function() awful.spawn.with_shell("doas shutdown now") end),

    -- Hibernate the computer
    awful.key({ ModKey, "Control" }, "h", function() awful.spawn.with_shell("doas systemctl hibernate") end),

    -- Print area / window
    awful.key({}, "Print", function() awful.spawn.with_shell("maim --select | xclip -selection clipboard -target image/png") end),

    -- change brightness
    awful.key({}, "XF86MonBrightnessUp", function() awful.spawn.with_shell('math "$(cat /sys/class/backlight/intel_backlight/brightness)+500" | doas tee /sys/class/backlight/intel_backlight/brightness') end),
    awful.key({}, "XF86MonBrightnessDown", function() awful.spawn.with_shell('math "$(cat /sys/class/backlight/intel_backlight/brightness)-500" | doas tee /sys/class/backlight/intel_backlight/brightness') end),

        -- Change volume
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

    awful.key({ ModKey,           }, "Left",   awful.tag.viewprev),
    awful.key({ ModKey,           }, "Right",  awful.tag.viewnext),
    awful.key({ ModKey,           }, "Escape", awful.tag.history.restore),

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
    -- awful.key({ ModKey,           }, "y", function () awful.screen.focus_relative( 1) end),
    -- Layout manipulation
    awful.key({ ModKey, "Shift"   }, "i", function () awful.client.swap.byidx(  1)    end),
    awful.key({ ModKey, "Shift"   }, "e", function () awful.client.swap.byidx( -1)    end),
    awful.key({ ModKey, "Shift"   }, "o",     function () awful.tag.incmwfact( 0.05)          end),
    awful.key({ ModKey, "Shift"   }, "n",     function () awful.tag.incmwfact(-0.05)          end),
    awful.key({ ModKey,           }, "n",     function () awful.tag.incnmaster( 1, nil, true) end),
    awful.key({ ModKey,           }, "o",     function () awful.tag.incnmaster(-1, nil, true) end),
    awful.key({ ModKey, "Control" }, "e",     function () awful.tag.incncol( 1, nil, true)    end),
    awful.key({ ModKey, "Control" }, "i",     function () awful.tag.incncol(-1, nil, true)    end),
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
    -- Bookmarks with dmenu
    awful.key({ ModKey }, "m", function ()
        awful.spawn.with_shell("grep -v '^#' ~/.config/awesome/bookmarks | dmenu -p 'Select bookmark:' -i -l 10 | xargs -r xdotool type")
    end),
    awful.key({ ModKey,           }, ",", function () awful.layout.inc( 1)                end)
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
    --awful.key({ ModKey, "Control" }, "h",
        --function (c)
            --c.maximized_vertical = not c.maximized_vertical
            --c:raise()
        --end ),
    --awful.key({ ModKey, "Shift"   }, "h",
        --function (c)
            --c.maximized_horizontal = not c.maximized_horizontal
            --c:raise()
        --end )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
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
