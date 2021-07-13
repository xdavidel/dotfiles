local wiki = {
    path = '~/Documents/wiki',
    syntax = 'markdown',
    ext = '.md',
    exclude_files = {'**/README.md', '**/Readme.md' },
}

local pwiki = {
    path = '~/Documents/private',
    syntax = 'markdown',
    ext = '.md',
    exclude_files = {'**/README.md', '**/Readme.md' },
}

vim.g.vimwiki_filetypes = {'markdown'}
vim.g.vimwiki_list = { wiki, pwiki }

vim.cmd "autocmd BufWritePost *wiki/*.md VimwikiTOC"
