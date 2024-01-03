#!/bin/sh

pgrep mako || mako &

pgrep unison-sync || ~/.config/scripts/unison-sync &

pgrep signal-desktop || signal-desktop --start-in-tray &
