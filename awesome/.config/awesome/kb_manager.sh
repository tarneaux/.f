#!/usr/bin/env bash
# This script manages keyboard layouts and keyboard options.

INTERNAL_KEYBOARD="AT Translated Set 2 keyboard"

manage() {
    # Set keyboard layout for tarneaux supersplit
    # (see https://tarneo.fr/posts/split_keyboard)
    # The xmodmap contains configuration for specific keys which were added to the
    # US keyboard layout to be able to type French characters.
    xmodmap ~/.Xmodmap

    # Set keyboard layout for laptop


    kb_id=$(xinput -list | grep "$INTERNAL_KEYBOARD" | grep -o "id=[0-9]*" | grep -o "[0-9]*")

    setxkbmap fr -device "$kb_id" || echo "Failed to set keyboard layout for laptop"

    # Set repeat rate for both keyboards. This controls how fast a key is repeated
    # when it is held down. It's very useful to be able to repeat a key much faster,
    # and without holding it down for a long time before it starts repeating.
    xset r rate 300 50

    # Disable internal keyboard when external keyboard is plugged in
    # if `xinput --list | grep -q TRIBOARD`; then
    #     enable=0
    # else
    #     enable=1
    # fi
    # xinput --set-prop "$INTERNAL_KEYBOARD" 'Device Enabled' $enable
}

manage

while true; do
    # Wait for keyboard to be plugged in or unplugged
    inotifywait -e create,delete /dev/input/
    manage
done
