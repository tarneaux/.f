if [ (tty) = "/dev/tty1" ]
    startx
end

alias d="doas"
alias sudo="doas"

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

alias pacman="printf \"\e[41mIT'S BLOAT!\e[0m\n\"; doas pacman --color=always"

alias vpup="doas wg-quick up vpn"
alias vpdown="doas wg-quick down vpn"

set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -Ux EDITOR nvim
set -Ux PAGER bat


set PATH ~/.local/share/gem/ruby/3.0.0/bin/ ~/.local/share/CEdev/bin/ ~/.local/bin/ /home/max/.cargo/bin/ ~/.config/emacs/bin/ ~/.nix-profile/bin/ ~/.config/scripts/ $PATH


# remove the default fish greeting for a more minimal prompt
function fish_greeting
end


if status is-interactive
    lua ~/.config/fish/z.lua --init fish | source
    set -gx _ZL_CD cd
    bind --user \e, 'history-token-search-backward'
    bind --user \e\; 'history-token-search-forward'
end


# XDG Base Directory Specification
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_STATE_HOME ~/.local/state

# Per app config
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

# Broot function (needed for broot to work)
function br --wraps=broot
    set -l cmd_file (mktemp)
    if broot --outcmd $cmd_file $argv
        read --local --null cmd < $cmd_file
        rm -f $cmd_file
        eval $cmd
    else
        set -l code $status
        rm -f $cmd_file
        return $code
    end
end

starship init fish | source

