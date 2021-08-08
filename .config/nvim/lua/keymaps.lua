local map = vim.api.nvim_set_keymap
local cmd = vim.cmd

-- better window movement
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- Terminal window navigation
map("t", "<C-h>", "<C-\\<C-N><C-w>h", {silent = true, noremap = true})
map("t", "<C-j>", "<C-\\<C-N><C-w>j", {silent = true, noremap = true})
map("t", "<C-k>", "<C-\\<C-N><C-w>k", {silent = true, noremap = true})
map("t", "<C-l>", "<C-\\<C-N><C-w>l", {silent = true, noremap = true})
map("t", "<Esc>", "<C-\\<C-n>", {silent = true, noremap = true})

-- resize with arrows
map("n", "<C-A-Up>", ":resize -2<CR>", { silent = true })
map("n", "<C-A-Down>", ":resize +2<CR>", { silent = true })
map("n", "<C-A-Left>", ":vertical resize -2<CR>", { silent = true })
map("n", "<C-A-Right>", ":vertical resize +2<CR>", { silent = true })

-- better indenting
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- Tab switch buffer
map("n", "tn", ":tabnext<CR>", { noremap = true, silent = true })
map("n", "tp", ":tabprevious<CR>", { noremap = true, silent = true })
map("n", "tx", ":tabclose<CR>", { noremap = true, silent = true })
map("n", "tc", ":tabnew<CR>", { noremap = true, silent = true })
map("n", "to", ":tabnew ", { noremap = true, silent = true })

-- Move current line / block with Alt-Up/Down ala vscode.
map("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
map("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
map("x", "<A-Down>", ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
map("x", "<A-Up>", ":m '<-2<CR>gv-gv", { noremap = true, silent = true })

-- QuickFix
map("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
map("n", "[q", ":cprev<CR>", { noremap = true, silent = true })

-- Capital Y should behave like this
map("n", "Y", "y$", { noremap = true, silent = true })

-- Keep it centered
map("n", "n", "nzzzv", { noremap = true, silent = true })
map("n", "N", "Nzzzv", { noremap = true, silent = true })
map("n", "J", "mzJ'z", { noremap = true, silent = true })

-- Delete / Change until '_'
map("n", "dc", "td_", { noremap = true, silent = true })
map("n", "cd", "ct_", { noremap = true, silent = true })

-- Wrap text
map("n", "<M-z>", ":set wrap!<CR>", { noremap = true, silent = true })
map("i", "<M-z>", "<Esc>:set wrap!<CR>a", { noremap = true, silent = true })

-- Mark position before search
map("n", "/", "ms/", { noremap = true, silent = true })

-- Delete matches
map("n", "dm", ":%s/<c-r>///g<CR>", { noremap = false, silent = true })

-- Change matches
map("n", "cm", ":%s/<c-r>///g<Left><Left>", { noremap = false, silent = true })

-- Replace all is aliased to S
map("n", "S", ":%s//g<Left><Left>", { noremap = true, silent = true })

-- Better nav for omnicomplete
cmd 'inoremap <expr> <c-j> ("\\<C-n>")'
cmd 'inoremap <expr> <c-k> ("\\<C-p>")'

cmd 'vnoremap p "0p'
cmd 'vnoremap P "0P'

-- Toggle the QuickFix window
map("", "<C-q>", ":call QuickFixToggle()<CR>", { noremap = true, silent = true })
