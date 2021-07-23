if has('nvim-0.5.0')
    lua <<EOF
    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
      return
    end

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
end
