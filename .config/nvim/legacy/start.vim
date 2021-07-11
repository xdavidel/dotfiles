" General Settings
source $RTP/legacy/plugins.vim
source $RTP/legacy/settings.vim
source $RTP/legacy/keys/mappings.vim
source $RTP/legacy/plug-config/vim-commentary.vim
source $RTP/legacy/plug-config/quick-scope.vim
source $RTP/legacy/plug-config/easy-motion.vim

if exists('g:vscode')
    source $RTP/legacy/vscode/settings.vim
else
    source $RTP/legacy/keys/which-key.vim
    source $RTP/legacy/plug-config/fzf.vim
    source $RTP/legacy/plug-config/codi.vim
    source $RTP/legacy/plug-config/vim-wiki.vim
    source $RTP/legacy/plug-config/coc.vim
    source $RTP/legacy/plug-config/vim-rooter.vim
    source $RTP/legacy/plug-config/nerd-tree.vim
endif
