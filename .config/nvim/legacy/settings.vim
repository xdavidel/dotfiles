set nocompatible
filetype plugin on
set formatoptions-=cro                       " Stop newline continution of comments
set iskeyword+=-                             " treat dash separated words as a word text object"
set incsearch smartcase  ignorecase hlsearch " Better search
set backspace=indent,eol,start               " make backspace greet again
set hidden                                   " Required to keep multiple buffers open multiple buffers
set nowrap                                   " Display long lines as just one line
set encoding=utf-8                           " The encoding displayed
set fileencoding=utf-8                       " The encoding written to file
set pumheight=10                             " Makes popup menu smaller
set scrolloff=5                              " Scrolling offset
set ruler              	                     " Show the cursor position all the time
set cmdheight=2                              " More space for displaying messages
set mouse=a                                  " Enable your mouse
set noerrorbells
set noemoji                                  " emoji fix
set splitbelow                               " Horizontal splits will automatically be below
set splitright                               " Vertical splits will automatically be to the right
set conceallevel=0                           " So that I can see `` in markdown files
set tabstop=4                                " Insert 4 spaces for a tab
set softtabstop=4                            " Number of spaces in tab when editing
set shiftwidth=4                             " Number of space characters inserted for indentation
set smarttab                                 " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                                " Converts tabs to spaces
set smartindent                              " Makes indenting smart
set autoindent                               " Good auto indent
set number relativenumber                    " Line numbers
set cursorline                               " Enable highlighting of the current line
set nobackup                                 " This is recommended by coc
set nowritebackup                            " This is recommended by coc
set noswapfile
set undofile                                 " default dir is ~/.local/share/nvim/undo
set shortmess+=c                             " Don't pass messages to |ins-completion-menu|.
set updatetime=300                           " Faster completion
set clipboard+=unnamedplus                   " Copy paste between vim and everything else

if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

hi SignColumn ctermbg=None guibg=None

" Disables automatic commenting on newline:
"=====================================================================
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace on save.
"=====================================================================
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
endfun
autocmd BufWritePre * :call TrimWhitespace()

" Run xrdb whenever Xdefaults or Xresources are updated.
"=====================================================================
autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Update binds when sxhkdrc is updated.
"=====================================================================
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Update binds when bspwmrc is updated.
"=====================================================================
autocmd BufWritePost ~/.config/bspwm/bspwmrc !~/.config/bspwm/bspwmrc

" Turns off highlighting on the bits of code that are changed, so the line
" that is changed is highlighted but the actual text that has changed stands
" out on the line and is readable.
"=====================================================================
if &diff
    highlight! link DiffText MatchParen
endif

" You can't stop me
"====================================================================="
cmap w!! w !sudo tee %
