# .f

## Screenshot
![screenshot](https://user-images.githubusercontent.com/62650051/229812179-9b6f8e52-110c-45ba-9de2-9f7c92e3811f.png)


## What's used
- WM: `awesomewm`. ([config](awesome/.config/awesome))
- Bar: made using awesome's widgeting system `wibox`. ([config](awesome/.config/awesome))
- Editors:
  - `neovim`. ([config](neovim/.config/nvim))
  - `emacs` for org-mode and screenplays. ([config](emacs/.emacs.d))
- Font: Altough these days I use `Fantasque Sans Mono`, the screenshot above has the `BlexMono Nerd Font`.
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

- If you want to use any of my configs that run in an X window (terminal, emacs, awesomewm), you will need the font I use: [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans/releases).
  To install it, just copy everything from the `TTF` directory in the archive to `/usr/share/fonts/TTF/`.

- If you want to have my dmscripts (awesomewm shortcut super+y), run:
  ```bash
  git clone https://github.com/tarneaux/dmscripts ~/.config/dmscripts
  ```

