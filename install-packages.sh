#! /bin/bash
set -e

packages=$(sed 's/#.*$//' packages.txt | tr '\n' ' ' | sed -E "s/ +/ /g" | sed 's/^ //g')

echo "Installing packages: $packages"

# Installing all packages...

yay -S --needed $packages

# Uninstall dmenu from arch repo if present
if pacman -Qi dmenu &> /dev/null; then
    sudo pacman -Rsn dmenu
fi

# Install dmenu build if not already installed
if ! type dmenu &> /dev/null; then
    cd /tmp
    git clone https://github.com/tarneaux/dmenu
    cd dmenu
    make && sudo make install
fi
