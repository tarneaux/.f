#! /bin/sh

set -e

emphasis="\e[1;32m"
normal="\e[0m"

# Handle flags

print_usage() {
    echo "Usage: install.sh [-h] [-n]"
    echo "  -n: No interaction mode.  Do not prompt for confirmations."
    echo "  -h: Print this help message"
}

log() {
    printf "${emphasis}${1}${normal}\n"
}

while getopts "hnv" opt; do
    case $opt in
        h)
            print_usage
            exit 0
            ;;
        n)
            no_interaction=1
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            print_usage
            exit 1
            ;;
    esac
done


# Actual script starts here


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
    sudo pacman -S --needed base-devel git --noconfirm
    git clone https://aur.archlinux.org/yay.git /tmp/yay > /dev/null
    cd /tmp/yay
    makepkg -si --noconfirm > /dev/null
    cd -
fi


log "AUR packages"
installer aur_packages.txt "yay"


