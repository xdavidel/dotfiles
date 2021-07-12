if has('nvim-0.5.0')
    lua << EOF
    if not require("vimutils").check_lsp_client_active "gopls" then
      require("lspconfig").gopls.setup {
        cmd = { DATA_PATH .. "/lspinstall/go/gopls" },
        settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
        root_dir = require("lspconfig").util.root_pattern(".git", "go.mod"),
        init_options = { usePlaceholders = true, completeUnimported = true },
        on_attach = require("lsp").common_on_attach,
      }
    end

    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false
EOF

else
    setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal softtabstop=4
    setlocal expandtab=false
endif
