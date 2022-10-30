call plug#begin()

source ~/.config/nvim/buffers.vim
source ~/.config/nvim/startify.vim
source ~/.config/nvim/lsp.vim

" GitGutter - Git diff on the left
Plug 'airblade/vim-gitgutter'

" CTRL + P - search for files
Plug 'ctrlpvim/ctrlp.vim'

" Airline - Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1 

Plug 'andweeb/presence.nvim'

Plug 'chrisbra/Colorizer'

Plug 'preservim/nerdtree'
noremap <A-o> :NERDTreeToggle<CR>
noremap! <A-o> <Esc> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1

Plug 'tpope/vim-commentary'

Plug 'chriskempson/base16-vim'

Plug 'ryanoasis/vim-devicons'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-speeddating'

" TODO: Configure this
"Plug 'folke/which-key.nvim'
call plug#end()

source ~/.config/nvim/lspconfig.vim



" This has to be after the plug#end() because the colorscheme is only
" accessible after it
colorscheme base16-gruvbox-dark-hard
set termguicolors
highlight LineNr guifg = M.colors.base03
highlight LineNr guibg = nil 
highlight NonText guifg = M.colors.base03
