" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Coc Search & refactor
nnoremap <leader>? :CocSearch <C-R>=expand("<cword>")<CR><CR>
let g:which_key_map['?'] = 'search word'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['/'] = [ ':call Comment()'                      , 'comment'  ]
let g:which_key_map['.'] = [ ':e $MYVIMRC'                          , 'open init'  ]
let g:which_key_map[';'] = [ ':Commands'                            , 'commands'  ]
let g:which_key_map['='] = [ '<C-W>='                               , 'balance windows'  ]
let g:which_key_map['d'] = [ ':Bdelete'                             , 'delete buffer' ]
let g:which_key_map['h'] = [ '<C-W>s'                               , 'split below' ]
let g:which_key_map['m'] = [ ':call WindowSwap#EasyWindowSwap()'    , 'move window'  ]
let g:which_key_map['n'] = [ ':NERDTreeToggle'                      , 'Nerd tree'  ]
let g:which_key_map['p'] = [ ':Files'                               , 'search files'  ]
let g:which_key_map['q'] = [ 'q'                                    , 'quit'  ]
let g:which_key_map['v'] = [ '<C-W>v'                               , 'split right' ]
let g:which_key_map['W'] = [ 'w'                                    , 'write'  ]
let g:which_key_map['z'] = [ 'Goyo'                                 , 'zen'  ]"
let g:which_key_map['o'] = [ ':setlocal spell! spelllang=en_us'     , 'spell check'  ]"
let g:which_key_map['M'] = [ ':MaximizerToggle!'                    , 'Toggle Max'  ]"

" Group mappings

" a is for actions
let g:which_key_map.a = {
  \ 'name' : '+actions' ,
  \ 'c' : [':ColorizerToggle'        , 'colorizer'],
  \ 'e' : [':CocCommand explorer'    , 'explorer'],
  \ 'l' : [':Bracey'                 , 'start live server'],
  \ 'L' : [':BraceyStop'             , 'stop live server'],
  \ 'n' : [':set nonumber!'          , 'line-numbers'],
  \ 'r' : [':set norelativenumber!'  , 'relative line nums'],
  \ 'R' : [':setlocal rightleft!'    , 'Toggle ltr-rtl'],
  \ 's' : [':let @/ = ""'            , 'remove search highlight'],
  \ 'v' : [':Codi'                   , 'virtual repl on'],
  \ 'V' : [':Codi!'                  , 'virtual repl off'],
  \ 'w' : [':StripWhitespace'        , 'strip whitespace'],
  \ }

" b is for buffer
let g:which_key_map.b = {
  \ 'name' : '+buffer' ,
  \ '1' : ['b1'        , 'buffer 1'],
  \ '2' : ['b2'        , 'buffer 2'],
  \ 'd' : [':Bdelete'  , 'delete-buffer'],
  \ 'f' : ['bfirst'    , 'first-buffer'],
  \ 'h' : ['Startify'  , 'home-buffer'],
  \ 'l' : ['blast'     , 'last-buffer'],
  \ 'n' : ['bnext'     , 'next-buffer'],
  \ 'p' : ['bprevious' , 'previous-buffer'],
  \ '?' : ['Buffers'   , 'fzf-buffer'],
  \ }

" f is for find and replace
let g:which_key_map.f = {
  \ 'name' : '+find & replace' ,
  \ 'b' : [':Farr --source=vimgrep'    , 'buffer'],
  \ 'p' : [':Farr --source=rgnvim'     , 'project'],
  \ }

" s is for search
let g:which_key_map.s = {
  \ 'name' : '+search' ,
  \ '/' : [':History/'              , 'history'],
  \ ';' : [':Commands'              , 'commands'],
  \ 'a' : [':Ag'                    , 'text Ag'],
  \ 'b' : [':BLines'                , 'current buffer'],
  \ 'B' : [':Buffers'               , 'open buffers'],
  \ 'c' : [':Commits'               , 'commits'],
  \ 'C' : [':BCommits'              , 'buffer commits'],
  \ 'f' : [':Files'                 , 'files'],
  \ 'g' : [':GFiles'                , 'git files'],
  \ 'G' : [':GFiles?'               , 'modified git files'],
  \ 'h' : [':History'               , 'file history'],
  \ 'H' : [':History:'              , 'command history'],
  \ 'l' : [':Lines'                 , 'lines'] ,
  \ 'm' : [':Marks'                 , 'marks'] ,
  \ 'M' : [':Maps'                  , 'normal maps'] ,
  \ 'p' : [':Helptags'              , 'help tags'] ,
  \ 'P' : [':Tags'                  , 'project tags'],
  \ 's' : [':CocList snippets'      , 'snippets'],
  \ 'S' : [':Colors'                , 'color schemes'],
  \ 't' : [':Rg'                    , 'text Rg'],
  \ 'T' : [':BTags'                 , 'buffer tags'],
  \ 'w' : [':Windows'               , 'search windows'],
  \ 'y' : [':Filetypes'             , 'file types'],
  \ 'z' : [':FZF'                   , 'FZF'],
  \ }

