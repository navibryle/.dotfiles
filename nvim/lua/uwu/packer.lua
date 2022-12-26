vim.cmd [[packadd packer.nvim]]

local use = require("packer").use
require("packer").startup(function()
  use "wbthomason/packer.nvim" -- Package manager
  use "neovim/nvim-lspconfig" -- Configurations for Nvim LSP
  use "mfussenegger/nvim-jdtls"
  use "mfussenegger/nvim-dap"
  use "lukas-reineke/indent-blankline.nvim"
  use "kyazdani42/nvim-web-devicons"
  use {
    "goolord/alpha-nvim",
    config = function() require("alpha").setup(require("alpha.themes.startify").config) end,
  }
  use "kyazdani42/nvim-tree.lua"
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  }
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/nvim-cmp"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "nvim-lua/plenary.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = { { "nvim-lua/plenary.nvim" } },
  }
  use "dylon/vim-antlr"
  use "yorik1984/lualine-theme.nvim"
  use "romgrk/barbar.nvim"
  use "unblevable/quick-scope"
  use "kshenoy/vim-signature"
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end,
  }
  use "dsych/blanket.nvim"
  use "rmagatti/auto-session"
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use "theHamsta/nvim-dap-virtual-text"
  use "NvChad/nvim-colorizer.lua"
  use {
    "andrewferrier/debugprint.nvim",
    config = function() require("debugprint").setup() end,
  }
  use {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  }
  use { "kevinhwang91/nvim-bqf" }
  use "windwp/nvim-ts-autotag"
  use "p00f/nvim-ts-rainbow"
  use "marko-cerovac/material.nvim"
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("trouble").setup {} end,
  }
  use {
    "kosayoda/nvim-lightbulb",
    requires = "antoinemadec/FixCursorHold.nvim",
  }
  use "onsails/lspkind.nvim"
  use {
    "stevearc/aerial.nvim",
    config = function() require("aerial").setup() end,
  }
  use "mfussenegger/nvim-lint"
  use { "mhartington/formatter.nvim" }
  use "rcarriga/nvim-notify"
  use {
    "vimwiki/vimwiki",
    config = function()
      vim.g.vimwiki_list = {
        {
          template_path = "/home/ivan/.local/share/vimwiki/templates",
          template_default = "default",
          template_ext = ".html",
        },
      }
    end,
  }
  use "stevearc/dressing.nvim"
  use {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup {
        disable_legacy_commands = true,
      }
    end,
  }
  use "andweeb/presence.nvim"
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  }
  use {
    "rmagatti/goto-preview",
    config = function() require("goto-preview").setup {} end,
  }
  use { "akinsho/git-conflict.nvim", tag = "*", config = function() require("git-conflict").setup() end }
end)
