xset -b

xrdb ~/.Xresources

xsetroot -solid darkgrey

xmodmap ~/.Xmodmap
xset r rate 300 50

/* setxkbmap fr */
/* setxkbmap us -device $(xinput -list | grep -i "tarneaux supersplit  " | grep -oP "(?<==)[0-9]*") */

dbus-update-activation-environment DISPLAY XAUTHORITY


exec awesome
