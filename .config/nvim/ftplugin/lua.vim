if has('nvim-0.5.0')
    lua << EOF

    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2

    local has_lsp, lsp_server = pcall(require, "lsp.servers")
    if not has_lsp then
      return
    end

    local server = {
      formatter = {
        exe = "stylua",
        args = {},
        },
      linters = { "luacheck" },
      lsp = {
        provider = "sumneko_lua",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/lua/sumneko-lua-language-server",
            "-E",
            DATA_PATH .. "/lspinstall/lua/main.lua",
            },
          filetypes = { "lua" },
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";"),
                },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim", "O" },
                },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                  [vim.fn.expand "~/.local/share/lunarvim/lvim/lua"] = true,
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                  [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                  },
                maxPreload = 100000,
                preloadFileSize = 1000,
                },
              telemetry = {
                enable = false,
                },
              },
            },
          },
        },
      }

    lsp_server.setup(server)
EOF

endif
