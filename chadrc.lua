-- Just an example, supposed to be placed in /lua/custom/
local M = {}

local override = require "custom.override"

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "tomorrow_night",

  hl_override = {
    Folded = { bg = "#1D1F21", fg = "#3e3e3e" },
  },
}

M.plugins = {
  override = {
    ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
    ["williamboman/mason.nvim"] = override.mason,
    ["nvim-telescope/telescope.nvim"] = override.telescope,
  },

  user = {
    ["neovim/nvim-lspconfig"] = {
      config = function()
        require "plugins.configs.lspconfig"
        require "custom.plugins.lspconfig"
      end,
    },

    ["nvim-telescope/telescope.nvim"] = {
      after = "nvim-tree.lua",
      config = function()
        require "plugins.configs.telescope"
        require "custom.mappings_telescope"
      end,
    },

    ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
        require "custom.plugins.null-ls"
      end,
    },

    ["ThePrimeagen/refactoring.nvim"] = {
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
      },
      config = function()
        require "custom.plugins.refactor"
      end,
    },
    ["nvim-telescope/telescope-fzf-native.nvim"] = {
      run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },

    ["tpope/vim-surround"] = {},

    ["folke/trouble.nvim"] = {
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end,
    },

    ["lukas-reineke/cmp-rg"] = {},
    ["hrsh7th/cmp-omni"] = {},
  },

  -- remove plugins
  remove = {
    "lukas-reineke/indent-blankline.nvim",
  },
}

M.mappings = require "custom.mappings"

return M
