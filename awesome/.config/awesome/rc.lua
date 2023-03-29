pcall(require, "luarocks.loader")

local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

-- focus windows automatically when they are raised
require("awful.autofocus")


-- Global variables
Cdir = gears.filesystem.get_configuration_dir()
Home = os.getenv("HOME")

Terminal = "alacritty"
TerminalCmd = Terminal .. " -e "
Editor = "nvim"
EditorCmd = TerminalCmd .. " " .. Editor


-- Error handling: this isn't useful here, but is if the config is used as fallback.
dofile(Cdir .. "error_handling.lua")

-- Themes define colours, font and wallpapers.
beautiful.init(Cdir .. "theme/theme.lua")

-- Screens, layouts, tags
dofile(Cdir .. "screens.lua")

-- Key bindings
dofile(Cdir .. "keys.lua")

-- Rules: how windows are placed and managed
-- If you want to make specific programs appear on specific tags, you can do that here.
dofile(Cdir .. "rules.lua")

-- Signals: what to do when a window is created, moved, etc.
dofile(Cdir .. "signals.lua")



-- Autostart applications

-- Conky: system monitor
-- awful.spawn.with_shell("killall conky; conky")

-- Xmodmap: remap keys. I use this for my keyboard layout.
awful.spawn.with_shell("xmodmap ~/.Xmodmap")

-- Xset: set keyboard repeat rate. I like it fast.
awful.spawn.with_shell("xset r rate 300 50")

-- mpd: music player daemon
awful.spawn.with_shell("mpd")

-- Picom: compositor. Allows transparency and other eyecandy.
-- awful.spawn.with_shell("picom")

-- Nextcloud: sync files with your nextcloud server
-- awful.spawn.with_shell("nextcloud --background")

-- Emacs: I use emacs as my secondary editor (for screenplays)
-- Orgmode is also configured in neovim, so I only rarely use emacs.
-- Running it in the backgroud allows it to start faster when I need it.
awful.spawn.with_shell("emacs --daemon")
