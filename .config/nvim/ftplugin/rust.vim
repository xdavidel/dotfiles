if has('nvim-0.5.0')
    lua << EOF

    local status_ok, lsp_server = pcall(require, "lsp.servers")
    if not status_ok then
      return
    end

    vim.api.nvim_exec(
      [[
        autocmd Filetype rust nnoremap <leader>lm <Cmd>RustExpandMacro<CR>
        autocmd Filetype rust nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>
        autocmd Filetype rust nnoremap <leader>le <Cmd>RustRunnables<CR>
        autocmd Filetype rust nnoremap <leader>lh <Cmd>RustHoverActions<CR>
        ]],
      true
    )

    local server = {
      formatter = {
        exe = "rustfmt",
        args = { "--emit=stdout", "--edition=2018" },
        stdin = true,
        },
      lsp = {
        provider = "rust_analyzer",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/rust/rust-analyzer",
            },
          },
        },
      }

    lsp_server.setup(server)
EOF
endif
