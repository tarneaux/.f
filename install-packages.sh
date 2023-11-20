#! /bin/bash
set -e

packages=$(grep -v ^# packages.txt | grep -v ^$)

for package in $packages; do
    echo "Installing $package"
    yay -S --needed "$package" --noconfirm
done

# Uninstall dmenu from arch repo
sudo pacman -R dmenu

# Install dmenu and st builds
cd /tmp
git clone https://github.com/tarneaux/st
cd st
make && sudo make install

cd /tmp
git clone https://github.com/tarneaux/dmenu
cd dmenu
make && sudo make install
