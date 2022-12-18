if [ (tty) = "/dev/tty1" ]
    startx
end

function fish_prompt
    ~/.config/fish/prompt.sh $status
end


alias rm="trash"
alias vim="nvim"
alias v="nvim"
alias ls="exa --icons --group-directories-first"
alias ll="exa --icons -l --group-directories-first"
alias lt='exa -T --icons --group-directories-first'
alias l="ls"
alias cat="bat"
alias icat="kitty +kitten icat"
alias s="swallow"
alias cp="cp --interactive"
alias mv='mv -i'
alias mkdirs='mkdir -p'
alias woman="man"


# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -Ux EDITOR nvim
set PAGER bat


set PATH ~/.local/share/gem/ruby/3.0.0/bin/ ~/.local/share/CEdev/bin/ ~/.local/bin/ /home/max/.cargo/bin/ ~/.emacs.d/bin/ ~/.nix-profile/bin/ $PATH



function fish_greeting
#    fortune -s | python3 ~/.local/bin/box.py
end


if status is-interactive
    lua ~/.config/fish/z.lua --init fish | source
    set -gx _ZL_CD cd
    bind --user \e, 'history-token-search-backward'
    bind --user \e\; 'history-token-search-forward'
end
