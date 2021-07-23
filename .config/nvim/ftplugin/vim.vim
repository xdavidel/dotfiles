if has('nvim-0.5.0')
    lua << EOF

    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
      return
    end

EOF
endif
