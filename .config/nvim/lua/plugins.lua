local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = DATA_PATH .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

return packer.startup(function()
  -- Packer can manage itself as an optional plugin
  use "wbthomason/packer.nvim"

  -- Neovim LSP stuff
  use { "neovim/nvim-lspconfig" }
  use { "kabouzeid/nvim-lspinstall", event = "BufRead" }

  -- Fuzzy searching
  use { "nvim-telescope/telescope.nvim",
      requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
  }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- Whichkey
  use { "folke/which-key.nvim" }

  -- Status Line and Bufferline
  use { "glepnir/galaxyline.nvim" }

  -- Comments
      
end)


