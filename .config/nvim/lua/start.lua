---  HELPERS  ---
CONFIG_PATH = vim.fn.stdpath "config"
DATA_PATH   = vim.fn.stdpath "data"
CACHE_PATH  = vim.fn.stdpath "cache"

RTP         = vim.fn.expand "$RTP"
TERMINAL    = vim.fn.expand "$TERMINAL"
USER	      = vim.fn.expand "$USER"

require "configuration.configs"
require "configuration.autocmds"

require "keymaps"
require "plugins"

vim.g.colors_name = O.colorscheme

require "configuration.settings"
require "utils"
