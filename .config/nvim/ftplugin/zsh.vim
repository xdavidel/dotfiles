if has('nvim-0.5.0')
lua <<EOF
  local has_lsp, lsp_server = pcall(require, "lsp.servers")
  if not has_lsp then
    return
  end

  local server = {
    -- @usage can be 'shfmt'
    formatter = {
      exe = "shfmt",
      args = {},
      },
    -- @usage can be 'shellcheck'
    linters = { "shellcheck" },
    lsp = {
      provider = "bashls",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server",
          "start",
          },
        },
      },
    }

  lsp_server.setup(server)
EOF

endif
