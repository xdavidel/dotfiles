if has('nvim-0.5.0')
lua << EOF
  local has_lsp, lsp_server = pcall(require, "lsp.servers")
  if not has_lsp then
    return
  end

  local server = {
    formatter = {
      exe = "dart",
      args = { "format" },
      stdin = true,
    },
    linters = {},
    lsp = {
      provider = "dartls",
      setup = {
        cmd = {
          "dart",
          "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot",
          "--lsp",
        },
      },
    },
  }

  lsp_server.setup(server)

EOF
endif
