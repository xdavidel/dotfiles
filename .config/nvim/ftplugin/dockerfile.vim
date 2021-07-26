if has('nvim-0.5.0')
  lua << EOF
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
      provider = "dockerls",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver",
          "--stdio",
          },
        },
      },
    }

  lsp_server.setup(server)

EOF

endif
