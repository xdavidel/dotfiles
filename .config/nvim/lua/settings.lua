
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
