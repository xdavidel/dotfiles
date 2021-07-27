if has('nvim-0.5.0')
lua << EOF

  vim.opt_local.tabstop = 4
  vim.opt_local.shiftwidth = 4
  vim.opt_local.softtabstop = 4
  vim.opt_local.expandtab = false

  local has_lsp, lsp_server = pcall(require, "lsp.servers")
  if not has_lsp then
    return
  end

  local server = {
    formatter = {
      exe = "",
      args = {},
    },
    linters = {},
    lsp = {
      provider = "omnisharp",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/csharp/omnisharp/run",
          "--stdio",
        },
      },
    },
  }

  lsp_server.setup(server)

EOF
