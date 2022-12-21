#!/usr/bin/bash
eject /dev/disk/by-label/20180918_154309
if [ $? -eq 0 ]; then
    cd /tmp/
    git clone https://github.com/McMCCRU/rtl8188gu.git
    cd rtl8188gu
    make
    sudo make install
else
    echo "that's not connected"
fi
