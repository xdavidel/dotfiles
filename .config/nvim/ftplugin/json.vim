if has('nvim-0.5.0')
    lua << EOF
    if require("utils").check_lsp_client_active "jsonls" then
      return
    end

    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
      return
    end

    lspconfig.jsonls.setup {
      cmd = {
        "node",
        DATA_PATH .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
        "--stdio",
      },
      on_attach = require("lsp").common_on_attach,

      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
          end,
        },
      },
    }

    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
EOF

else
    setlocal expandtab
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
endif
