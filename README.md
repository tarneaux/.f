# .f

## Screenshot
![screenshot](https://user-images.githubusercontent.com/62650051/207384869-1aa9359b-2b9f-463f-8d27-d67be9812d3b.png)

## What's used
- WM: `awesomewm`. [config](awesome/.config/awesome)
- Bar: the awesomewm bar. [config](awesome/.config/awesome)
- Editor: `neovim`. [config](neovim/.config/nvim)
- Font: `BlexMono Nerd Font`.
- Colorscheme: `gruvbox`.
- Shell: `fish`. [config](fish/.config/fish/)
- Prompt: customized `starship`. [config](fish/.config/starship.toml)


## Installing

### With the install script:
```bash
curl -o /tmp/install.sh https://raw.githubusercontent.com/tarneaux/.f/master/install.sh
bash /tmp/install.sh
```

### Manually
- On a fresh arch install, run these commands:
  - install yay
    ```bash
    doas pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
    ```
  - clone this repo
    ```bash
    git clone --recurse-submodules https://github.com/tarneaux/.f.git ~/.f
    ```
  - cd into it
    ```bash
    cd .f
    ```
  - install dependencies
    ```bash
    yay -S $(cat toinstall.txt)
    ```
  - Before stowing any configurations, make sure there is a .config directory in your $HOME:
    ```bash
    mkdir ~/.config
    ```
- run `stow <configs_to_install>`

  For example:

  `stow awesome/`

  `stow */`

- If you want to use my neovim configs, do this:
  - install packer (for neovim)
    ```bash
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    ```
  - Open nvim, which will probably show some errors. Just install the packages by running `:PackerInstall`, restart nvim and you'll be alright.

- If you want to have my dmscripts (awesomewm shortcut super+y), run:
  ```bash
  git clone https://github.com/tarneaux/dmscripts ~/.config/dmscripts
  ```
