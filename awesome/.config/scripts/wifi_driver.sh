#!/usr/bin/bash
cd /tmp/
git clone https://github.com/McMCCRU/rtl8188gu.git
cd rtl8188gu
make
sudo make install
eject /dev/cdrom
