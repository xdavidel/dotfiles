if has('nvim-0.5.0')
lua <<EOF
  local has_lsp, lsp_server = pcall(require, "lsp.servers")
  if not has_lsp then
    return
  end

  local server = {
    formatter = {
      exe = "prettier",
      args = {},
      },
    linters = {
      "tidy",
      -- https://docs.errata.ai/vale/scoping#html
      "vale",
      },
    lsp = {
      provider = "html",
      setup = {
        cmd = {
          "node",
          DATA_PATH .. "/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
          "--stdio",
          },
        },
      },
    }

  lsp_server.setup(server)
EOF

endif
