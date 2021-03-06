if has('nvim-0.5.0')
    lua << EOF
    if require("utils").check_lsp_client_active "vimls" then
      return
    end

    -- npm install -g vim-language-server
    require("lspconfig").vimls.setup {
      cmd = { DATA_PATH .. "/lspinstall/vim/node_modules/.bin/vim-language-server", "--stdio" },
      on_attach = require("lsp").common_on_attach,
    }
EOF
endif
