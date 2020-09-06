let mapleader =","

" Download Plug package manager
"=====================================================================
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > \
        ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

" Extensions
"=====================================================================
Plug 'tpope/vim-surround'               " change surround with 'cs<from><to>'
Plug 'tpope/vim-commentary'             " enable commenting lines
Plug 'vimwiki/vimwiki'                  " A personal wiki using vim
Plug 'glts/vim-magnum'                  " big integer library for Vim plugins
Plug 'glts/vim-radical'                 " Convert binary, hex, etc.

if !exists('g:vscode')
    Plug 'unblevable/quick-scope'       " highlight navigation
    Plug 'junegunn/fzf.vim'             " Fuzzy file finder
    Plug 'ap/vim-css-color'             " Color highlights
    Plug 'sainnhe/gruvbox-material'     " Gruvbox Color scheme
    Plug 'neoclide/coc.nvim',           " auto completions
        \ {'branch' : 'release' }
    Plug 'metakirby5/codi.vim'          " Interactive Scratchpad for Hackers
    Plug 'jreybert/vimagit'             " git for any VIM buffer
    Plug 'junegunn/goyo.vim'            " distraction free VIM
    Plug 'preservim/nerdtree'           " file system view
    Plug 'vim-airline/vim-airline'      " status/tabline for vim.
    Plug 'easymotion/vim-easymotion'    " simpler way to use motions

    "File support
    "===========================
    Plug 'rust-lang/rust.vim'           " rustlang support
    Plug 'kovetskiy/sxhkd-vim'          " support for sxhkd config files
    Plug 'cespare/vim-toml'             " tomel support
else
    Plug 'asvetliakov/vim-easymotion'   " vscode simpler way to use motions
endif

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Some basics:
set iskeyword+=-    " treat dash separated words as a word text object
set incsearch
set ignorecase
set smartcase

if !exists('g:vscode')
    nnoremap c "_c
    set nocompatible
    filetype plugin on
    syntax on
    set encoding=utf-8
    set number relativenumber
    set go=a
    set mouse=a
    set nohlsearch
    set clipboard+=unnamedplus
    set noerrorbells
    set noemoji         " emoji fix
    set expandtab
    set smarttab
    set cindent
    set tabstop=4       " number of visual spaces per TAB
    set softtabstop=4   " number of spaces in tab when editing
    set shiftwidth=4    " number of spaces to use for autoindent
    set smartindent
    set nowrap          " disable line wrapping

    " Backups & undos
    set noswapfile
    set nobackup
    set undofile        " default dir is ~/.local/share/nvim/undo

    " Colors
    set bg=dark
    if has('termguicolors')
        set termguicolors
    endif
endif

" Continue visual mode after indenting
"=====================================================================
vnoremap < <gv
vnoremap > >gv

" Disables automatic commenting on newline:
"=====================================================================
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Spell-check set to <leader>o, 'o' for 'orthography':
"=====================================================================
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Toggle from ltr to rtl
"=====================================================================
map <leader>l :setlocal rightleft!<CR>

" Check file in checkbashisms:
"=====================================================================
map <leader>s : !checkbashisms -xfp %<CR>

" Replace all is aliased to S.
"=====================================================================
nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
"=====================================================================
map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
"=====================================================================
map <leader>p :!opout <c-r>%<CR><CR>

