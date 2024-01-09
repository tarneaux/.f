pcall(require, "luarocks.loader")

local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

-- focus windows automatically when they are raised
require("awful.autofocus")

local awesome_conf_dir = gears.filesystem.get_configuration_dir()

-- Global variables
Terminal = "alacritty"
TerminalCmd = Terminal .. " -e "
Editor = "nvim"


-- Error handling: this isn't useful here, but is if the config is used as fallback.
dofile(awesome_conf_dir .. "error_handling.lua")

-- Themes define colours, font and wallpapers.
beautiful.init(awesome_conf_dir .. "theme/theme.lua")

-- Screens, layouts, tags
dofile(awesome_conf_dir .. "screens.lua")

-- Key bindings
dofile(awesome_conf_dir .. "keys.lua")

-- Rules: how windows are placed and managed
-- If you want to make specific programs appear on specific tags, you can do that here.
dofile(awesome_conf_dir .. "rules.lua")

-- Signals: what to do when a window is created, moved, etc.
dofile(awesome_conf_dir .. "signals.lua")



-- Autostart applications

awful.spawn.with_shell("pgrep mpd || mpd")

awful.spawn.with_shell("pgrep signal-desktop || signal-desktop --start-in-tray")

-- Keyboard manager: automatically set layouts for the different keyboards I use
awful.spawn.with_shell("~/.config/scripts/manage-keyboards")

-- Output manager: automatically set outputs for the different monitors I use
-- This may restart awesomewm automatically, but should do it only when changing outputs.
-- (i.e. not start a recursive loop)
awful.spawn.with_shell("~/.config/scripts/manage-outputs")

-- Unison sync script: syncs files with my server.
awful.spawn.with_shell("pgrep unison || ~/.config/scripts/unison-sync")

-- Screen lock
awful.spawn.with_shell("xset s 300")

-- xss-lock will exit if already running, no need to pgrep.
awful.spawn.with_shell("xss-lock ~/.config/scripts/lock")
