if [ (tty) = "/dev/tty1" ]
    startx
end

fish_vi_key_bindings

alias vim="nvim"
alias v="nvim"

alias ls="exa --icons --group-directories-first"
alias ll="exa --icons -l --group-directories-first"
alias lt='exa -T --icons --group-directories-first'
alias l="ls"

alias cat="bat"

alias rm="trash"

alias cp="cp -i"
alias mv='mv -i'

alias md="mkdir"
alias mds='mkdir -p'

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

# Colorize grep output (good for log files)
alias grep='grep --color=auto'


set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -Ux EDITOR nvim
set -Ux PAGER bat


set PATH ~/.local/share/gem/ruby/3.0.0/bin/ ~/.local/share/CEdev/bin/ ~/.local/bin/ /home/max/.cargo/bin/ ~/.emacs.d/bin/ ~/.nix-profile/bin/ $PATH


# remove the default fish greeting for a more minimal prompt
function fish_greeting
end


if status is-interactive
    lua ~/.config/fish/z.lua --init fish | source
    set -gx _ZL_CD cd
    bind --user \e, 'history-token-search-backward'
    bind --user \e\; 'history-token-search-forward'
end

starship init fish | source
