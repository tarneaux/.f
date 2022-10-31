set -e

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S awesome dmenu kitty neovim conky fish stow nerd-fonts-ibm-plex-mono upower exa ripgrep trash-cli bat tela-icon-theme
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

