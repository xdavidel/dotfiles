if has('nvim-0.5.0')
lua <<EOF
  local has_lsp, lsp_server = pcall(require, "lsp.servers")
  if not has_lsp then
    return
  end

  local server = {
    formatter = {
      exe = "gofmt",
      args = {},
      stdin = true,
      },
    linters = {
      "golangcilint",
      "revive",
      },
    lsp = {
      provider = "gopls",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/go/gopls",
          },
        },
      },
    }

  lsp_server.setup(server)
EOF

endif
