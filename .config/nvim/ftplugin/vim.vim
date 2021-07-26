if has('nvim-0.5.0')
lua <<EOF
  local has_lsp, lsp_server = pcall(require, "lsp.servers")
  if not has_lsp then
    return
  end

  local server = {
    formatter = {
      exe = "",
      args = {},
      },
    linters = { "" },
    lsp = {
      provider = "vimls",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/vim/node_modules/.bin/vim-language-server",
          "--stdio",
          },
        },
      },
    }

  lsp_server.setup(server)
EOF

else
endif
