syntax enable                 " Enables syntax highlighing

set background=dark           " tell vim what the background color looks like

if has('termguicolors')
    set termguicolors
endif

highlight Normal guibg=none
if has('nvim')
    highlight Comment cterm=italic gui=italic
    highlight StatusLineNC cterm=italic gui=italic
else
    highlight Comment cterm=none gui=none
    highlight StatusLineNC cterm=none gui=none
endif

hi  Title      ctermbg=NONE ctermfg=115 guibg=NONE    guifg=#5FAFAF cterm=NONE    gui=NONE
hi  NonText    ctermbg=NONE ctermfg=243 guibg=NONE    guifg=#3E4853 cterm=NONE    gui=NONE
hi  Identifier ctermbg=NONE ctermfg=179 guibg=NONE    guifg=#E5C078 cterm=NONE    gui=NONE
hi  Visual     ctermbg=235  ctermfg=13  guibg=#262626 guifg=#B294BB cterm=reverse gui=reverse

hi  Error          ctermbg=NONE    ctermfg=131    guibg=NONE       guifg=#af5f5f  cterm=reverse         gui=reverse
hi  ErrorMsg       ctermbg=131     ctermfg=235    guibg=#af5f5f    guifg=#262626  cterm=NONE            gui=NONE
hi  WarningMsg     ctermbg=NONE    ctermfg=12     guibg=NONE       guifg=#7D8FA3  cterm=NONE            gui=NONE
hi  helpLeadBlank  ctermbg=NONE    ctermfg=NONE   guibg=NONE       guifg=NONE     cterm=NONE            gui=NONE
hi  helpNormal     ctermbg=NONE    ctermfg=NONE   guibg=NONE       guifg=NONE     cterm=NONE            gui=NONE
hi  LineNr         ctermbg=NONE    ctermfg=110    guibg=NONE       guifg=#8FAFD7  cterm=bold            gui=bold
hi  Pmenu          ctermbg=235     ctermfg=249    guibg=#303537    guifg=#B3B8C4  cterm=NONE            gui=NONE
hi  PmenuSel       ctermbg=110     ctermfg=235    guibg=#8FAFD7    guifg=#141617  cterm=bold            gui=bold
hi  PmenuSbar      ctermbg=235     ctermfg=249    guibg=#303537    guifg=#B3B8C4  cterm=NONE            gui=NONE
hi  PmenuThumb     ctermbg=235     ctermfg=137    guibg=NONE       guifg=#171717  cterm=none            gui=none
hi  WildMenu       ctermbg=110     ctermfg=235    guibg=#8FAFD7    guifg=#141617  cterm=bold            gui=bold
hi  ignore         ctermbg=NONE    ctermfg=103    guibg=NONE       guifg=#BCBCBC  cterm=NONE            gui=NONE
hi  FoldColumn     ctermbg=NONE    ctermfg=242    guibg=#1C1C1C    guifg=#6C6C6C  cterm=NONE            gui=NONE
hi  Folded         ctermbg=NONE    ctermfg=242    guibg=#1C1C1C    guifg=#6C6C6C  cterm=NONE            gui=NONE
hi  VertSplit      ctermbg=232     ctermfg=145    guibg=#1C1F20    guifg=#1C1F20  cterm=NONE            gui=NONE
hi  IncSearch      ctermbg=9       ctermfg=0      guibg=#AF5F5F    guifg=#141617  cterm=NONE            gui=NONE
hi  Search         ctermbg=NONE    ctermfg=NONE   guibg=NONE       guifg=NONE     cterm=underline,bold  gui=underline,bold
hi  TabLine        ctermbg=232     ctermfg=249    guibg=#141617    guifg=#B3B8C4  cterm=NONE            gui=NONE
hi  TabLineFill    ctermbg=235     ctermfg=239    guibg=#303537    guifg=#303537  cterm=NONE            gui=NONE
hi  TabLineSel     ctermbg=145     ctermfg=0      guibg=#7D8FA3    guifg=#111314  cterm=NONE            gui=NONE
hi  MatchParen     ctermbg=NONE    ctermfg=11     guibg=NONE       guifg=#E5C078  cterm=bold            gui=bold
hi  SpellBad       ctermbg=52      ctermfg=9      guibg=#5F0000    guifg=#CC6666  cterm=NONE            gui=NONE
hi  SpellRare      ctermbg=53      ctermfg=13     guibg=#5F005F    guifg=#B294BB  cterm=NONE            gui=NONE
hi  SpellCap       ctermbg=17      ctermfg=12     guibg=#00005F    guifg=#81A2BE  cterm=NONE            gui=NONE
hi  SpellLocal     ctermbg=24      ctermfg=14     guibg=#005F5F    guifg=#8ABEB7  cterm=NONE            gui=NONE


" code
hi  PreProc   guifg=#C763A0
hi  Function  guifg=#46C96A
hi  Constant  guifg=#BD93F9
hi  String    guifg=#F1FA8C

hi link Boolean             Constant
hi link Character           Constant
hi link Number              Constant

hi link Float               Number

hi link Define              Preproc
hi link Include             Preproc
hi link Macro               Preproc
hi link PreCondit           PreProc

hi link Conditional         Statement
hi link Exception           Statement
hi link HelpCommand         Statement
hi link HelpExample         Statement
hi link Keyword             Statement
hi link Label               Statement
hi link Operator            Statement
hi link Repeat              Statement

hi link StorageClass        Type
hi link Structure           Type
hi link Typedef             Type

hi link Debug               Special
hi link Delimiter           Special
hi link SpecialChar         Special
hi link SpecialComment      Special
hi link Tag                 Special


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
