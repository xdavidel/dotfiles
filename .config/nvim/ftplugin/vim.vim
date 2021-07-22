if has('nvim-0.5.0')
    lua << EOF
    if require("utils").check_lsp_client_active "vimls" then
      return
    end

    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
      return
    end

    -- npm install -g vim-language-server
    lspconfig.vimls.setup {
      cmd = { DATA_PATH .. "/lspinstall/vim/node_modules/.bin/vim-language-server", "--stdio" },
      on_attach = require("lsp").common_on_attach,
    }
EOF
endif
