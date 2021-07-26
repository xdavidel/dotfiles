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
        exe = "python",
        args = { "-m", "json.tool" },
        stdin = true,
        },
      linters = {},
      lsp = {
        provider = "jsonls",
        setup = {
          cmd = {
            "node",
            DATA_PATH .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
            "--stdio",
            },
          settings = {
            json = {
              schemas = schemas,
              },
            },
          commands = {
            Format = {
              function()
                vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
              end,
              },
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
