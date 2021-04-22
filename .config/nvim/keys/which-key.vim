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
let g:which_key_map['/'] = [ ':call Comment()'                      , 'Comment'  ]
let g:which_key_map['.'] = [ ':e $MYVIMRC'                          , 'Open Init'  ]
let g:which_key_map[';'] = [ ':Commands'                            , 'Commands'  ]
let g:which_key_map['='] = [ '<C-W>='                               , 'Balance Windows'  ]
let g:which_key_map['d'] = [ ':Bdelete'                             , 'Delete Buffer' ]
let g:which_key_map['h'] = [ ':split'                               , 'Split Below' ]
let g:which_key_map['n'] = [ ':NERDTreeToggle'                      , 'Nerdtree'  ]
let g:which_key_map['p'] = [ ':Files'                               , 'Search Files'  ]
let g:which_key_map['q'] = [ 'q'                                    , 'Quit'  ]
let g:which_key_map['v'] = [ ':vs'                                  , 'Split Right' ]
let g:which_key_map['z'] = [ 'Goyo'                                 , 'Zen'  ]"
let g:which_key_map['o'] = [ ':setlocal spell! spelllang=en_us'     , 'Spellcheck'  ]"
let g:which_key_map['m'] = [ ':MaximizerToggle!'                    , 'Toggle Max'  ]"

" Group mappings

" a is for actions
let g:which_key_map.a = {
  \ 'name' : '+Actions' ,
  \ 'r' : [':set norelativenumber!'    , 'relative line nums'],
  \ 'R' : [':setlocal rightleft!'      , 'Toggle LTR-RTL'],
  \ 's' : [':let @/ = ""'              , 'Remove Search Highlight'],
  \ 't' : [':call ToggleColorScheme()' , 'Theme Toggle'],
  \ 'v' : [':!Codi'                    , 'Virtual Repl Toggle'],
  \ 'w' : [':StripWhitespace'          , 'Strip Whitespace'],
  \ }

" b is for buffer
let g:which_key_map.b = {
  \ 'name' : '+Buffer' ,
  \ '1' : ['b1'        , 'Buffer 1'],
  \ '2' : ['b2'        , 'Buffer 2'],
  \ 'd' : [':Bdelete'  , 'Delete Buffer'],
  \ 'f' : ['bfirst'    , 'First Buffer'],
  \ 'h' : ['Startify'  , 'Home Buffer'],
  \ 'l' : ['blast'     , 'Last Buffer'],
  \ 'n' : ['bnext'     , 'Next Buffer'],
  \ 'p' : ['bprevious' , 'Previous Buffer'],
  \ '?' : ['Buffers'   , 'Fzf Buffer'],
  \ }

" f is for find and replace
let g:which_key_map.f = {
  \ 'name' : '+Find & Replace' ,
  \ 'b' : [':Farr --source=vimgrep'    , 'Buffer'],
  \ 'p' : [':Farr --source=rgnvim'     , 'Project'],
  \ }

" s is for search
let g:which_key_map.s = {
  \ 'name' : '+Search' ,
  \ '/' : [':History/'              , 'History'],
  \ ';' : [':Commands'              , 'Commands'],
  \ 'a' : [':Ag'                    , 'Text Ag'],
  \ 'b' : [':BLines'                , 'Current Buffer'],
  \ 'B' : [':Buffers'               , 'Open Buffers'],
  \ 'c' : [':Commits'               , 'Commits'],
  \ 'C' : [':BCommits'              , 'Buffer Commits'],
  \ 'f' : [':Files'                 , 'Files'],
  \ 'g' : [':GFiles'                , 'Git Files'],
  \ 'G' : [':GFiles?'               , 'Modified Git Files'],
  \ 'h' : [':History'               , 'File History'],
  \ 'H' : [':History:'              , 'Command History'],
  \ 'l' : [':Lines'                 , 'Lines'] ,
  \ 'm' : [':Marks'                 , 'Marks'] ,
  \ 'M' : [':Maps'                  , 'Normal Maps'] ,
  \ 'p' : [':Helptags'              , 'Help Tags'] ,
  \ 'P' : [':Tags'                  , 'Project Tags'],
  \ 's' : [':CocList snippets'      , 'Snippets'],
  \ 'S' : [':Colors'                , 'Color Schemes'],
  \ 't' : [':Rg'                    , 'Text Rg'],
  \ 'T' : [':BTags'                 , 'Buffer Tags'],
  \ 'w' : [':Windows'               , 'Search Windows'],
  \ 'y' : [':Filetypes'             , 'File Types'],
  \ 'z' : [':FZF'                   , 'FZF'],
  \ }

