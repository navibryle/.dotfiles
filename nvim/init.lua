vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
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
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.shortmess:append("c")
vim.opt.termguicolors = true
vim.o.termguicolors = true
vim.opt.mouse = ""

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "neovim/nvim-lspconfig", lazy = false }, -- Configurations for Nvim LSP
		{ "mfussenegger/nvim-jdtls", lazy = false },
		{ "mfussenegger/nvim-dap", lazy = false },
		{ "lukas-reineke/indent-blankline.nvim", lazy = false },
		{ "kyazdani42/nvim-web-devicons", lazy = false },
		{
			"goolord/alpha-nvim",
			lazy = false,
			config = function()
				require("alpha").setup(require("alpha.themes.startify").config)
			end,
		},
		{ "kyazdani42/nvim-tree.lua", lazy = false },
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "kyazdani42/nvim-web-devicons" },
		},
		{ "hrsh7th/cmp-nvim-lsp", lazy = false },
		{ "hrsh7th/cmp-buffer", lazy = false },
		{ "hrsh7th/nvim-cmp", lazy = false },
		{ "L3MON4D3/LuaSnip", lazy = false },
		{ "saadparwaiz1/cmp_luasnip", lazy = false },
		{ "nvim-lua/plenary.nvim", lazy = false },
		{ "nvim-treesitter/nvim-treesitter", lazy = false },
		{
			"nvim-telescope/telescope.nvim",
			lazy = false,
			tag = "0.1.4",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{ "dylon/vim-antlr", lazy = false },
		{ "romgrk/barbar.nvim", lazy = false },
		{ "unblevable/quick-scope", lazy = false },
		{ "kshenoy/vim-signature", lazy = false },
		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		},
		{ "rmagatti/auto-session", lazy = false },
		{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" }, lazy = false },
		{ "theHamsta/nvim-dap-virtual-text", lazy = false },
		{
			"andrewferrier/debugprint.nvim",
			lazy = false,
			config = function()
				require("debugprint").setup()
			end,
		},
		{
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		},
		{ "kevinhwang91/nvim-bqf", lazy = false },
		{ "windwp/nvim-ts-autotag", lazy = false },
		{ "marko-cerovac/material.nvim", lazy = false },
		{
			"folke/trouble.nvim",
			lazy = false,
			dependencies = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({})
			end,
		},
		{
			"kosayoda/nvim-lightbulb",
			lazy = false,
			dependencies = "antoinemadec/FixCursorHold.nvim",
		},
		{ "onsails/lspkind.nvim", lazy = false },
		{
			"stevearc/aerial.nvim",
			lazy = false,
			config = function()
				require("aerial").setup()
			end,
		},
		{ "mfussenegger/nvim-lint", lazy = false },
		{ "rcarriga/nvim-notify", lazy = false },
		{
			"vimwiki/vimwiki",
			lazy = false,
			config = function()
				vim.g.vimwiki_list = {
					{
						template_path = "/home/ivan/.local/share/vimwiki/templates",
						template_default = "default",
						template_ext = ".html",
					},
				}
			end,
		},
		{ "stevearc/dressing.nvim", lazy = false },
		{
			"ziontee113/icon-picker.nvim",
			lazy = false,
			config = function()
				require("icon-picker").setup({
					disable_legacy_commands = true,
				})
			end,
		},
		{
			"SmiteshP/nvim-navic",
			lazy = false,
			dependencies = "neovim/nvim-lspconfig",
		},
		{
			"rmagatti/goto-preview",
			lazy = false,
			config = function()
				require("goto-preview").setup({})
			end,
		},
		{
			"nvim-telescope/telescope-frecency.nvim",
			lazy = false,
			dependencies = { "kkharji/sqlite.lua" },
		},
		{ "nanotee/sqls.nvim", lazy = false },
		{
			"tamton-aquib/duck.nvim",
			lazy = false,
			config = function()
				vim.keymap.set("n", "<leader>dd", function()
					require("duck").hatch("ඞ")
				end, {})
				vim.keymap.set("n", "<leader>dk", function()
					require("duck").cook()
				end, {})
			end,
		},
		{
			"dsych/blanket.nvim",
			lazy = false,
			config = function()
				require("blanket").setup({
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
				})
			end,
		},
		{ "nvim-neotest/nvim-nio", lazy = false },
		{
			"stevearc/conform.nvim",
			opts = {},
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

require("Comment").setup()

vim.notify = require("notify")

-- load plugins
require("uwu")

-- colorshceme
vim.cmd("colorscheme material")
