# This script will be run by the install script after the user has been created.
# It isn't meant to be run directly, and that's why there's no shebang.

set -e

log "Updating system..."
[[ -n $no_interaction ]] && sudo pacman -Syu --noconfirm || sudo pacman -Syu

installer() {
    packages=`cat $1 | grep -v ^# | grep -v ^$`

    if [[ -z $no_interaction ]]; then
        log "The following packages will be installed: $(echo $packages | tr -d '\n')"
        read -p "Continue? [Y/n] " -n 1 -r
        echo
        [[ $REPLY =~ ^[Nn]$ ]] && log "Skipping. You may need to install these for the dotfiles to work." && return
    fi

    for package in $packages; do
        log "Installing $package"
        $2 -S --needed $package --noconfirm > /dev/null
    done
}

# Pacman packages
log "Pacman packages"
installer pacman_packages.txt "sudo pacman"


# AUR packages

# See if yay is installed and install it if not
if ! command -v yay &> /dev/null; then
    log "Yay not found."
    if [[ -z $no_interaction ]]; then
        log "We will be installing yay, an AUR helper."
        read -p "Continue? [Y/n] " -n 1 -r
        echo
        [[ $REPLY =~ ^[Nn]$ ]] && log "Exiting." && exit 1
    fi
    log "Installing yay..."
    sudo pacman -S --needed base-devel git --noconfirm > /dev/null
    git clone https://aur.archlinux.org/yay.git /tmp/yay > /dev/null
    cd /tmp/yay
    makepkg -si --noconfirm > /dev/null
    cd -
fi


log "AUR packages"
installer aur_packages.txt "yay"


# Go back to the original directory
cd -

