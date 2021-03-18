syntax enable                 " Enables syntax highlighing

set background=dark           " tell vim what the background color looks like

if has('termguicolors')
  set termguicolors
endif

colorscheme dracula

highlight Normal guibg=none
highlight ColorColumn ctermbg=0 guibg=grey
highlight Normal guibg=none
" highlight LineNr guifg=#ff8659
" highlight LineNr guifg=#aed75f
highlight LineNr guifg=#5eacd3
highlight netrwDir guifg=#5eacd3
highlight qfFileName guifg=#aed75f
highlight Comment cterm=italic gui=italic
" highlight PMenu ctermbg=None guibg=None

"" Toggle Color Scheme
""=================================================================
let g:focuscolour = 0

function! ToggleColorScheme()
 if (g:focuscolour)
   set colorcolumn=
   let g:focuscolour = 0
 else
     set colorcolumn=80
     let g:focuscolour = 1
 endif
endfunc
