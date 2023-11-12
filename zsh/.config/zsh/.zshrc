# ==================== #
#   Environment vars   #
# ==================== #

# I don't want those files in my home directory (these variables are also used throughout the zsh config you're reading)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# For programs that (annoyingly) don't follow the XDG spec without additional
# configuration
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export GOPATH="$XDG_DATA_HOME"/go
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export QMK_HOME=~/.config/qmk
export KUBECONFIG="$XDG_CONFIG_HOME"/kube/kubeconfig

# Other environment variables
export QT_QPA_PLATFORMTHEME="qt6ct"

# PAGER, EDITOR, etc.
export PAGER="bat -p"
export EDITOR=nvim

# Add the --jump-target=.5 option to the default pager command for bat.
# This allows seeing all around the match when searching with /, instead of
# putting it at the top of the screen.
export BAT_PAGER="less -RF --jump-target=.5"

# using bat as a manpager is buggy, so we use less instead
export MANPAGER="$BAT_PAGER"


# PATH helper function
__pathadd() {
    export PATH="$1:$PATH"
}

__pathadd "$HOME/.local/bin"
__pathadd "$CARGO_HOME/bin"
__pathadd "$GOPATH/bin"
__pathadd "$XDG_CONFIG_HOME"/scripts


# ==================== #
#    Plugin manager    #
# ==================== #

# Plugin manager: zinit
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
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
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
_comp_options+=(globdots)		# Include hidden files.

# History options
# Infinite history
HISTSIZE=999999999
SAVEHIST=999999999
HISTFILE="$XDG_DATA_HOME/zsh_history"

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

alias e="emacsclient -a 'emacs --no-window-system'"
alias vim="nvim"
alias fm="ranger"

alias cp="cp -i"
alias mv='mv -i'

alias ls="exa --icons --group-directories-first"
alias ll="exa --icons -l --group-directories-first"
alias tree='exa --tree --icons --group-directories-first'

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
alias lg="lazygit"

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
alias dp="docker ps -a --format 'table {{.Names}}\t{{.Status}}'"
alias dpa="docker ps -a"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"

alias ot="odt2txt --width=-1"

alias vpup="sudo wg-quick up vpn"
alias vpdown="sudo wg-quick down vpn"

alias cop="github-copilot-cli what-the-shell"

alias randpass="openssl rand -hex 32"
alias randpassbase64="openssl rand -base64 32"

alias ta="tmux attach -t"

alias rennes="ssh -t cocinero \"./start-tmux\""

# Little scripts with curl
wttr() { curl -s "wttr.in/$1" }
picopinout() { curl -s https://gabmus.org/pico_pinout | bat -p }

# Tmux aliases for different project types (Hugo, Node, etc.)
source "$ZDOTDIR/tmux_aliases.zsh"

# ==================== #
#        Prompt        #
# ==================== #

# Enable substitution in the prompt.
setopt prompt_subst

source "$ZDOTDIR/git_info.zsh"

PROMPT=''
# PROMPT+='%F{yellow}%n@%m ' # Display the username followed by @ and hostname in yellow
PROMPT+='%F{blue}%~' # Display the current working directory in blue
PROMPT+='%F{red}$(__git_info)%f ' # Display the vcs info in red
PROMPT+='%(?.%F{green}λ .%F{red}λ )' # Display a green prompt if the last command succeeded, or red if it failed
PROMPT+='%f' # Reset the text color

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
