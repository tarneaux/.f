echo "updading system"
sudo dnf update -y

echo "installing packages"
sudo dnf install awesome dmenu kitty neovim conky git fish stow exa ripgrep trash-cli bat dejavu-fonts-all Xorg xinit mesa-dri-drivers util-linux-user -y

echo "installing blexmono nerd font"
curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/IBMPlexMono/Mono/complete/Blex%20Mono%20Nerd%20Font%20Complete.ttf | sudo tee /usr/share/fonts/Blex\ Mono\ Nerd\ Font\ Complete.ttf > /dev/null

echo "changing shell to fish"
chsh -s /usr/bin/fish
