#! /bin/sh

set -e

emphasis="\e[1;32m"
normal="\e[0m"

log() {
    printf "${emphasis}${1}${normal}\n"
}

user=$1

if [[ -z $user ]]; then
    echo "You must specify the wanted username after the command."
    exit 1
fi

# Actual script starts here

# Check that we are running on a brand new Arch install without any user
if [[ -n $(ls /home) ]]; then
    log "It appears that you already have a user set up on this system. This script is only for a fresh install."
    log "Exiting."
    exit 1
fi

# Check that the user is on Arch
if ! command -v pacman &> /dev/null; then
    log "This script is only compatible with Arch Linux."
    exit 1
fi

# Install some basic dependencies
log "Installing dependencies (git, base-devel, sudo)..."

pacman -Syu --needed git base-devel sudo --noconfirm > /dev/null

# Create a user
log "Creating user $user..."
sudo useradd -m -s /bin/bash $user
sudo passwd $user

# Make the sudoers file
log "Writing config to /etc/sudoers..."

sudo EDITOR='tee' visudo << EOF
root ALL=(ALL) ALL
$user ALL=(ALL) NOPASSWD: ALL
EOF


# Run the rest of the script as the new user
log "Switching to user $user..."

log "Cloning the repository into '~/.f'... Note that it will be hidden from ls as it starts with a period."

# Clone the repository
sudo -u $user bash << EOF
# TODO: remove the --branch part once the script is done
git clone https://github.com/tarneaux/.f.git ~/.f --depth 1 --recurse-submodules
cd ~/.f
bash user.sh run_correctly
EOF
