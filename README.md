# .f

## Screenshot
![screenshot](https://user-images.githubusercontent.com/62650051/207384869-1aa9359b-2b9f-463f-8d27-d67be9812d3b.png)

## What's used
- WM: `awesomewm`. [config](awesome/.config/awesome)
- Bar: the awesomewm bar. [config](awesome/.config/awesome)
- Editor: `neovim`. [config](neovim/.config/nvim)
- Font: `BlexMono Nerd Font`.
- Colorscheme: `gruvbox`.


## Installing
- On a fresh arch install, run:
```bash
# install yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

# clone this repo
git clone https://github.com/tarneaux/.f.git

cd .f

# install dependencies
yay -S $(cat toinstall.txt)

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
- run `stow <configs_to_install>`

  For example:

  `stow awesome/`

  `stow */`


