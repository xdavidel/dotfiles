local lsp_config = {}

local function config_lsp()
  local popup_border = "single"

  vim.fn.sign_define(
  "LspDiagnosticsSignError",
  { texthl = "LspDiagnosticsSignError", numhl = "LspDiagnosticsSignError" }
  )
  vim.fn.sign_define(
  "LspDiagnosticsSignWarning",
  { texthl = "LspDiagnosticsSignWarning", numhl = "LspDiagnosticsSignWarning" }
  )
  vim.fn.sign_define(
  "LspDiagnosticsSignHint",
  { texthl = "LspDiagnosticsSignHint", numhl = "LspDiagnosticsSignHint" }
  )
  vim.fn.sign_define(
  "LspDiagnosticsSignInformation",
  { texthl = "LspDiagnosticsSignInformation", numhl = "LspDiagnosticsSignInformation" }
  )

  vim.cmd "nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>"
  vim.cmd "nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>"
  vim.cmd "nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>"
  vim.cmd "nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>"
  vim.cmd "nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>"
  vim.cmd "nnoremap <silent> <C-p> :lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = popup_border}})<CR>"
  vim.cmd "nnoremap <silent> <C-n> :lua vim.lsp.diagnostic.goto_next({popup_opts = {border = popup_border}})<CR>"

  -- scroll down hover doc or scroll in definition preview
  -- scroll up hover doc
  vim.cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'

  -- Set Default Prefix.
  -- Note: You can set a prefix per lsp server in the lv-globals.lua file
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 0,
    },
    signs = true,
    underline = true,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = popup_border,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = popup_border,
  })

  -- symbols for autocomplete
  vim.lsp.protocol.CompletionItemKind = {
    " 🗒️  (Text) ",
    " 🏷️  (Method)",
    " ⚙️  (Function)",
    " 🔨 (Constructor)",
    " 📦 (Field)",
    " 📦 (Variable)",
    " 🏗️  (Class)",
    " ⛩️  (Interface)",
    " 📥 (Module)",
    " ➕ (Property)",
    " 🔳  (Unit)",
    " 💰 (Value)",
    " 🏛️  (Enum)",
    " 🔤 (Keyword)",
    "   (Snippet)",
    " 🖌️  (Color)",
    " 📓 (File)",
    " 🖇️  (Reference)",
    " 📁 (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " 🏗️  (Struct)",
    "   (Event)",
    " ✖️  (Operator)",
    " 📦 (TypeParameter)",
  }

end

local function common_on_attach(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end

end

function lsp_config.setup(server)
  local provider = server.lsp.provider
  if Utils.check_lsp_client_active(provider) then
    return
  end

  local has_lsp, lspconfig = pcall(require, "lspconfig")
  if has_lsp then
    config_lsp()
    local setup = server.lsp.setup
    setup.common_on_attach = common_on_attach
    lspconfig[provider].setup(setup)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
-- local servers = {"pyright", "tsserver"}
-- for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end
return lsp_config
