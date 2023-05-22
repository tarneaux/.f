c.hints.chars = "arstneio"

c.url.searchengines = {
    "DEFAULT": "https://searx.be/search?q={}",
}

# Play youtube videos with mpv
config.bind("<Ctrl+p>", "hint links spawn mpv --ytdl-format=bestvideo+bestaudio/best {hint-url}")

# Set default zoom level to 80%
c.zoom.default = "80%"

config.load_autoconfig()
