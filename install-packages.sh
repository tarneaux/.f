#! /bin/bash

packages=`cat packages.txt | grep -v ^# | grep -v ^$`

for package in $packages; do
    echo "Installing $package"
    yay -S --needed $package --noconfirm
done
