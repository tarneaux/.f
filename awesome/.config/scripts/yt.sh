#!/bin/bash
url=$(ytfzf -DL)
yt-dlp -o - "$url" | mpv  -

