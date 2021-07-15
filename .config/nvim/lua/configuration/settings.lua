
local cmd = vim.cmd
local opt = vim.opt

---  VIM ONLY COMMANDS  ---

cmd "set nocompatible"
cmd "filetype plugin on"
cmd "set formatoptions-=cro"                -- Stop newline continution of comments
cmd "set iskeyword+=-"                      -- treat dash separated words as a word text object

cmd "set inccommand=split"

if O.line_wrap_cursor_movement then
  cmd "set whichwrap+=<,>,[,],h,l"
end

if O.transparent_background then
  cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
  cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
  cmd "let &fcs='eob: '"
end

-- Diable vim builtins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

---  SETTINGS  ---
opt.shortmess:append "c"                    -- don't pass messages to |ins-completion-menu|

if O.leader_key == " " or O.leader_key == "space" then
  vim.g.mapleader = ' '
else
  vim.g.mapleader = O.leader_key
end

for k, v in pairs(O.default_options) do
  vim.opt[k] = v
end
