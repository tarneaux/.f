# .f

## Screenshot
![Screenshot 1](https://github.com/tarneaux/.f/assets/62650051/c366c415-835c-4196-aab2-966fb2922334)
![Screenshot 2](https://github.com/tarneaux/.f/assets/62650051/0c9e6ac6-a562-432a-aee0-089f7f22302b)
![Screenshot 3](https://github.com/tarneaux/.f/assets/62650051/894f7485-0e6f-4478-a365-b1d8e076d589)




## What's used
- WM: `awesomewm`. ([config](awesome/.config/awesome))
- Bar: made using awesome's widgeting system `wibox`. ([config](awesome/.config/awesome))
- Editors:
  - `neovim`. ([config](neovim/.config/nvim))
  - `emacs` for org-mode and screenplays. ([config](emacs/.emacs.d))
- Font: `FiraCode Nerd Font`.
- Colorscheme: `gruvbox`.
- Shell: `zsh` ([config](zsh/)). I once used `fish` ([config](fish/.config/fish/))
- Prompt: customized `starship`. ([config](starship/.config/starship.toml))


## Installing

> :warning: These configurations are made to work well with my own keyboard layout. For example, when using the awesomewm configurations, you may need to change some keys. You can find my keyboard layout in [monkeyboard.pdf](monkeyboard.pdf).

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
  - install dependencies (listed in [`packages.txt`](packages.txt))
    ```bash
    bash install-packages.sh
    ```
  - Before stowing any configurations, make sure there is a .config directory in your $HOME:
    ```bash
    mkdir ~/.config
    ```
- run `stow <configs_to_install>`

  For example:

  `stow awesome/`

  `stow */`

- If you want to have my dmscripts (awesomewm shortcut super+y), run:
  ```bash
  git clone https://github.com/tarneaux/dmscripts ~/.config/dmscripts
  ```
- Awesomewm also needs the `lain` package to be installed with luarocks:
  ```bash
  sudo luarocks install lain
  ```
