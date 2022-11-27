xset -b

xrdb ~/.Xresources

xsetroot -solid darkgrey

/* setxkbmap fr */
/* setxkbmap us -device $(xinput -list | grep -i "tarneaux supersplit  " | grep -oP "(?<==)[0-9]*") */

dbus-update-activation-environment DISPLAY XAUTHORITY


exec awesome
