local execute = vim.api.nvim_command
local fn = vim.fn

-- vim built-in plugin manager dir
local pack_dir = RTP .. "/pack"
local install_path = pack_dir .. "/packer/start/packer.nvim"
local filename = vim.fn.expand("%")

-- init packer
local first_init = false
if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
  first_init = true
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	print("Problem with packer")
  return
end

packer.init {
  package_root = pack_dir,
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}


-- auto compile packer upon editing this file
vim.cmd("autocmd BufWritePost " .. filename .. " PackerCompile")

return packer.startup(function(use)
  -- Packer can manage itself as an optional plugin
  use "wbthomason/packer.nvim"

  -- Neovim LSP stuff
  use { "neovim/nvim-lspconfig" }
  use {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function()
      require("lspinstall").setup()
    end,
  }

  -- Autocomplete
  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("packages.compe").setup()
    end,
  }

  -- Fuzzy searching
  use { "nvim-telescope/telescope.nvim",
      requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
      config = [[require('packages.telescope').setup()]],
  }

  -- Snippets
  use { "hrsh7th/vim-vsnip", event = "InsertEnter" }
  use { "rafamadriz/friendly-snippets", event = "InsertEnter" }

  -- Treesitter
  use {
      "nvim-treesitter/nvim-treesitter",
      config = function()
          require("packages.treesitter").setup()
      end,
    event = "BufWinEnter",
  }

  -- Theme
  use {
    'folke/tokyonight.nvim',
    config = function ()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_transparent = O.transparent_background
      vim.cmd[[colorscheme tokyonight]]
    end
  }

  -- File explorer
  use {
    "kyazdani42/nvim-tree.lua",
    commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
      require("packages.nvimtree").setup()
    end,
  }

  -- Git signs
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("packages.gitsigns").setup()
    end,
    event = "BufRead",
  }

  -- Whichkey
  use {
    "folke/which-key.nvim",
    config = function()
      require ("packages.whichkey").setup()
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
      require "packages.autopairs"
    end,
  }

  -- Status Line and Bufferline
  use {
    'hoob3rt/lualine.nvim',
    config = function()
      require('packages.lualine').setup()
    end
  }

  -- Tabs
  use {
    "romgrk/barbar.nvim",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require "packages.bufferline"
    end,
    event = "BufWinEnter",
  }

  -- Terminal
  use {
    "numToStr/FTerm.nvim",
    event = "BufWinEnter",
    config = function()
      require("packages.floaterm").setup()
    end,
  }

  -- Diffview
  use {
    "sindrets/diffview.nvim",
    event = "BufRead",
  }

  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufWinEnter",
    config = function()
      require ("packages.colorizer").setup()
    end,
  }

  use {
    "vimwiki/vimwiki",
    config = function()
      require "packages.vimwiki"
    end,
  }

  if first_init then
    execute "PackerSync"
  end

end)
