config.load_autoconfig()

c.hints.chars = "arstneio"

c.url.searchengines = {
    "DEFAULT": "https://searx.renn.es/search?q={}",
}

c.url.default_page = "https://searx.renn.es"
c.url.start_pages = "https://searx.renn.es"

# Play youtube videos with mpv
config.bind("<Ctrl+p>", "hint links spawn mpv --ytdl-format=bestvideo+bestaudio/best {hint-url}")

# Set default zoom level to 80%
c.zoom.default = "80%"

# Because I use colemak I need to bind Shift+arrows to the actions of HJKL
config.bind("<Shift+Left>", "back")
config.bind("<Shift+Right>", "forward")

config.bind("<Shift+Up>", "tab-prev")
config.bind("<Shift+Down>", "tab-next")

# Save session on quit
# (Little cheatsheet here: `:w` saves the session, and then you can restore it with `:session-load`.
#  Very handy for when you want to close the browser but come back to it later.)
c.auto_save.session = True

# Copy current url to clipboard in orgmode format
config.bind("yo", "yank inline [[{url}][{title}]]")
