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

  -- Snippets
  use { "hrsh7th/vim-vsnip", event = "InsertEnter" }
  use { "rafamadriz/friendly-snippets", event = "InsertEnter" }
  
  -- Autocomplete
  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("pack-compe").config()
    end,
  }

  -- Treesitter
  use { 
      "nvim-treesitter/nvim-treesitter",
      config = function()
          require("pack-treesitter")
      end,
    event = "BufWinEnter",
  }

  -- File explorer
  use {
    "kyazdani42/nvim-tree.lua",
    commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
      require("pack-nvimtree").config()
    end,
  }

  -- Git signs 
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("pack-gitsigns").config()
    end,
    event = "BufRead",
  }

  -- Whichkey
  use {
    "folke/which-key.nvim",
    config = function()
      require "pack-whichkey"
    end,
    event = "BufWinEnter",
  }

  -- Comments
  use {
    "terrortylor/nvim-comment",
    event = "BufWinEnter",
    config = function()
      local status_ok, nvim_comment = pcall(require, "nvim_comment")
      if not status_ok then
        return
      end
      nvim_comment.setup()
    end,
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    after = { "telescope.nvim", "nvim-compe" },
    config = function()
      require "pack-autopairs"
    end,
  }

  -- Status Line and Bufferline
  use {
    "glepnir/galaxyline.nvim",
    config = function()
      require "pack-galaxyline"
    end,
    -- event = "VimEnter",
  }
      
  -- diagnostics
  use {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  }


  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufWinEnter",
    config = function()
      require "pack-colorizer"
      -- vim.cmd "ColorizerReloadAllBuffers"
    end,
  }

end)
