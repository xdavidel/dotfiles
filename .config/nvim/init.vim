let $RTP=split(&runtimepath, ',')[0]

" Disable built-in plugins
set shadafile=
let g:loaded_shada_plugin       =  1
let g:loaded_gzip               =  1
let g:loaded_tarPlugin          =  1
let g:loaded_zipPlugin          =  1
let g:loaded_2html_plugin       =  1
let g:loaded_rrhelper           =  1
let g:loaded_remote_plugins     =  1
let g:loaded_netrw              =  1
let g:loaded_netrwPlugin        =  1

if has('nvim-0.5.0') && ! exists('g:vscode')
    lua require 'start'
else
    source $RTP/legacy/start.vim
endif
 
if ! exists('g:vscode')
    source $RTP/theme.vim
endif
