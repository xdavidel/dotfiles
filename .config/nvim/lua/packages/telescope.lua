local M = {}
M.config = function()
  local status_ok, actions = pcall(require, "telescope.actions")
  if not status_ok then
    return
  end

  O.plugin.telescope = {
    active = false,
    defaults = {
      prompt_prefix = "> ",
      selection_caret = "* ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.85,
        prompt_position = "bottom",
        preview_cutoff = 120,
        horizontal = { mirror = false },
        vertical = { mirror = false },
      },
      file_ignore_patterns = {},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = {},
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-c>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<CR>"] = actions.select_default + actions.center,
          ["<esc>"] = actions.close,
        },
        n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        },
      },
    },
  }
end

file_explorer = function()
  local is_ok, tel_builtins = pcall(require, 'telescope.builtin')
    if not is_ok then
      print("Error")
      return
    end
    opts = {}
    opts.cwd = vim.fn.expand("$HOME")
    opts.prompt_title = "Explorer"
    opts.hidden = true
    tel_builtins.file_browser(opts) 
end

M.setup = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end
  telescope.setup(O.plugin.telescope)

  O.plugin.whichkey.mappings.f.f = {"<cmd>lua file_explorer()<cr>", "File Explorer" }
  O.plugin.whichkey.mappings.f.d = {"<cmd>Telescope find_files<cr>", "Find Files" }
  O.plugin.whichkey.mappings.f.r = {"<cmd>Telescope oldfiles<cr>", "Recent Files" }

  vim.api.nvim_set_keymap("n", "<A-x>", ":Telescope commands<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("i", "<A-x>", "<Esc> :Telescope commands<CR>", { noremap = true, silent = true })
end

return M
