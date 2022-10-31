xset -b

xrdb ~/.Xresources

xsetroot -solid darkgrey

setxkbmap fr

dbus-update-activation-environment DISPLAY XAUTHORITY

exec awesome
