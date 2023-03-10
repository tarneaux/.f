#! /bin/sh

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

while getopts "hnvu:" opt; do
    case $opt in
        h)
            print_usage
            ;;
        n)
            no_interaction=1
            ;;
        u)
            user=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            print_usage
            exit 1
            ;;
    esac
done

if [[ -z $user ]]; then
    echo "You must specify the wanted username with the -u flag."
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
[[ -n $no_interaction ]] && echo "Continue? [Y/n] " && read -n 1 -r && echo && [[ $REPLY =~ ^[Nn]$ ]] && log "Exiting." && exit 1

pacman -Syu --needed git base-devel sudo --noconfirm > /dev/null

# Create a user
log "Creating user $user..."
sudo useradd -m -s /bin/bash $user
sudo passwd $user

# Make the sudoers file
log "Writing config to /etc/sudoers..."
$sudoers_file_contents="root ALL=(ALL) ALL\n$user ALL=(ALL) NOPASSWD: ALL"
echo $visudo_file_contents | sudo EDITOR='tee -a' visudo

# Run the rest of the script as the new user
log "Switching to user $user..."

# Clone the repository
sudo -u $user bash << EOF
# TODO: remove the --branch part once the script is done
log "Cloning the repository into '~/.f'... Note that it will be hidden from ls as it starts with a period."
git clone https://github.com/tarneaux/.f.git ~/.f --depth 1 --branch installer
cd ~/.f
bash install/install.sh
