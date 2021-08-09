syntax enable                 " Enables syntax highlighing

set background=dark           " tell vim what the background color looks like

if has('termguicolors')
    set termguicolors
endif

let s:fg         = ['#F8F8F2', 253]

let s:bg4        = ['#232433', 236]
let s:bg3        = ['#1a1b26', 235]
let s:bg2        = ['#3b3d57', 237]
let s:bg1        = ['#32344a', 237]
let s:bg0        = ['#2a2b3d', 236]

let s:bg_red     = ['#ff7a93', 203]
let s:bg_green   = ['#b9f27c', 107]
let s:bg_blue    = ['#7da6ff', 110]

let s:diff_red   = ['#803d49',  52]
let s:diff_green = ['#618041',  22]
let s:diff_blue  = ['#3e5380',  17]

let s:black      = ['#06080a', 237]
let s:red        = ['#F7768E', 203]
let s:orange     = ['#FF9E64', 215]
let s:yellow     = ['#E0AF68', 179]
let s:green      = ['#9ECE6A', 107]
let s:blue       = ['#7AA2F7', 110]
let s:purple     = ['#ad8ee6', 176]
let s:grey       = ['#989aa2', 238]

let s:none       = ['NONE', 'NONE']


" Apply colors (bg, attr_list, special)
function! s:h(scope, fg, ...) 
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !has('gui_running')
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]
  execute join(l:hl_string, ' ')
endfunction


call s:h('Normal', s:fg, s:none)
call s:h('Terminal', s:fg, s:none)
call s:h('FoldColumn', s:grey, s:none)
call s:h('Folded', s:grey, s:none)
call s:h('SignColumn', s:fg, s:none)
call s:h('ToolbarLine', s:fg, s:none)

call s:h('ColorColumn', s:none, s:bg1)
call s:h('Conceal', s:grey, s:none)

call s:h('CursorColumn', s:none, s:bg1)
call s:h('CursorLine', s:none, s:bg1)
call s:h('LineNr', s:grey, s:none)
call s:h('CursorLineNr', s:fg, s:none)

call s:h('DiffAdd', s:none, s:diff_green)
call s:h('DiffChange', s:none, s:diff_blue)
call s:h('DiffDelete', s:none, s:diff_red)
call s:h('DiffText', s:none, s:none, ['reverse'])
call s:h('DiffRemoved', s:red, s:none)
call s:h('Directory', s:green, s:none)
call s:h('ErrorMsg', s:red, s:none, ['bold,underline'])
call s:h('WarningMsg', s:yellow, s:none, ['bold'])
call s:h('ModeMsg', s:fg, s:none, ['bold'])
call s:h('MoreMsg', s:blue, s:none, ['bold'])
call s:h('IncSearch', s:bg0, s:bg_red)
call s:h('Search', s:bg0, s:bg_green)
call s:h('MatchParen', s:none, s:bg4)
call s:h('NonText', s:bg4, s:none)
call s:h('Whitespace', s:bg4, s:none)
call s:h('SpecialKey', s:bg4, s:none)
call s:h('Pmenu', s:fg, s:bg2)
call s:h('PmenuSbar', s:none, s:bg2)
call s:h('PmenuSel', s:bg0, s:purple)
call s:h('WildMenu', s:bg0, s:bg_blue)

call s:h('PmenuThumb', s:none, s:grey)
call s:h('Question', s:yellow, s:none)
call s:h('SpellBad', s:red, s:none, ['undercurl'])
call s:h('SpellCap', s:yellow, s:none, ['undercurl'])
call s:h('SpellLocal', s:blue, s:none, ['undercurl'])
call s:h('SpellRare', s:purple, s:none, ['undercurl'])
call s:h('StatusLine', s:fg, s:bg3)
call s:h('StatusLineTerm', s:fg, s:bg3)
call s:h('StatusLineNC', s:grey, s:bg1)
call s:h('StatusLineTermNC', s:grey, s:bg1)
call s:h('TabLine', s:fg, s:bg4)
call s:h('TabLineFill', s:grey, s:none)
call s:h('TabLineSel', s:bg0, s:bg_red)
call s:h('VertSplit', s:black, s:none)
call s:h('Visual', s:bg4, s:blue)
call s:h('VisualNOS', s:none, s:bg3, ['underline'])
call s:h('QuickFixLine', s:blue, s:none, ['bold'])
call s:h('Debug', s:yellow, s:none)
call s:h('debugPC', s:bg0, s:green)
call s:h('debugBreakpoint', s:bg0, s:red)
call s:h('ToolbarButton', s:bg0, s:bg_blue)

call s:h('Type', s:blue, s:none)
call s:h('Structure', s:blue, s:none)
call s:h('StorageClass', s:blue, s:none)
call s:h('Identifier', s:orange, s:none)
call s:h('Constant', s:orange, s:none)

call s:h('PreProc', s:red, s:none)
call s:h('PreCondit', s:red, s:none)
call s:h('Include', s:red, s:none)
call s:h('Keyword', s:red, s:none)
call s:h('Define', s:red, s:none)
call s:h('Typedef', s:red, s:none)
call s:h('Exception', s:red, s:none)
call s:h('Conditional', s:red, s:none)
call s:h('Repeat', s:red, s:none)
call s:h('Statement', s:red, s:none)
call s:h('Macro', s:purple, s:none)
call s:h('Error', s:red, s:none)
call s:h('Label', s:purple, s:none)
call s:h('Special', s:purple, s:none)
call s:h('SpecialChar', s:purple, s:none)
call s:h('Boolean', s:purple, s:none)
call s:h('String', s:yellow, s:none)
call s:h('Character', s:yellow, s:none)
call s:h('Number', s:purple, s:none)
call s:h('Float', s:purple, s:none)
call s:h('Function', s:green, s:none)
call s:h('Operator', s:red, s:none)
call s:h('Title', s:red, s:none, ['bold'])
call s:h('Tag', s:orange, s:none)
call s:h('Delimiter', s:fg, s:none)

call s:h('Comment', s:grey, s:none)
call s:h('SpecialComment', s:grey, s:none)
call s:h('Todo', s:blue, s:none)

call s:h('Ignore', s:grey, s:none)
call s:h('Underlined', s:none, s:none, ['underline'])
