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
		showtabline = 2,                         -- always show tabs
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
