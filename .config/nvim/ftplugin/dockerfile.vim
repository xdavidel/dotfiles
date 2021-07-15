if has('nvim-0.5.0')
    lua << EOF
    if require("utils").check_lsp_client_active "dockerls" then
      return
    end

    require("lspconfig").dockerls.setup {
      cmd = { DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver", "--stdio" },
      on_attach = require("lsp").common_on_attach,
      root_dir = vim.loop.cwd,
    }
EOF

endif
