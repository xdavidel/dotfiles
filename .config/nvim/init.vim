let $RTP=split(&runtimepath, ',')[0]

" General Settings
source $RTP/vim-plug/plugins.vim
source $RTP/general/settings.vim
source $RTP/keys/mappings.vim
source $RTP/plug-config/vim-commentary.vim
source $RTP/plug-config/quick-scope.vim
source $RTP/plug-config/easy-motion.vim

if exists('g:vscode')
  source $RTP/vscode/settings.vim
else
  source $RTP/theme/settings.vim
  source $RTP/keys/which-key.vim
  source $RTP/plug-config/fzf.vim
  source $RTP/plug-config/codi.vim
  source $RTP/plug-config/vim-wiki.vim
  source $RTP/plug-config/coc.vim
  source $RTP/plug-config/vim-rooter.vim
  source $RTP/plug-config/nerd-tree.vim
endif
