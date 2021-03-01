" g Leader key
let mapleader=" "

" let localleader=" "
nnoremap <Space> <Nop>

" currently does work in which-key
nnoremap <leader>c :w! \| !compiler "<c-r>%"<CR>
nnoremap <leader>b :!checkbashisms -xfp %<CR>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Capital Y should behave like this
nnoremap Y y$

" Wrap text
nnoremap <silent> <M-z> :set wrap!<CR>
inoremap <silent> <M-z> <Esc>:set wrap!<CR>a

if exists('g:vscode')
  " Simulate same TAB behavior in VSCode
  nmap <Tab> :Tabnext<CR>
  nmap <S-Tab> :Tabprev<CR>

else

  " Move lines
  xnoremap <silent>J :m '>+1<CR>gv=gv
  xnoremap <silent>K :m '<-2<CR>gv=gv
  xnoremap <silent><M-down> :m '>+1<CR>gv=gv
  xnoremap <silent><M-up>   :m '<-2<CR>gv=gv

  nnoremap <silent><M-down> v:m '>+1<CR>gv=gv<Esc>
  nnoremap <silent><M-up>   v:m '<-2<CR>gv=gv<Esc>

  inoremap <silent><M-down> <Esc>v:m '>+1<CR>gv=gv<Esc>a
  inoremap <silent><M-up>   <Esc>v:m '<-2<CR>gv=gv<Esc>a

  " TAB in general mode will move to text buffer
  nnoremap <silent> <TAB> :bnext<CR>

  " SHIFT-TAB will go back
  nnoremap <silent> <S-TAB> :bprevious<CR>

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

  vnoremap <C-c> "+y

  "Replace all is aliased to S
  nnoremap S :%s//g<Left><Left>

endif
