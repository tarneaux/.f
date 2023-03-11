# This script will be run by the install script after the user has been created.
# It isn't meant to be run directly, and that's why there's no shebang.

# Prevent the script from being run directly
if [ "$1" != "run_correctly" ]; then
    echo "This script is not meant to be run directly. If you just installed Arch, run the install.sh script instead."
    echo "If you want to reconfigure your system, run the config.sh script instead."
    exit 1
fi

set -e

emphasis="\e[1;32m"
normal="\e[0m"

log() {
    printf "${emphasis}${1}${normal}\n"
}

# pacman and AUR packages will both be installed with yay

log "Installing yay..."
# deps (git and base-devel) are already installed by the root install script
git clone https://aur.archlinux.org/yay.git /tmp/yay > /dev/null
cd /tmp/yay

makepkg -si --noconfirm
cd -

log "AUR packages"

packages=`cat packages.txt | grep -v ^# | grep -v ^$`

for package in $packages; do
    log "Installing $package"
    yay -S --needed $package --noconfirm
done

log "Done!"

cd ~/.f

log "Now run:"
log "   - 'stow */' if you want to install all the dotfiles"
log "   - 'stow zsh' if you want to install only the zsh dotfiles. This works for any other dotfile folder."

log "If you want to get back here later on, just run 'cd ~/.f'."

