#! /bin/bash

packages=$(grep -v ^# packages.txt | grep -v ^$)

for package in $packages; do
    echo "Installing $package"
    yay -S --needed "$package" --noconfirm
done
