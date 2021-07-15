let $RTP=split(&runtimepath, ',')[0]

if has('nvim-0.5.0')
    lua require 'start'
else
    source $RTP/legacy/start.vim
    if ! exists('g:vscode')
        source $RTP/theme.vim
    endif
endif

