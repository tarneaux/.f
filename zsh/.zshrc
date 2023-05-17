# ==================== #
#    Plugin manager    #
# ==================== #

# Plugin manager: zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" > /dev/null 2>&1
source "${ZINIT_HOME}/zinit.zsh"


# ==================== #
#    Plugins list      #
# ==================== #

# Syntax highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

# Fish-like history search pt. 1: pressing ↑ will search through history
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
HISTORY_SUBSTRING_SEARCH_FUZZY='true'

# Fish-like history search pt. 2: the grayed out part
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Additions to the default completion system
zinit light zsh-users/zsh-completions

# ==================== #
#    Miscellaneous     #
# ==================== #

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# Starship prompt
eval "$(starship init zsh)"

# Disable vi mode.
bindkey -e

# Let me use the keys on my keyboard.
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# History options
# Infinite history
HISTSIZE=999999999
SAVEHIST=999999999
HISTFILE=~/.local/zsh_history

# Ignore duplicate commands in history. Goes hand in hand with the zsh-users history plugins as it makes it easier
# to search through history without duplicates.
setopt HIST_IGNORE_ALL_DUPS
# write to history file immediately after each command
setopt INC_APPEND_HISTORY

# Just type a directory's name to cd into it
setopt autocd

# Re-set cursor after each command
__reset-cursor() {printf '\033[5 q'}
add-zsh-hook precmd "__reset-cursor"
__reload-tmux-bar() {tmux refresh-client -S > /dev/null 2>&1}
add-zsh-hook precmd "__reload-tmux-bar"

# ==================== #
#   Aliases and vars   #
# ==================== #

# Folder shortcuts with cd ~bonjour
# Config dirs
hash -d nvim="$HOME/.config/nvim"
hash -d zsh="$HOME/.config/zsh"
hash -d tmux="$HOME/.config/tmux"

# Repos
hash -d g="$HOME/git"
hash -d gr="$HOME/git/renn.es"

# Websites
hash -d gw="$HOME/git/web/"
hash -d gwt="$HOME/git/web/tarneo.fr/"
hash -d gwr="$HOME/git/web/renn.es/"

# Add custom scripts to path
# Some of these are one-letter aliases
export PATH="$HOME/.config/scripts:$PATH"

alias e="emacsclient -a 'emacs --no-window-system'"
alias vim="nvim"
alias fm="ranger"

alias cp="cp -i"
alias mv='mv -i'

alias ls="exa --icons --group-directories-first"
alias ll="exa --icons -l --group-directories-first"
alias tree='exa --tree --icons --group-directories-first'
alias find="echo 'Use fd instead of find' && /bin/find"

alias rm="/bin/rm -i"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'

alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias m="mkdir"
alias mp="mkdir -p"
alias t="trash"
alias b="bat"
alias f="fd"
alias g="git"

alias ga="git add"
alias gap="git add -p"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gcam="git commit -am"
alias gp="git push"
alias gs="git status"
alias gl="git log --decorate --oneline --graph"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"
alias gr="git restore"
alias grs="git restore --staged"

alias d="docker"
alias dp="docker ps"
alias dpa="docker ps -a"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"

alias ot="odt2txt --width=-1"

alias vpup="sudo wg-quick up vpn"
alias vpdown="sudo wg-quick down vpn"

alias cop="github-copilot-cli what-the-shell"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR=nvim
export PAGER=bat

export QMK_HOME=~/.config/qmk/qmk_firmware

# Broot: ls replacement
source ~/.config/broot-init.zsh

# I don't want those files in my home directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# ==================== #
#     Keybindings      #
# ==================== #

# Pageup
bindkey '^[[5~' insert-last-word

# Pagedown
bindkey '^[[6~' backward-kill-word



# Without this, tmux will not work well with the HOME and END keys.
# See https://stackoverflow.com/questions/161676/home-end-keys-in-zsh-dont-work-with-putty

if [[ "$TERM" != emacs ]]; then
[[ -z "$terminfo[kdch1]" ]] || bindkey -M emacs "$terminfo[kdch1]" delete-char
[[ -z "$terminfo[khome]" ]] || bindkey -M emacs "$terminfo[khome]" beginning-of-line
[[ -z "$terminfo[kend]" ]]  || bindkey -M emacs "$terminfo[kend]" end-of-line
[[ -z "$terminfo[kich1]" ]] || bindkey -M emacs "$terminfo[kich1]" overwrite-mode
[[ -z "$terminfo[kdch1]" ]] || bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
[[ -z "$terminfo[khome]" ]] || bindkey -M vicmd "$terminfo[khome]" vi-beginning-of-line
[[ -z "$terminfo[kend]" ]]  || bindkey -M vicmd "$terminfo[kend]" vi-end-of-line
[[ -z "$terminfo[kich1]" ]] || bindkey -M vicmd "$terminfo[kich1]" overwrite-mode

[[ -z "$terminfo[cuu1]" ]]  || bindkey -M viins "$terminfo[cuu1]" vi-up-line-or-history
[[ -z "$terminfo[cuf1]" ]]  || bindkey -M viins "$terminfo[cuf1]" vi-forward-char
[[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" vi-up-line-or-history
[[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" vi-down-line-or-history
[[ -z "$terminfo[kcuf1]" ]] || bindkey -M viins "$terminfo[kcuf1]" vi-forward-char
[[ -z "$terminfo[kcub1]" ]] || bindkey -M viins "$terminfo[kcub1]" vi-backward-char

# ncurses fogyatekos
[[ "$terminfo[kcuu1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" vi-up-line-or-history
[[ "$terminfo[kcud1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" vi-down-line-or-history
[[ "$terminfo[kcuf1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcuf1]/O/[}" vi-forward-char
[[ "$terminfo[kcub1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcub1]/O/[}" vi-backward-char
[[ "$terminfo[khome]" == "^[O"* ]] && bindkey -M viins "${terminfo[khome]/O/[}" beginning-of-line
[[ "$terminfo[kend]" == "^[O"* ]] && bindkey -M viins "${terminfo[kend]/O/[}" end-of-line
[[ "$terminfo[khome]" == "^[O"* ]] && bindkey -M emacs "${terminfo[khome]/O/[}" beginning-of-line
[[ "$terminfo[kend]" == "^[O"* ]] && bindkey -M emacs "${terminfo[kend]/O/[}" end-of-line
fi
