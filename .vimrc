let mapleader = " "

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'potatoesmaster/i3-vim-syntax'
call plug#end()

" -- Stop old vi compatibility --
set nocompatible

" -- Set copy to clipboard --
" set clipboard=unnamedplus
vnoremap <C-c> "+y
map <C-v> "+v

" -- Basic Plugins handles --
filetype plugin on
syntax on

" -- Use UTF encoding --
set encoding=utf-8

" -- File Searching down info subfolders --
set path+=**
set wildmenu

" -- Enable numbers row  --
set number relativenumber

" -- Enable Auto Completion --
set wildmode=longest,list,full

" -- Disable auto comments --
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" -- Set Tab Size --
autocmd Filetype * setlocal tabstop=4

" -- Powerline --
set rtp+=/usr/share/powerline/bindings/vim/
" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
let g:rehash256 = 1
let g:Powerline_symbols='unicode'
let g:Powerline_theme='long'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

" -- Goyo plugin mapping --
map <leader>f :Goyo \| set linebreak<CR>

" -- Spell check mapping --
map <leader>o :setlocal spell! spelllang=en_us<CR>

" -- Change split locations --
set splitright splitbelow

" -- Split navigation mapping --
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
