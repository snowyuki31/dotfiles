"----------------------------
" vim-jetpack
"----------------------------
runtime */jetpack.vim
call jetpack#begin()
Jetpack 'vim-airline/vim-airline'
Jetpack 'vim-airline/vim-airline-themes'
Jetpack 'ryanoasis/vim-devicons'
call jetpack#end()

"----------------------------
" Color options
"----------------------------
set background=dark
colorscheme hybrid

"----------------------------
" Search options
"----------------------------
set ignorecase

set smartcase

set incsearch

set hlsearch

"----------------------------
" Operation settings
"----------------------------
set whichwrap=b,s,h,l,<,>,[,],~

set mouse=a

" 削除でヤンクしない
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D

"----------------------------
" Display settings
"----------------------------
" Use pasteboard
set clipboard+=unnamed

set number
set laststatus=2
set showcmd
set showmatch

nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
syntax on
set cursorline
set ruler
set ttimeoutlen=50
set tabstop=2

"----------------------------
" Airline settings
"----------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_a = airline#section#create(['mode', 'crypt'])
let g:airline_section_warning = 0
let g:airline_section_error = 0
