# This script will be run by the install script after the user has been created.
# It isn't meant to be run directly, and that's why there's no shebang.

set -e

emphasis="\e[1;32m"
normal="\e[0m"

# Handle flags

print_usage() {
    echo "Usage: install.sh [-h] [-n]"
    echo "  -n: No interaction mode.  Do not prompt for confirmations."
    echo "  -h: Print this help message"
    exit 1
}

log() {
    printf "${emphasis}${1}${normal}\n"
}

log "Updating system..."

installer() {
    packages=`cat $1 | grep -v ^# | grep -v ^$`

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

