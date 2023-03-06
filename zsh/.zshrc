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


# ==================== #
#    Miscellaneous     #
# ==================== #

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

# Save history in cache
HISTSIZE=999999999
SAVEHIST=999999999
HISTFILE=~/.cache/zsh_history

# ==================== #
#   Aliases and vars   #
# ==================== #

alias e="emacsclient -a emacs"
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

# One letter commands for the lazy
alias v="vim"
alias t='tree'
alias l="ls"
alias c="cd"
alias m="mkdir"
alias mp="mkdir -p"
alias r="trash"
alias t="tree"
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

alias ot="odt2txt --width=-1"

alias vpup="doas wg-quick up vpn"
alias vpdown="doas wg-quick down vpn"

alias cop="github-copilot-cli what-the-shell"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR=nvim
export PAGER=bat

