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
sudo pacman -S --needed base-devel git --noconfirm > /dev/null
git clone https://aur.archlinux.org/yay.git /tmp/yay > /dev/null
cd /tmp/yay

# run makepkg without interaction: https://bbs.archlinux.org/viewtopic.php?pid=1529136#p1529136
source PKGBUILD
pacman -S --asdeps $depends $makedepends
sudo -u nobody makepkg 

cd -

log "AUR packages"

packages=`cat packages.txt | grep -v ^# | grep -v ^$`

for package in $packages; do
    log "Installing $package"
    $2 -S --needed $package --noconfirm
done

log "Done!"
log "Now run config.sh to select configs to stow."

log "If you want to get back here later on, just run 'cd ~/.f'."


