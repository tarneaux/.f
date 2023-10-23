# Just setting ZDOTDIR in .zshenv causes issues with X11.
# Instead we do it here so there just can't be any issues with programs not
# setting ZDOTDIR.
export ZDOTDIR="$HOME"/.config/zsh
