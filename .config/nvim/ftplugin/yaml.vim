if has('nvim-0.5.0')
    lua << EOF

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
        exe = "prettier",
        args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
        stdin = true,
        },
      lsp = {
        provider = "yamlls",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server",
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
endif
