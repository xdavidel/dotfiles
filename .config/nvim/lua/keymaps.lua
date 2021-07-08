-- better window movement
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- Terminal window navigation
vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\<C-N><C-w>h", {silent = true, noremap = true})
vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\<C-N><C-w>j", {silent = true, noremap = true})
vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\<C-N><C-w>k", {silent = true, noremap = true})
vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\<C-N><C-w>l", {silent = true, noremap = true})
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\<C-n>", {silent = true, noremap = true})

-- resize with arrows
vim.api.nvim_set_keymap("n", "<C-A-Up>", ":resize -2<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-A-Down>", ":resize +2<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-A-Left>", ":vertical resize -2<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-A-Right>", ":vertical resize +2<CR>", { silent = true })

-- better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Tab switch buffer
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

-- Move current line / block with Alt-Up/Down ala vscode.
vim.api.nvim_set_keymap("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-Down>", ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-Up>", ":m '<-2<CR>gv-gv", { noremap = true, silent = true })

-- QuickFix
vim.api.nvim_set_keymap("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[q", ":cprev<CR>", { noremap = true, silent = true })

-- Better nav for omnicomplete
vim.cmd 'inoremap <expr> <c-j> ("\\<C-n>")'
vim.cmd 'inoremap <expr> <c-k> ("\\<C-p>")'

vim.cmd 'vnoremap p "0p'
vim.cmd 'vnoremap P "0P'

-- Toggle the QuickFix window
vim.api.nvim_set_keymap("", "<C-q>", ":call QuickFixToggle()<CR>", { noremap = true, silent = true })
