
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
require("presence"):setup()
require("colorizer").setup()
require("Comment").setup()
vim.notify = require "notify"

-- load plugins
require "uwu"
-- colorshceme
vim.cmd "colorscheme material"
