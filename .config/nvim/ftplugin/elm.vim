if has('nvim-0.5.0')
lua << EOF
  local has_lsp, lsp_server = pcall(require, "lsp.servers")
  if not has_lsp then
    return
  end

  local server = {
    formatter = {
      exe = "",
      args = {},
      stdin = true,
    },
    linters = {},
    lsp = {
      provider = "elmls",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-language-server",
        },
        init_options = {
          elmAnalyseTrigger = "change",
          elmFormatPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-format",
          elmPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/",
          elmTestPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-test",
        },
      },
    },
  }

  lsp_server.setup(server)

EOF
endif
