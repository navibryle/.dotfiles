-- keymaps
local Remap = require "uwu.keymaps"
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap

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
nnoremap("<C-A-h>", "<c-w><")
nnoremap("<C-A-j>", "<c-w>-")
nnoremap("<C-A-k>", "<c-w>+")
nnoremap("<C-A-l>", "<c-w>>")
nnoremap("<C-h>", "<c-w>h")
nnoremap("<C-j>", "<c-w>j")
nnoremap("<C-k>", "<c-w>k")
nnoremap("<C-l>", "<c-w>l")
nnoremap("<C-v>", "<c-w>s")
nnoremap("<C-b>", "<c-w>v")
inoremap("<M-n>", "<Nop>")
inoremap("<M-o>", "<Nop>")
inoremap("<MS-n>", "<Nop>")
inoremap("<SM-n>", "<Nop>")
nnoremap("<leader>v", "<c-v>")
nnoremap("<leader>c", ":let @+=expand('%:t:r')<cr>")
nnoremap("<leader>a", "<cmd>AerialToggle!<CR>")
nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>")
nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>")
nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>")
nnoremap("gpd", function() require("goto-preview").goto_preview_definition() end)
nnoremap("gpt", function() require("goto-preview").goto_preview_type_definition() end)
nnoremap("gpi", function() require("goto-preview").goto_preview_implementation() end)
nnoremap("gP", function() require("goto-preview").close_all_win() end)
nnoremap("gpr", function() require("goto-preview").goto_preview_references() end)
nnoremap("<leader>o", function()
  if string.find(vim.bo.filetype, "typescript") ~= 0 then
  vim.cmd "TSToolsAddMissingImports"
  vim.cmd "TSToolsOrganizeImports"
  end
end)