" l is for language server protocol
let g:which_key_map.l = {
  \ 'name' : '+Lsp' ,
  \ '.' : [':CocConfig'                          , 'Coc Config'],
  \ ';' : ['<Plug>(coc-refactor)'                , 'Refactor'],
  \ 'a' : ['<Plug>(coc-codeaction)'              , 'Line Action'],
  \ 'A' : ['<Plug>(coc-codeaction-selected)'     , 'Selected Action'],
  \ 'b' : [':CocNext'                            , 'Next Action'],
  \ 'B' : [':CocPrev'                            , 'Prev Action'],
  \ 'c' : [':CocList commands'                   , 'Commands'],
  \ 'd' : ['<Plug>(coc-definition)'              , 'Definition'],
  \ 'D' : ['<Plug>(coc-declaration)'             , 'Declaration'],
  \ 'e' : [':CocList extensions'                 , 'Extensions'],
  \ 'f' : ['<Plug>(coc-format-selected)'         , 'Format Selected'],
  \ 'F' : ['<Plug>(coc-format)'                  , 'Format'],
  \ 'h' : ['<Plug>(coc-float-hide)'              , 'Hide'],
  \ 'i' : ['<Plug>(coc-implementation)'          , 'Implementation'],
  \ 'I' : [':CocList diagnostics'                , 'Diagnostics'],
  \ 'j' : ['<Plug>(coc-float-jump)'              , 'Float Jump'],
  \ 'l' : ['<Plug>(coc-codelens-action)'         , 'Code Lens'],
  \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'Next Diagnostic'],
  \ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'Next Error'],
  \ 'o' : ['<Plug>(coc-openlink)'                , 'Open Link'],
  \ 'O' : [':CocList outline'                    , 'Outline'],
  \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'Prev Diagnostic'],
  \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'Prev Error'],
  \ 'q' : ['<Plug>(coc-fix-current)'             , 'Quickfix'],
  \ 'r' : ['<Plug>(coc-rename)'                  , 'Rename'],
  \ 'R' : ['<Plug>(coc-references)'              , 'References'],
  \ 's' : [':CocList -I symbols'                 , 'Symbols'],
  \ 'S' : [':CocList snippets'                   , 'Snippets'],
  \ 't' : ['<Plug>(coc-type-definition)'         , 'Type Definition'],
  \ 'u' : [':CocListResume'                      , 'Resume List'],
  \ 'U' : [':CocUpdate'                          , 'Update CoC'],
  \ 'z' : [':CocDisable'                         , 'Disable CoC'],
  \ 'Z' : [':CocEnable'                          , 'Enable CoC'],
  \ }

" t is for tables
let g:which_key_map.t = {
  \ 'name' : '+Tables' ,
  \ 'm' : [':TableModeToggle'                       , 'Toggle table mode'],
  \ 't' : [':TableSize'                             , 'Table Size'],
  \ 'r' : [':TableModeRealign'                      , 'Realign'],
  \ 's' : [':TableSort'                             , 'Sort'],
  \ 'd' : {
  \     'name' : '+Delete',
  \     'r' : ['<Plug>(table-mode-delete-row)'      , 'Delete Row' ],
  \     'c' : ['<Plug>(table-mode-delete-column)'   , 'Delete Column' ],
  \     },
  \ 'f' : {
  \     'name' : '+Formula',
  \     'a' : ['<Plug>(table-mode-add-formula)'      , 'Add Formula' ],
  \     'e' : ['<Plug>(table-mode-eval-formula)'   , 'Eval Formula' ],
  \     }
  \ }

" T is for tabs
let g:which_key_map.T = {
  \ 'name' : '+Tabs' ,
  \ 'n' : [':tabNext'                 , 'next tab'],
  \ 't' : [':tabnew'                  , 'new tab'],
  \ 'p' : [':tabprevious'             , 'prev tab'],
  \ }

" w is for wiki
let g:which_key_map.w = {
  \ 'name' : '+Wiki' ,
  \ 'w' : ['<Plug>VimwikiIndex'                    , 'Wiki Index'],
  \ 'n' : ['<plug>(wiki-open)'                     , 'Open Wiki'],
  \ 'j' : ['<plug>(wiki-journal)'                  , 'Journal'],
  \ 'R' : ['<plug>(wiki-reload)'                   , 'Reload Wiki'],
  \ 'c' : ['<plug>(wiki-code-run)'                 , 'Run Code'],
  \ 'b' : ['<plug>(wiki-graph-find-backlinks)'     , 'Graph Find Backlinks'],
  \ 'g' : ['<plug>(wiki-graph-in)'                 , 'Graph In'],
  \ 'i' : ['<plug>VimwikiDiaryIndex'               , 'Open Diary'],
  \ 'G' : ['<plug>(wiki-graph-out)'                , 'Graph Out'],
  \ 'l' : ['<plug>(wiki-link-toggle)'              , 'Toggle Link'],
  \ 'd' : ['<plug>(wiki-page-delete)'              , 'Delete Page'],
  \ 'r' : ['<plug>(wiki-page-rename)'              , 'Rename Page'],
  \ 's' : ['<plug>VimwikiUISelect'                 , 'Select Wiki'],
  \ 't' : ['<plug>(wiki-page-toc)'                 , 'Table'],
  \ 'T' : ['<plug>(wiki-page-toc-local)'           , 'Local Table'],
  \ 'e' : ['<plug>(wiki-export)'                   , 'Export Wiki'],
  \ 'u' : ['<plug>(wiki-list-uniq)'                , 'Uniq List'],
  \ 'U' : ['<plug>(wiki-list-uniq-local)'          , 'Local Uniq List'],
  \ ' ' : {
  \     'name' : '+Diary',
  \     'i' : ['<Plug>VimwikiDiaryGenerateLinks'     , 'Update Diary Links' ],
  \     'm' : ['<Plug>VimwikiMakeTomorrowDiaryNote'  , 'Create Note For Tomorrow' ],
  \     't' : ['<Plug>VimwikiTabMakeDiaryNote'       , 'Create Note In a Tab' ],
  \     'w' : ['<Plug>VimwikiMakeDiaryNote'          , 'Create Note' ],
  \     'y' : ['<Plug>VimwikiMakeYesterdayDiaryNote' , 'Create Note For Yesterday' ],
  \     },
  \ }

" d is for debug
let g:which_key_map.d = {
  \ 'name' : '+Debug' ,
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
