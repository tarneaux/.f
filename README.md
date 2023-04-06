# .f

## Screenshot
![screenshot](https://user-images.githubusercontent.com/62650051/229812179-9b6f8e52-110c-45ba-9de2-9f7c92e3811f.png)


## What's used
- WM: `awesomewm`. ([config](awesome/.config/awesome))
- Bar: the awesomewm bar. ([config](awesome/.config/awesome))
- Editors:
  - `neovim`. ([config](neovim/.config/nvim))
  - `emacs` for org-mode and screenplays. ([config](emacs/.emacs.d))
- Font: Altough these days I use `Fantasque Sans Mono`, the screenshot above has the `BlexMono Nerd Font`.
- Colorscheme: `gruvbox`.
- Shell: `zsh` ([config](zsh/)). I once used `fish` ([config](fish/.config/fish/))
- Prompt: customized `starship`. ([config](starship/.config/starship.toml))


## Installing

### With the install script (fast but not recommended):
```bash
curl -o /tmp/install.sh https://raw.githubusercontent.com/tarneaux/.f/master/install.sh
bash /tmp/install.sh <username to create>
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
    yay -S $(cat packages.txt)
    ```
    You may run into errors while running this command. If you do just remove the comments in packages.txt.
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

