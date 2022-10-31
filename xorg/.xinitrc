xset -b

xrdb ~/.Xresources

xsetroot -solid darkgrey

dbus-update-activation-environment DISPLAY XAUTHORITY

exec awesome
