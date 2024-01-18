vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.g.mapleader = " "
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.errorbells = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.spell = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append "@-@"
vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.shortmess:append "c"
vim.opt.termguicolors = true
vim.o.termguicolors = true

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
    tag = "0.1.4",
    requires = { { "nvim-lua/plenary.nvim" } },
  }
  use "dylon/vim-antlr"
  use "romgrk/barbar.nvim"
  use "unblevable/quick-scope"
  use "kshenoy/vim-signature"
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end,
  }
  use "rmagatti/auto-session"
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use "theHamsta/nvim-dap-virtual-text"
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
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  }
  use {
    "rmagatti/goto-preview",
    config = function() require("goto-preview").setup {} end,
  }
  use { "akinsho/git-conflict.nvim", tag = "*", config = function() require("git-conflict").setup() end }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "kkharji/sqlite.lua" },
  }
  use "nanotee/sqls.nvim"
  use {
    "tamton-aquib/duck.nvim",
    config = function()
      vim.keymap.set("n", "<leader>dd", function() require("duck").hatch "ඞ" end, {})
      vim.keymap.set("n", "<leader>dk", function() require("duck").cook() end, {})
    end,
  }
  use {
    "dsych/blanket.nvim",
    config = function()
      require("blanket").setup {
        report_path = "/home/ivan/hae/main/modules/sonarCoverage/target/jacoco.xml",
        filetype = "java",
        signs = {
          priority = 1,
          incomplete_branch = "█",
          uncovered = "█",
          covered = "█",
          sign_group = "Blanket",
          incomplete_branch_color = "WarningMsg",
          covered_color = "Statement",
          uncovered_color = "Error",
        },
      }
    end,
  }
end)

require("Comment").setup()

vim.notify = require "notify"

-- load plugins
require "uwu"

-- colorshceme
vim.cmd "colorscheme material"
