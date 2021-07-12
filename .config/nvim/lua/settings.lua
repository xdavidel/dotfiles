---  HELPERS  ---

CONFIG_PATH = vim.fn.stdpath "config"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"

local cmd = vim.cmd
local opt = vim.opt

---  VIM ONLY COMMANDS  ---

cmd "set nocompatible"
cmd "filetype plugin on"
cmd "set formatoptions-=cro"                -- Stop newline continution of comments
cmd "set iskeyword+=-"                      -- treat dash separated words as a word text object

cmd "set inccommand=split"
cmd "set whichwrap+=<,>,[,],h,l"

---  SETTINGS  ---

opt.backup = false 				             -- creates a backup file
opt.clipboard = "unnamedplus" 			     -- allows neovim to access the system clipboard
opt.cmdheight = 2 				             -- more space in the neovim command line for displaying messages
opt.colorcolumn = "99999" 			         -- fix indentline for now
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0 				         -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" 			         -- the encoding written to a file
opt.scrolloff=5                              -- scrolling offset
opt.hidden = true 				             -- required to keep multiple buffers and open multiple buffers
opt.hlsearch = true 	  			         -- highlight all matches on previous search pattern
opt.ignorecase = true 				         -- ignore case in search patterns
opt.mouse = "a" 				             -- allow the mouse to be used in neovim
opt.pumheight = 10 				             -- pop up menu height
opt.showtabline = 2 				         -- always show tabs
opt.smartcase = true				         -- smart case
opt.smartindent = true 				         -- make indenting smarter again
opt.splitbelow = true 			             -- force all horizontal splits to go below current window
opt.splitright = true 	            		 -- force all vertical splits to go to the right of current window
opt.swapfile = false 				         -- creates a swapfile
opt.termguicolors = true             		 -- set term gui colors (most terminals support this)
opt.timeoutlen = 100 			             -- time to wait for a mapped sequence to complete (in milliseconds)
opt.title = true 			                 -- set the title of window to the value of the titlestring
opt.titlestring = "%<%F%=%l/%L - nvim" 		 -- what the title of the window will be set to
opt.undodir = CACHE_PATH .. "/undo" 	     -- set an undo directory
opt.undofile = true 				         -- enable persisten undo
opt.updatetime = 300 				         -- faster completion
opt.writebackup = false 			         -- don't allow editing open files
opt.expandtab = true 				         -- convert tabs to spaces
opt.shiftwidth = 4 				             -- the number of spaces inserted for each indentation
opt.shortmess:append "c"            		 -- don't pass messages to |ins-completion-menu|
opt.tabstop = 4 			            	 -- insert 4 spaces for a tab
opt.cursorline = true 			             -- highlight the current line
opt.number = true 		                	 -- set numbered lines
opt.relativenumber = true 		             -- set relative numbered lines
opt.signcolumn = "number" 		        	 -- always show the sign column
opt.wrap = false  				             -- display lines as one long line


-- Disables automatic commenting on newline:
-- =====================================================================
cmd "au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o"


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
