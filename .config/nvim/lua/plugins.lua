local execute = vim.api.nvim_command
local fn = vim.fn

-- vim built-in plugin manager dir
local pack_dir = RTP .. "/pack"
local install_path = pack_dir .. "/packer/start/packer.nvim"

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
vim.cmd("autocmd BufWritePost plugins.lua PackerCompile")

return packer.startup(function(use)
  -- Packer can manage itself as an optional plugin
  use "wbthomason/packer.nvim"

  -- Neovim LSP stuff
  use { "neovim/nvim-lspconfig" }
  use {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function() require("lsp").setup() end,
  }

  -- Autocomplete
  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    setup = function() require("packages.compe").config() end,
    config = function() require("packages.compe").setup() end,
  }

  -- Fuzzy searching
  use { "nvim-telescope/telescope.nvim",
  requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
  setup = require("packages.telescope").config() ,
  config = [[require('packages.telescope').setup()]],
}

  -- Snippets
  use { "hrsh7th/vim-vsnip", event = "InsertEnter" }
  use { "rafamadriz/friendly-snippets", event = "InsertEnter" }

  -- Treesitter
  use {
      "nvim-treesitter/nvim-treesitter",
      setup = function() require("packages.treesitter").config() end,
      config = function() require("packages.treesitter").setup() end,
    event = "BufWinEnter",
  }

  -- File explorer
  use {
    "kyazdani42/nvim-tree.lua",
    commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function() require("packages.nvimtree").setup() end,
  }

  -- Git signs
  use {
    "lewis6991/gitsigns.nvim",
    setup = function() require("packages.gitsigns").config() end,
    config = function() require("packages.gitsigns").setup() end,
    event = "BufRead",
  }

  -- Comments
  use {
    "terrortylor/nvim-comment",
    event = "BufWinEnter",
    config = function()
      local status_ok, nvim_comment = pcall(require, "nvim_comment")
      if status_ok then
        nvim_comment.setup()
      end
    end,
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    after = { "telescope.nvim", "nvim-compe" },
    config = function() require "packages.autopairs" end,
  }

  use {
    "glepnir/galaxyline.nvim",
    config = function() require("packages.galaxyline").config() end,
    event = "BufWinEnter",
  }

  -- Terminal
  use {
    "numToStr/FTerm.nvim",
    event = "BufWinEnter",
    setup = function() require("packages.floaterm").config() end,
    config = function() require("packages.floaterm").setup() end,
  }

  -- Diffview
  use {
    "sindrets/diffview.nvim",
    event = "BufRead",
  }

  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufWinEnter",
    setup = function() require ("packages.colorizer").config() end,
    config = function() require ("packages.colorizer").setup() end,
  }

  use {
    "vimwiki/vimwiki",
    config = function() require "packages.vimwiki" end,
  }

  -- Lua scratchpad
  use {
    "rafcamlet/nvim-luapad",
    cmd = { "Luapad", "LuaRun" },
  }

  -- Whichkey
  use {
    "folke/which-key.nvim",
    -- after = { "nvim-lspinstall" },
    setup = function() require("packages.whichkey").config() end,
    config = function() require("packages.whichkey").setup() end,
    event = "BufWinEnter",
  }

  if first_init then
    execute "PackerSync"
  end

end)
