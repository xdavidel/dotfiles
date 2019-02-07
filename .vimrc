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
Plug 'potatoesmaster/i3-vim-syntax'
call plug#end()

set nocompatible

" -- Set copy to clipboard --
" set clipboard=unnamedplus
vnoremap <C-c> "+y
map <C-v> "+v

filetype plugin on
syntax on

set encoding=utf-8

set number relativenumber

" -- Enable Auto Completion --
set wildmode=longest,list,full

" -- Disable auto comments --
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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
