" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_tags_command = 'ctags -R'

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

" Border color
let g:fzf_layout = {'up':'~90%', 'window': {
  \ 'width': 0.8, 'height': 0.8,'yoffset':0.5,
  \ 'xoffset': 0.5, 'border': 'sharp'  } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"

" Customize fzf colors to match your color scheme
let g:fzf_colors =
  \ { 'fg':    ['fg', 'Normal'],
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
  \ ['--layout=reverse', '--inline-info']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading 
  \       --color=always --smart-case 
  \       --glob '!.git/**' ".shellescape(<q-args>), 1,
  \    fzf#vim#with_preview(), <bang>0)

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
  \     {'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
