autocmd BufEnter * if (winnr("$") == 1
 \ && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeIgnore = ['^node_modules$']
