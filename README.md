# .f

## Screenshot
![image](https://user-images.githubusercontent.com/62650051/204324745-7b7c1fd1-5bbb-40a0-b9a1-c1bdaab9fea1.png)

## What's used
- WM: `awesomewm`. [config](awesome/.config/awesome)
- Bar: the awesomewm bar. [config](awesome/.config/awesome)
- Editor: `neovim`. [config](neovim/.config/nvim)
- System monitor: `conky`. [config](awesome/.config/conky)
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


