if has('nvim-0.5.0')
    lua << EOF
    local status_ok, lsp_server = pcall(require, "lsp.servers")
    if not status_ok then
      return
    end


  local server = {
    formatter = {
      exe = "clang_format",
      args = {},
    },
    linters = {},
    lsp = {
      provider = "cmake",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/cmake/venv/bin/cmake-language-server",
          "--stdio",
        },
      },
    },
  }

  lsp_server.setup(server)
  
EOF

endif
