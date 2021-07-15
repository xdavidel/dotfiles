local M = {}

function M.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end

function M.define_augroups(definitions)
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

function M.unrequire(m)
  package.loaded[m] = nil
  _G[m] = nil
end

M.define_augroups {

  _general_settings = {
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
    },
    {
      "BufWinEnter",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    {
      "BufRead",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    {
      "BufNewFile",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    { "BufWritePost", "lv-config.lua", "lua require('utils').reload_lv_config()" },
    -- { "VimLeavePre", "*", "set title set titleold=" },
  },
  _solidity = {
    { "BufWinEnter", ".tf", "setlocal filetype=hcl" },
    { "BufRead", "*.tf", "setlocal filetype=hcl" },
    { "BufNewFile", "*.tf", "setlocal filetype=hcl" },
  },
  _markdown = {
    { "FileType", "markdown", "setlocal wrap" },
    { "FileType", "markdown", "setlocal spell" },
  },
  _buffer_bindings = {
    { "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
  },
  _auto_resize = {
    -- will cause split windows to be resized evenly if main window is resized
    { "VimResized", "*", "wincmd =" },
  },
  _packer_compile = {
    { "BufWritePost", "plugins.lua", "PackerCompile" },
  },
}

return M
