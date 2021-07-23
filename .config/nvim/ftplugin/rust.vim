if has('nvim-0.5.0')
    lua << EOF

    local status_ok, lspconfig = pcall(require, "lspconfig")
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
EOF
endif
