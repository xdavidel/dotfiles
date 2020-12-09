syntax enable                 " Enables syntax highlighing

set background=dark           " tell vim what the background color looks like

function! DefaultColors()
  hi ColorColumn ctermbg=Gray guibg=Gray
  hi PMenu ctermbg=None guibg=None
  hi Comment cterm=italic gui=italic ctermfg=DarkGray guifg=DarkGray
endfunc

if has('termguicolors')
  set termguicolors
  call DefaultColors()
endif

" Toggle Color Scheme
"=================================================================
let g:focuscolour = 0

function! ToggleColorScheme()
  if (g:focuscolour)
    " colorscheme default
    set colorcolumn=
    let g:focuscolour = 0
  else
    try
      " colorscheme gruvbox-material
      set colorcolumn=80
      let g:focuscolour = 1
    catch
      " colorscheme default
      set colorcolumn=
      let g:focuscolour = 0
    endtry
  endif
endfunc