" Ensure files are read as what I want:
"=====================================================================
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown',
    \ '.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list =
    \ [{'path': '~/.local/share/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/*
    \ set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
"=====================================================================
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace on save.
"=====================================================================
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" Run xrdb whenever Xdefaults or Xresources are updated.
"=====================================================================
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


" When not runing in VScode Client
"=====================================================================
if !exists('g:vscode')

    " Toggle Color Scheme
    "=================================================================
    let g:focuscolour = 0

    function! ToggleColorScheme()
        if (g:focuscolour)
            colorscheme default
            set colorcolumn=
            let g:focuscolour = 0
        else
            try
                colorscheme gruvbox-material
                set colorcolumn=80
                let g:focuscolour = 1
            catch
                colorscheme default
                set colorcolumn=
                let g:focuscolour = 0
            endtry
        endif
    endfunc

    nnoremap <silent> <C-W> :call ToggleColorScheme()<CR>
    inoremap <silent> <C-W> <ESC>:call ToggleColorScheme()<CR>a

    " Enable autocompletion:
    "=================================================================
    set wildmode=longest,list,full

    " Goyo plugin makes text more readable when writing prose:
    "=================================================================
    map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

    " Splits open at the bottom and right, which is non-retarded,
    " unlike vim defaults.
    "=================================================================
    set splitbelow splitright

    " Nerd tree
    "=================================================================
    map <leader>n :NERDTreeToggle<CR>
    map <C-b> :NERDTreeToggle<CR>
    autocmd BufEnter * if (winnr("$") == 1
     \ && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    let g:NERDTreeIgnore = ['^node_modules$']

    " fzf
    "=================================================================
    let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

    map <C-f> :Files<CR>
    nnoremap <C-p> :GFiles<CR>
    map <leader>b :Buffers<CR>
    nnoremap <leader>g :Rg<CR>
    nnoremap <leader>t :Tags<CR>
    nnoremap <leader>m :Marks<CR>

    let g:fzf_tags_command = 'ctags -R'

    " Always enable preview window on the right with 60% width
    let g:fzf_preview_window = 'right:60%'

    " Border color
    let g:fzf_layout = {'up':'~90%', 'window': {
     \ 'width': 0.8, 'height': 0.8,'yoffset':0.5,
     \ 'xoffset': 0.5, 'border': 'sharp' } }

    let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
    let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"

    " Customize fzf colors to match color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

    "Get Files
    command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options':
        \ ['--layout=reverse', '--info=inline']}), <bang>0)

    " Get text in files with Rg
    command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   "rg --column --line-number --no-heading
    \       --color=always --smart-case
    \       --glob '!.git/**' ".shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)

    " Ripgrep advanced
    function! RipgrepFzf(query, fullscreen)
        let command_fmt = 'rg --column --line-number --no-heading
            \ --color=always --smart-case %s || true'
        let initial_command = printf(command_fmt, shellescape(a:query))
        let reload_command = printf(command_fmt, '{q}')
        let spec = {'options': ['--phony', '--query', a:query,
            \ '--bind', 'change:reload:'.reload_command]}
        call fzf#vim#grep(
            \ initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

    " Git grep
    command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \   'git grep --line-number '.shellescape(<q-args>), 0,
    \   fzf#vim#with_preview(
    \       {'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

    " Quickscope
    "=================================================================
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

    " Coc
    "=================================================================
    let g:coc_global_extensions = [
    \ 'coc-rls',
    \ 'coc-python',
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-json',
    \ ]

    set nowritebackup " This is recommended by coc

    set hidden "Some servers have issues with backup files
    set updatetime=300

    set shortmess+=c "Don't give |ins-completion-menu| messages

    " set signcolumn=yes "Always show signcolumns

    inoremap <silent><expr> <TAB>
            \   pumvisible() ? "\<C-n>" :
            \   <SID>check_back_space() ? "\<TAB>" :
            \   coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-k>" : "\<C-j>"


    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1] =~# '\s'
    endfunction

    inoremap <silent><expr> <c-space> coc#refresh()

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documenatation()<CR>
    function! s:show_documenatation()
        if (index(['vim', 'help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    "Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    "Remap for rename current word
    nmap <F2> <Plug>(coc-rename)
    nmap cr <Plug>(coc-rename)

    "Remap for format selected region
    xmap <leader>f <Plug>(coc-format-selected)
    nmap <leader>f <Plug>(coc-format-selected)

    "Remap for do codeAction of current line
    nmap <leader>ac <Plug>(coc-codeaction)
    "Autofix current line problem
    nmap <leader>qf <Plug>(coc-fix-current)

    " Shortcutting split navigation, saving a keypress:
    "=================================================================
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Terminal window navigation
    "=================================================================
    tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l
    inoremap <C-h> <C-\><C-N><C-w>h
    inoremap <C-j> <C-\><C-N><C-w>j
    inoremap <C-k> <C-\><C-N><C-w>k
    inoremap <C-l> <C-\><C-N><C-w>l
    tnoremap <Esc> <C-\><C-n>

    " Use alt + hjkl to resize windows
    "=================================================================
    nnoremap <silent> <M-k>    :resize -2<CR>
    nnoremap <silent> <M-j>    :resize +2<CR>
    nnoremap <silent> <M-l>    :vertical resize -2<CR>
    nnoremap <silent> <M-h>    :vertical resize +2<CR>

    " Codi
    "=================================================================
    let g:codi#virtual_text_prefix = " "

    let g:codi#aliases = {
        \ 'javascript.jsx': 'javascript',
    \ }

    " Copy selected text to system clipboard
    " (requires gvim/nvim/vim-x11 installed):
    "=================================================================
    vnoremap <C-c> "+y
    " map <C-v> "+P

    " Enable Goyo by default for mutt writting
    "=================================================================
    autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
    autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
    autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
    autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

    " Easymotion
    "=====================================================================
    map <leader><leader>f <Plug>(easymotion-overwin-f)
    map <leader><leader>j <Plug>(easymotion-overwin-line)
    map <leader><leader>k <Plug>(easymotion-overwin-line)
    map <leader><leader>w <Plug>(easymotion-overwin-w)

endif
