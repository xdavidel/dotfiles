--- Globals
O = {
	leader_key  = "space",
	line_wrap_cursor_movement = true,
	format_on_save = true,
	snippets_directory = CONFIG_PATH .. "/snippets",

	plugins = {},

	auto_close_tree = 0,

	lsp = {
		document_highlight = true,
		popup_border = "single",
	},

	database = { save_location = CACHE_PATH .. "nvim_db", auto_execute = 1 },
  lspinstall_dir = "vim",

	user_which_key = {},

  icons = {
    bar = "▊",
    symlink = "@ ",
    folder_closed = " ",
    folder_open = " ",
    calculator = " ",
    scissor = " ",
    arrow_right = "➜ ",
    closed = " ",
    x = "✗ ",
    v = "✓ ",
    star = "★ ",
    exclamation = " ",
    info = " ",
    warning = " ",
    error = " ",
    circle = "",
    bang = " ",
    plus = " ",
    minus = " ",
    connect = " ",
    bulb = " ",
    tree = " ",
    gear = " ",
  },

  colors = {
    fg = "#ABB2BF",
    bg = "#202020",
    alt_bg = "#262626",
    dark = "#222222",
    accent = "#AAAAAA",
    popup_back = "#2D2D30",
    search_orange = "#613214",
    search_blue = "#5e81ac",
    white = "#D8DEE9",
    gray = "#9BA1AB",
    light_gray = "#c8c9c1",
    blue = "#5f8ccd",
    dark_blue = "#223E55",
    light_blue = "#8dc0d5",
    green = "#73aa7b",
    cyan = "#4EC9B0",
    light_green = "#B5CEA8",
    red = "#D16969",
    orange = "#D1866B",
    light_red = "#CA535F",
    yellow = "#ECCC8E",
    yellow_orange = "#D7BA7D",
    purple = "#BF82B4",
    magenta = "#D16D9E",
    cursor_fg = "#515052",
    cursor_bg = "#AEAFAD",
    sign_add = "#587c0c",
    sign_change = "#0c7d9d",
    sign_delete = "#94151b",
    error_red = "#F44747",
    warning_orange = "#ff8800",
    info_yellow = "#FFCC66",
    hint_blue = "#4FC1FF",
    purple_test = "#ff007c",
    cyan_test = "#00dfff",
    ui_blue = "#264F78",
  },

	plugin = {},

	user_plugins = {},

	user_autocommands = {
		{ "FileType", "qf", "set nobuflisted" },
	},
	default_options = {
		backup = false,                          -- creates a backup file
		clipboard = "unnamedplus",              -- allows neovim to access the system clipboard
		cmdheight = 2             ,              -- more space in the neovim command line for displaying messages
		colorcolumn = "99999"      ,             -- fix indentline for now
		completeopt = { "menuone", "noselect" },
		conceallevel = 0,                        -- so that `` is visible in markdown files
		fileencoding = "utf-8",                  -- the encoding written to a file
		scrolloff=5,                             -- scrolling offset
		hidden = true,                           -- required to keep multiple buffers and open multiple buffers
		hlsearch = true,                         -- highlight all matches on previous search pattern
		ignorecase = true,                       -- ignore case in search patterns
		mouse = "a",                             -- allow the mouse to be used in neovim
		showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
		pumheight = 10,                          -- pop up menu height
		smartcase = true,                        -- smart case
		smartindent = true,                      -- make indenting smarter again
		splitbelow = true,                       -- force all horizontal splits to go below current window
		splitright = true,                       -- force all vertical splits to go to the right of current window
		swapfile = false,                        -- creates a swapfile
		termguicolors = true,                    -- set term gui colors (most terminals support this)
		timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
		title = true,                            -- set the title of window to the value of the titlestring
		titlestring = "%<%F%=%l/%L - nvim",      -- what the title of the window will be set to
		undodir = CACHE_PATH .. "/undo",         -- set an undo directory
		undofile = true,                         -- enable persisten undo
		updatetime = 300,                        -- faster completion
		writebackup = false,                     -- don't allow editing open files
		expandtab = true,                        -- convert tabs to spaces
		shiftwidth = 2,                          -- the number of spaces inserted for each indentation
		tabstop = 2,                             -- insert 4 spaces for a tab
		cursorline = true,                       -- highlight the current line
		number = true,                           -- set numbered lines
		relativenumber = true,                   -- set relative numbered lines
		signcolumn = "number",                   -- always show the sign column
		wrap = false,                            -- display lines as one long line
	},
}

-- Helper function for analysis
P = function(stuff)
  print(vim.inspect(stuff))
end

Utils = {}
function Utils.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end

function Utils.define_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd "autocmd!"

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
      vim.cmd(command)
    end

    vim.cmd "augroup END"
  end
end

function Utils.unrequire(m)
  package.loaded[m] = nil
  _G[m] = nil
end

function Utils.SafeLoad(name, action)
  local status_ok, script = pcall(require, name)
  if status_ok then
    action(script)
  else
    print("Problem with " .. name)
  end
end
