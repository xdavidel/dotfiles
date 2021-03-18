" auto-install vim-plug
let plugpath = $RTP . "/autoload/plug.vim"
if ! filereadable(plugpath)
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent execute '!curl -fLo ' . plugpath . ' --create-dirs
    \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('$RTP/autoload/plugged')
  Plug 'tpope/vim-commentary'               " Better Comments
  Plug 'tpope/vim-surround'                 " change surround with 'cs<from><to>'
  Plug 'vimwiki/vimwiki'                    " A personal wiki using vim
  Plug 'glts/vim-magnum'                    " big integer library for Vim plugins
  Plug 'glts/vim-radical'                   " Convert binary, hex, etc..

  if exists('g:vscode')
    Plug 'asvetliakov/vim-easymotion'       " Easy motion for VSCode
  else
    Plug 'unblevable/quick-scope'           " highlight navigation
    Plug 'junegunn/fzf',                    " FZF
       \ { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'                 " Fuzzy file finder
    Plug 'ap/vim-css-color'                 " Color highlights
    Plug 'neoclide/coc.nvim',               " auto completions
       \ {'branch' : 'release' }
    Plug 'metakirby5/codi.vim'              " Interactive Scratchpad for Hackers
    Plug 'junegunn/goyo.vim'                " distraction free VIM
    Plug 'preservim/nerdtree'               " file system view
"    Plug 'vim-airline/vim-airline'          " status/tabline for vim.
    Plug 'itchyny/lightline.vim'
    Plug 'easymotion/vim-easymotion'        " simpler way to use motions
    Plug 'airblade/vim-rooter'              " Have the file system follow you around
    Plug 'liuchengxu/vim-which-key'         " See what keys do like in emacs
    Plug 'puremourning/vimspector'          " Debugging in vim
    Plug 'szw/vim-maximizer'                " Maximizing vim windows
    Plug 'jreybert/vimagit'                 " Git interface inspired by emacs magit
    Plug 'dbeniamine/cheat.sh-vim'          " cht.sh integration

    " Plug 'sainnhe/gruvbox-material'       " Gruvbox Color scheme
    " Plug 'drewtempelmeyer/palenight.vim'  " Palenight color theme
    Plug 'dracula/vim', { 'as': 'dracula' } " Dracula color theme

    "File support
    "===========================
    Plug 'rust-lang/rust.vim'               " rustlang support
    Plug 'kovetskiy/sxhkd-vim'              " support for sxhkd config files
    Plug 'cespare/vim-toml'                 " tomel support
  endif
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
\  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
\|   PlugInstall --sync | q
\| endif
