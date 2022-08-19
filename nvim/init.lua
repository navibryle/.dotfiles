require("uwu")
require('nvim-tree').setup()

require('lualine').setup()
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
}

-- keymaps
local Remap = require("uwu.keymaps")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap

vim.cmd [[colorscheme dracula]]

vim.g.mapleader = ',' -- 'vim.g' sets global variables

nnoremap('<leader>m', ':NvimTreeToggle<cr>')
nnoremap('<leader>ff',function ()require('telescope.builtin').find_files()end)
nnoremap('<leader>fg',function ()require('telescope.builtin').live_grep()end)
nnoremap('<leader>fb',function ()require('telescope.builtin').buffers()end)
nnoremap('<leader>fh',function ()require('telescope.builtin').help_tags()end)
nnoremap('<leader>f', function() vim.lsp.buf.formatting() end)
nnoremap('<leader>db', function() require'dap'.toggle_breakpoint() end)
nnoremap('<leader>do', function() require'dap'.step_over() end)
nnoremap('<leader>di', function() require'dap'.step_into() end)
nnoremap('<leader>dr', function() require'dap'.repl.open() end)
nnoremap('<leader>y','"+y')
vnoremap('<leader>y','"+y')
inoremap('<leader>y','"+y')
nnoremap('<leader>p','"+p')
vnoremap('<leader>p','"+p')
inoremap('<leader>p','"+p')

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

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


