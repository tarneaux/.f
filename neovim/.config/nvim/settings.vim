" Sync system clipboard and default clipboard register
set clipboard^=unnamed

set undofile " keep undo history
set undodir=~/.config/nvim/undodir " store undo history in ~/.config/nvim/undodir instead of the current folder

let mapleader = " " 

" set lcs=lead:⋅ " show leading spaces as dots
" set list " show invisible characters


set scrolloff=1 " keep 5 lines above and below cursor

set autoread " automatically reload file if changed outside of vim

set noswapfile

syntax enable " Enable syntax highlighting

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Relative line numbers
set rnu

" To exit insert mode, press Alt+F
inoremap <A-f> <Esc>

" Use jklm to move around instead of hjkl
noremap m l
noremap l k
noremap k j
noremap j h

" Use Alt+{jklm} to move around in insert mode
inoremap <A-j> <left>
inoremap <A-k> <down>
inoremap <A-l> <up>
inoremap <A-m> <right>

"wrap lines
set wrap linebreak

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

inoremap <A-w> <Esc> :w<CR>i
nnoremap <A-w> :w<CR>

set spell
"set spelllang=en_us,fr_fr
set spelllang=en_us
"set spelllang=en_us,fr_fr
"


highlight SignColumn guibg=NONE
