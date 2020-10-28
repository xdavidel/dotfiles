" g Leader key
let mapleader=" "

" let localleader=" "
nnoremap <Space> <Nop>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Capital Y should behave like this
nnoremap Y y$

if exists('g:vscode')
  " Simulate same TAB behavior in VSCode
  nmap <Tab> :Tabnext<CR>
  nmap <S-Tab> :Tabprev<CR>
else

  " I hate escape more than anything else
  inoremap jk <Esc>
  inoremap kj <Esc>

  " Easy CAPS
  " inoremap <c-u> <ESC>viwUi
  " nnoremap <c-u> viwU<Esc>

  " TAB in general mode will move to text buffer
  nnoremap <silent> <TAB> :bnext<CR>

  " SHIFT-TAB will go back
  nnoremap <silent> <S-TAB> :bprevious<CR>

  " Move selected line / block of text in visual mode
  " shift + k to move up
  " shift + j to move down
  xnoremap K :move '<-2<CR>gv-gv
  xnoremap J :move '>+1<CR>gv-gv

  " <TAB>: completion.
  inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

  map <C-b> :NERDTreeToggle<CR>

  " No highlight on search
  nnoremap <silent> <C-n> :nohl<CR>
  inoremap <silent> <C-n> <ESC>:nohl<CR>a

  " Better window navigation
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

  " Terminal window navigation
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>

  " Use alt + hjkl to resize windows
  nnoremap <silent> <M-j>    :resize -2<CR>
  nnoremap <silent> <M-k>    :resize +2<CR>
  nnoremap <silent> <M-h>    :vertical resize -2<CR>
  nnoremap <silent> <M-l>    :vertical resize +2<CR>

  nnoremap <silent> <C-W> :call ToggleColorScheme()<CR>
  inoremap <silent> <C-W> <ESC>:call ToggleColorScheme()<CR>

  vnoremap <C-c> "+y

  "Replace all is aliased to S
  nnoremap S :%s//g<Left><Left>

endif
