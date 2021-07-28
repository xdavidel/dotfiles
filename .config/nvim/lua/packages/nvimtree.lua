local M = {}

M.setup = function()
  local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
  if not status_ok then
    return
  end
  local g = vim.g

  vim.o.termguicolors = true

  g.nvim_tree_side = "left"
  g.nvim_tree_width = 28
  g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
  g.nvim_tree_auto_open = 0
  g.nvim_tree_auto_close = 0
  g.nvim_tree_quit_on_open = 0
  g.nvim_tree_follow = 1
  g.nvim_tree_indent_markers = 1
  g.nvim_tree_hide_dotfiles = 1
  g.nvim_tree_git_hl = 1
  g.nvim_tree_root_folder_modifier = ":t"
  g.nvim_tree_tab_open = 0
  g.nvim_tree_allow_resize = 1
  g.nvim_tree_lsp_diagnostics = 1
  g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }

  g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 0,
    folder_arrows = 0,
  }

  vim.g.nvim_tree_icons = {
    default = "+ ",
    symlink = "@ ",
    folder = {
      default = O.icons.folder_closed,
      open = O.icons.folder_open,
      empty = O.icons.folder_closed,
      empty_open = O.icons.folder_open,
      symlink = O.icons.folder_closed,
      symlink_open = O.icons.folder_open,
    },
  }

  local tree_cb = nvim_tree_config.nvim_tree_callback

  vim.g.nvim_tree_bindings = {
    { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
    { key = "h", cb = tree_cb "close_node" },
    { key = "v", cb = tree_cb "vsplit" },
    { key = "t", cb = tree_cb "tabnew" },
    { key = "<A-CR>", cb = tree_cb "tabnew" },
  }
end

M.toggle_tree = function()
  local view_status_ok, view = pcall(require, "nvim-tree.view")
  if not view_status_ok then
    return
  end

  if view.win_open() then
    require("nvim-tree").close()
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(0)
    end
  else
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(31, "")
    end
    require("nvim-tree").find_file(true)
  end
end

return M