" l is for language server protocol
let g:which_key_map.l = {
  \ 'name' : '+lsp' ,
  \ '.' : [':CocConfig'                          , 'config'],
  \ ';' : ['<Plug>(coc-refactor)'                , 'refactor'],
  \ 'a' : ['<Plug>(coc-codeaction)'              , 'line action'],
  \ 'A' : ['<Plug>(coc-codeaction-selected)'     , 'selected action'],
  \ 'b' : [':CocNext'                            , 'next action'],
  \ 'B' : [':CocPrev'                            , 'prev action'],
  \ 'c' : [':CocList commands'                   , 'commands'],
  \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
  \ 'D' : ['<Plug>(coc-declaration)'             , 'declaration'],
  \ 'e' : [':CocList extensions'                 , 'extensions'],
  \ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
  \ 'F' : ['<Plug>(coc-format)'                  , 'format'],
  \ 'h' : ['<Plug>(coc-float-hide)'              , 'hide'],
  \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
  \ 'I' : [':CocList diagnostics'                , 'diagnostics'],
  \ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
  \ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
  \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
  \ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
  \ 'o' : ['<Plug>(coc-openlink)'                , 'open link'],
  \ 'O' : [':CocList outline'                    , 'outline'],
  \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
  \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
  \ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
  \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
  \ 'R' : ['<Plug>(coc-references)'              , 'references'],
  \ 's' : [':CocList -I symbols'                 , 'references'],
  \ 'S' : [':CocList snippets'                   , 'snippets'],
  \ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
  \ 'u' : [':CocListResume'                      , 'resume list'],
  \ 'U' : [':CocUpdate'                          , 'update CoC'],
  \ 'z' : [':CocDisable'                         , 'disable CoC'],
  \ 'Z' : [':CocEnable'                          , 'enable CoC'],
  \ }

" T is for tabs
let g:which_key_map.T = {
  \ 'name' : '+tabline' ,
  \ 'b' : [':XTabListBuffers'         , 'list buffers'],
  \ 'd' : [':XTabCloseBuffer'         , 'close buffer'],
  \ 'D' : [':XTabDeleteTab'           , 'close tab'],
  \ 'h' : [':XTabHideBuffer'          , 'hide buffer'],
  \ 'i' : [':XTabInfo'                , 'info'],
  \ 'l' : [':XTabLock'                , 'lock tab'],
  \ 'm' : [':XTabMode'                , 'toggle mode'],
  \ 'n' : [':tabNext'                 , 'next tab'],
  \ 'N' : [':XTabMoveBufferNext'      , 'buffer->'],
  \ 't' : [':tabnew'                  , 'new tab'],
  \ 'p' : [':tabprevious'             , 'prev tab'],
  \ 'P' : [':XTabMoveBufferPrev'      , '<-buffer'],
  \ 'x' : [':XTabPinBuffer'           , 'pin buffer'],
  \ }

" w is for wiki
let g:which_key_map.w = {
  \ 'name' : '+wiki' ,
  \ 'w' : ['<Plug>VimwikiIndex'                    , 'ncdu'],
  \ 'n' : ['<plug>(wiki-open)'                     , 'ncdu'],
  \ 'j' : ['<plug>(wiki-journal)'                  , 'ncdu'],
  \ 'R' : ['<plug>(wiki-reload)'                   , 'ncdu'],
  \ 'c' : ['<plug>(wiki-code-run)'                 , 'ncdu'],
  \ 'b' : ['<plug>(wiki-graph-find-backlinks)'     , 'ncdu'],
  \ 'g' : ['<plug>(wiki-graph-in)'                 , 'ncdu'],
  \ 'G' : ['<plug>(wiki-graph-out)'                , 'ncdu'],
  \ 'l' : ['<plug>(wiki-link-toggle)'              , 'ncdu'],
  \ 'd' : ['<plug>(wiki-page-delete)'              , 'ncdu'],
  \ 'r' : ['<plug>(wiki-page-rename)'              , 'ncdu'],
  \ 't' : ['<plug>(wiki-page-toc)'                 , 'ncdu'],
  \ 'T' : ['<plug>(wiki-page-toc-local)'           , 'ncdu'],
  \ 'e' : ['<plug>(wiki-export)'                   , 'ncdu'],
  \ 'u' : ['<plug>(wiki-list-uniq)'                , 'ncdu'],
  \ 'U' : ['<plug>(wiki-list-uniq-local)'          , 'ncdu'],
  \ }

" d is for debug
let g:which_key_map.d = {
  \ 'name' : '+debug' ,
  \ 'd' : [':call vimspector#Launch()'                                  , 'Launch'],
  \ 'c' : [':call GotoWindow(g:vimspector_session_windows.code)'        , 'Goto Code'],
  \ 't' : [':call GotoWindow(g:vimspector_session_windows.tagpage)'     , 'Goto Tag'],
  \ 'v' : [':call GotoWindow(g:vimspector_session_windows.variables)'   , 'Goto Variables'],
  \ 'w' : [':call GotoWindow(g:vimspector_session_windows.watches)'     , 'Goto Watches'],
  \ 's' : [':call GotoWindow(g:vimspector_session_windows.stack_trace)' , 'Goto Stacktrace'],
  \ 'o' : [':call GotoWindow(g:vimspector_session_windows.output)'      , 'Goto Output'],
  \ 'e' : [':call vimspector#Reset()'                                   , 'Reset'],
  \ 'l' : ['<Plug>VimspectorStepInto'                                   , 'Step Into'],
  \ 'j' : ['<Plug>VimspectorStepOver'                                   , 'Step Over'],
  \ 'k' : ['<Plug>VimspectorStepOut'                                    , 'Step Out'],
  \ 'n' : ['<Plug>VimspectorRunToCursor'                                , 'Run to Cursor'],
  \ 'r' : [':call vimspector#Continue()'                                , 'Continue'],
  \ 'R' : ['<Plug>VimspectorRestart'                                    , 'Restart'],
  \ 'b' : {
  \     'name' : '+break',
  \     'p' : ['<Plug>VimspectorToggleBreakpoint'                       , 'Toggle Beakpoint'],
  \     'c' : ['<Plug>VimspectorToggleConditionalBreakpoint'            , 'Toggle Conditinal Breakpoint'],
  \     'x' : [':call vimspector#CleanLineBreakpoint()'                 , 'Clean Line Breakpoint'],
  \     },
  \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
