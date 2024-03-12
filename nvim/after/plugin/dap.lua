local dap = require "dap"
dap.adapters.codelldb = {
  type = "server",
  host = "127.0.0.1",
  port = "8080",
  executable = {
  command = "/home/ivan/.local/share/extension_/adapter/codelldb",
  args = { "--port", "8080" },
  },
}
dap.configurations.cpp = {
  {
  name = "Launch file",
  type = "codelldb",
  request = "launch",
  program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
  cwd = "${workspaceFolder}",
  stopOnEntry = true,
  stdio = { vim.fn.getcwd() .. "/" .. "t.in" },
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
dap.configurations.java = {
  {
  type = "java",
  request = "attach",
  name = "tomcat debugger",
  hostName = "localhost",
  port = 8000,
  processId = 68836,
  },
}
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#993939", bg = "#31353f" })

vim.fn.sign_define(
  "DapBreakpoint",
  { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapLogPoint",
  { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
require("dapui").setup {
  layouts = {
  {
    elements = {
    -- Elements can be strings or table with id and size keys.
    { id = "watches", size = 0.3 },
    { id = "scopes", size = 0.7 },
    },
    size = 40, -- 40 columns
    position = "left",
  },
  {
    elements = {
    "repl",
    "console",
    },
    size = 0.25, -- 25% of total lines
    position = "bottom",
  },
  },
}
require("nvim-dap-virtual-text").setup()
