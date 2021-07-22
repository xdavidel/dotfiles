if has('nvim-0.5.0')
    lua <<EOF
    if not require("utils").check_lsp_client_active "pyright" then
      -- npm i -g pyright
      local status_ok, lspconfig = pcall(require, "lspconfig")
      if not status_ok then
        return
      end
      lspconfig.pyright.setup {
        cmd = {
          DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
          "--stdio",
        },
        on_attach = require("lsp").common_on_attach,
        handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = { spacing = 0 },
            signs = true,
            underline = true,
            update_in_insert = true,
          }),
        },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      }
    end

    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
EOF
else
    setlocal expandtab
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
end
