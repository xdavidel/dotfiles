if has('nvim-0.5.0')
    lua <<EOF

    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2

    local status_ok, lsp_server = pcall(require, "lsp.servers")
    if not status_ok then
      return
    end

    local server = {
      formatter = {
        exe = "black",
        args = {},
        },
      linters = {
        "flake8",
        "pylint",
        "mypy",
        },
      lsp = {
        provider = "pyright",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
            "--stdio",
            },
          },
        },
      }

    lsp_server.setup(server)

EOF
else
    setlocal expandtab
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
end
