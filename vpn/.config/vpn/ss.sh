#! /bin/bash
if ! sudo killall openvpn; then
    sudo openvpn ~/.config/vpn/vpn.ovpn > /dev/null &
    disown
fi
