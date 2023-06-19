#!/usr/bin/env zsh

source ~/.zshrc # Load environment variables

xset -b

xrdb ~/.Xresources

xsetroot -solid darkgrey # Set default background color. Will probably be overwritten by the DE/WM.

dbus-update-activation-environment DISPLAY XAUTHORITY

exec awesome
