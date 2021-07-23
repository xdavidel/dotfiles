if has('nvim-0.5.0')
    lua << EOF
    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
      return
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
