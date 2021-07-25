local cmd = vim.cmd

-- Run xrdb whenever Xdefaults or Xresources are updated.
-- =====================================================================
cmd "au BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults"
cmd "au BufWritePost *Xresources,*Xdefaults !xrdb %"

-- Update binds when sxhkdrc is updated.
-- =====================================================================
cmd "au BufWritePost *sxhkdrc !pkill -USR1 sxhkd"

-- Update binds when bspwmrc is updated.
-- =====================================================================
cmd "au BufWritePost ~/.config/bspwm/bspwmrc !~/.config/bspwm/bspwmrc"

-- Highlight yanked text
-- =====================================================================
cmd "au TextYankPost * lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})"

-- Open zsh as shell files
-- =====================================================================
cmd "au BufRead,BufNewFile *.zsh setlocal filetype=sh"

-- Recompile packer on plugin file change
-- =====================================================================
cmd "au BufWritePost plugins.lua PackerCompile"
