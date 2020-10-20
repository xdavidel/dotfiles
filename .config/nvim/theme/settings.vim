hi Comment cterm=italic

syntax enable                 " Enables syntax highlighing

set background=dark           " tell vim what the background color looks like

if has('termguicolors')
  set termguicolors
  " hi LineNr ctermbg=NONE guibg=NONE
endif

" Toggle Color Scheme  1
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
