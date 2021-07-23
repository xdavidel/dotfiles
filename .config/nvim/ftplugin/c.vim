if has('nvim-0.5.0')
    lua << EOF
    vim.cmd "setlocal iskeyword-=-"
EOF

else
    setlocal iskeyword-=-
endif
