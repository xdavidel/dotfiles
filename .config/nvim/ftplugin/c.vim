if has('nvim-0.5.0')
    lua << EOF
    if require("vimutils").check_lsp_client_active "clangd" then
      return
    end

    local clangd_flags = { "--background-index" }

    table.insert(clangd_flags, "--cross-file-rename")

    table.insert(clangd_flags, "--header-insertion=" .. "never")

    require("lspconfig").clangd.setup {
      cmd = { DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd", unpack(clangd_flags) },
      on_attach = require("lsp").common_on_attach,
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = true,
          signs = true,
          underline = true,
          update_in_insert = true,
        }),
      },
    }
EOF

else
    setlocal iskeyword-=-
endif
