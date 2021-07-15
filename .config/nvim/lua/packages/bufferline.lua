vim.api.nvim_set_keymap("n", "<S-x>", ":BufferClose<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-l>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-h>", ":BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>c", ":BufferClose<CR>", { noremap = true, silent = true })

-- NOTE: If barbar's option dict isn't created yet, create it
vim.cmd "let bufferline = get(g:, 'bufferline', {})"

-- Enable/disable animations
vim.cmd "let bufferline.animation = v:true"

-- Enable/disable auto-hiding the tab bar when there is a single buffer
vim.cmd "let bufferline.auto_hide = v:false"

-- Enable/disable current/total tabpages indicator (top right corner)
vim.cmd "let bufferline.tabpages = v:true"

-- Enable/disable close button
vim.cmd "let bufferline.closable = v:true"

-- Enables/disable clickable tabs
vim.cmd "let bufferline.clickable = v:true"

-- Enable/disable icons
vim.cmd "let bufferline.icons = v:false"

-- Sets the icon's highlight group.
-- If false, will use nvim-web-devicons colors
vim.cmd "let bufferline.icon_custom_colors = v:true"

-- Configure icons on the bufferline.
vim.cmd "let bufferline.icon_separator_active = '▎'"
vim.cmd "let bufferline.icon_separator_inactive = '▎'"
vim.cmd "let bufferline.icon_close_tab = ''"
vim.cmd "let bufferline.icon_close_tab_modified = '●'"

-- Sets the maximum padding width with which to surround each tab.
vim.cmd "let bufferline.maximum_padding = 4"

-- Sets the maximum buffer name length.
vim.cmd "let bufferline.maximum_length = 30"

-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
-- where X is the buffer number. But only a static string is accepted here.
vim.cmd "let bufferline.no_name_title = 'New File'"
