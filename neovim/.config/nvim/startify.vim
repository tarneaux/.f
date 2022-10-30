" Startify - start screen
Plug 'mhinz/vim-startify'

function! Awesome_conf_files()
    return [
                \ {'line': 'root', 'path': '~/.config/awesome/'},
                \ {'line': 'theme.lua', 'path': '~/.config/awesome/theme/theme.lua'},
                \ {'line': 'keys.lua', 'path': '~/.config/awesome/keys.lua'},
                \ ]
endfunction

function! My_conf_files()
    return [
                \ {'line': 'fish', 'path': "~/.config/fish/config.fish"},
                \ {'line': 'vim', 'path': '~/.config/nvim/'},
                \ {'line': 'kitty', 'path': '~/.config/kitty/kitty.conf'},
                \ ]
endfunction

if getcwd() == "/home/max"
    let g:startify_lists = [
                \ {'type': function('Awesome_conf_files'), 'header': ['Awesome']},
                \ {'type': function('My_conf_files'), 'header': ['Other config files']},
                \ ]
else
    let g:startify_lists = [
                \ {'type': 'dir', 'header': ['Files']}
                \ ]
endif

noremap <silent> <A-s> :Startify<CR>
noremap! <A-s> <Esc> :Startify<CR>
inoremap <A-s> <Esc> :Startify<CR>

