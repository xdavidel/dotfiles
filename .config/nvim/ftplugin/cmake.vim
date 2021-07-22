if has('nvim-0.5.0')
    lua << EOF
    if require("utils").check_lsp_client_active "cmake" then
      return
    end

    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
      return
    end

    lspconfig.cmake.setup {
      cmd = { DATA_PATH .. "/lspinstall/cmake/venv/bin/cmake-language-server" },
      on_attach = require("lsp").common_on_attach,
      filetypes = { "cmake" },
    }

EOF

endif
