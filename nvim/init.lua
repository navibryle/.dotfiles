require "uwu"
require("nvim-tree").setup {
  reload_on_bufenter = false,
  sort_by = "case_sensitive",
  view = {
    relativenumber = true,
    adaptive_size = true,
  },
  renderer = {
    highlight_opened_files = "all",
    group_empty = true,
    icons = {
      show = {
        folder_arrow = false,
      },
    },
  },
}

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
require("telescope").setup {
  defaults = {
    path_display = { "truncate" },
  },
}
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
require("indent_blankline").setup {
  show_end_of_line = true,
  space_char_blankline = " ",
}

-- keymaps
local Remap = require "uwu.keymaps"
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap

vim.g.mapleader = " "

nnoremap("<leader>m", ":NvimTreeToggle<cr>")
nnoremap("<leader>ff", function() require("telescope.builtin").find_files() end)
nnoremap("<leader>fg", function() require("telescope.builtin").live_grep() end)
nnoremap("<leader>fb", function() require("telescope.builtin").buffers() end)
nnoremap("<leader>fh", function() require("telescope.builtin").help_tags() end)
nnoremap("<leader>f", function() vim.lsp.buf.formatting() end)
nnoremap("<leader>du", function() require("dap").continue() end)
nnoremap("<leader>de", function() require("dap").continue() end)
nnoremap("<leader>db", function() require("dap").toggle_breakpoint() end)
nnoremap("<leader>do", function() require("dap").step_over() end)
nnoremap("<leader>di", function() require("dap").step_into() end)
nnoremap("<leader>dr", function() require("dap").repl.open() end)
nnoremap("<leader>dq", function() require("dapui").toggle() end)
vnoremap("<leader>y", '"+y')
nnoremap("<leader>p", '"+p')
vnoremap("<leader>p", '"+p')
nnoremap("<leader>q", ":q!<cr>")
nnoremap("<leader>e", ":wq<cr>")
nnoremap("<leader>D", '"_d')
nnoremap("<leader>s", ":w<cr>")
nnoremap("<leader>n", function() require("notify").dismiss() end)
nnoremap("<C-h>", "<c-w>h")
nnoremap("<C-j>", "<c-w>j")
nnoremap("<C-k>", "<c-w>k")
nnoremap("<C-l>", "<c-w>l")
nnoremap("<C-b>", "<c-w>c")
nnoremap("<C-v>", "<c-w>v")
inoremap("<M-n>", "<Nop>")
inoremap("<M-o>", "<Nop>")
inoremap("<MS-n>", "<Nop>")
inoremap("<SM-n>", "<Nop>")
nnoremap("<leader>v", "<c-v>")
nnoremap("<leader>c", ":setlocal spell! spelllang=en_us<cr>")
nnoremap("<leader>a", "<cmd>AerialToggle!<CR>")
vim.notify = require "notify"

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

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append "c"
require("colorizer").setup()
require("Comment").setup()

require("nvim-treesitter.configs").setup {
  autotag = {
    enable = true,
  },
}
require("nvim-treesitter.configs").setup {
  highlight = {
    -- ...
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
}
require("material").setup {

  contrast = {
    terminal = false, -- Enable contrast for the built-in terminal
    sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
    floating_windows = false, -- Enable contrast for floating windows
    cursor_line = false, -- Enable darker background for the cursor line
    non_current_windows = false, -- Enable darker background for non-current windows
    filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
  },

  styles = { -- Give comments style such as bold, italic, underline etc.
    comments = { italic = true },
    strings = { bold = true },
    keywords = { underline = true },
    functions = { bold = true, undercurl = true },
    variables = {},
    operators = {},
    types = {},
  },

  plugins = { -- Uncomment the plugins that you use to highlight them
    -- Available plugins:
    "dap",
    "nvim-cmp",
    -- "nvim-navic",
    "nvim-tree",
    "telescope",
    "trouble",
    -- "which-key",
  },

  disable = {
    colored_cursor = false, -- Disable the colored cursor
    borders = false, -- Disable borders between verticaly split windows
    background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
    term_colors = false, -- Prevent the theme from setting terminal colors
    eob_lines = false, -- Hide the end-of-buffer lines
  },

  high_visibility = {
    lighter = false, -- Enable higher contrast text for lighter style
    darker = false, -- Enable higher contrast text for darker style
  },

  lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

  async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

  custom_colors = nil, -- If you want to everride the default colors, set this to a function

  custom_highlights = {}, -- Overwrite highlights with your own
}
vim.opt.termguicolors = true
vim.o.termguicolors = true
vim.g.material_style = "deep ocean"
vim.cmd "colorscheme material"
-- Lua
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
require("nvim-lightbulb").setup { autocmd = { enabled = true } }
require("aerial").setup {
  on_attach = function(bufnr)
    -- Toggle the aerial window with <leader>a
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>AerialToggle!<CR>", {})
    -- Jump forwards/backwards with '{' and '}'
    vim.api.nvim_buf_set_keymap(bufnr, "n", "{", "<cmd>AerialPrev<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "}", "<cmd>AerialNext<CR>", {})
    -- Jump up the tree with '[[' or ']]'
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[[", "<cmd>AerialPrevUp<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]]", "<cmd>AerialNextUp<CR>", {})
  end,
}
-- linter config
require("lint").linters_by_ft = {
  markdown = { "vale" },
  cpp = { "clangtidy" },
}
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function() require("lint").try_lint() end,
-- })
-- changing lsp diag symbols
local function lspSymbol(name, icon)
  vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, numhl = "DiagnosticDefault" .. name })
end

lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Info", "")
lspSymbol("Warning", "")

-- icon picker
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts)
vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
-- vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
vim.notify.setup {
  fps = 1,
  render = "minimal",
  stages = "static",
  timeout = 9000,
}
-- presence nvim
require("presence"):setup()
