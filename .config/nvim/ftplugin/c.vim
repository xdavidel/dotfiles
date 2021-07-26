if has('nvim-0.5.0')
lua << EOF

  -- Don't mess with pointer syntax
  vim.cmd "setlocal iskeyword-=-"

  local has_lsp, lsp_server = pcall(require, "lsp.servers")
  if not has_lsp then
    return
  end

  local server = {
    formatter = {
      exe = "clang_format",
      args = {},
      stdin = true,
      },
    linters = {
      "clangtidy",
      },
    lsp = {
      provider = "clangd",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd",
          "--background-index",
          "--header-insertion=never",
          "--cross-file-rename",
          "--clang-tidy",
          "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*",
          },
        filetypes = { "c", "cpp", "h" }
        },
      },
    }

  lsp_server.setup(server)
EOF

else
  setlocal iskeyword-=-
endif
