if has('nvim-0.5.0')
    lua << EOF
    if require("vimutils").check_lsp_client_active "yamlls" then
      return
    end

    require("lspconfig").yamlls.setup {
      cmd = { DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server", "--stdio" },
      on_attach = require("lsp").common_on_attach,
    }
    vim.cmd "setl ts=2 sw=2 ts=2 ai et"
EOF
else
    setlocal expandtab
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
endif
