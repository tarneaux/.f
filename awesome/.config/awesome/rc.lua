pcall(require, "luarocks.loader")

local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

-- focus windows automatically when they are raised
require("awful.autofocus")


cdir = gears.filesystem.get_configuration_dir()
home = os.getenv("HOME")

dofile(cdir .. "error_handling.lua")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(cdir .. "theme/theme.lua")


-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
terminal_cmd = terminal .. " -e "
editor = "nvim"
editor_cmd = terminal_cmd .. " " .. editor


-- Screens and layouts
dofile(cdir .. "screens.lua")

dofile(cdir .. "mouse.lua")
dofile(cdir .. "keys.lua")

dofile(cdir .. "rules.lua")

-- Signals and titlebars
dofile(cdir .. "signals.lua")

-- Autostart
-- awful.spawn.with_shell("if not pgrep Discord; discord --start-minimized; end")
-- awful.spawn.with_shell("kill conky; conky")
awful.spawn.with_shell("mpd")
awful.spawn.with_shell('rsync -r -aAXv --exclude=".cache/" --exclude="max/.local/share/Trash/" ~ user@chankla:~/backups')
awful.spawn.with_shell("picom")
awful.spawn.with_shell("nextcloud --background")


awful.spawn.with_shell("sudo mount /dev/sdb1 /mnt/hdd && pgrep rsync || rsync -r --progress .nc/ /mnt/hdd/Backups/nextcloud")

-- Configuration for my wifi adapter
awful.spawn.with_shell("~/.config/scripts/wifi_driver.sh")
