-- require("null-ls").setup({
--   sources = {
--     require("null-ls").builtins.formatting.stylua,
--     require("null-ls").builtins.formatting.clang_format.with({
--       extra_args = { "--style", "{IndentWidth: 4 ,ColumnLimit: 120,SeparateDefinitionBlocks: Always}" },
--     })
--   },
-- })
---- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
  -- Formatter configurations for filetype "lua" go here
  -- and will be executed in order
  lua = {
    -- "formatter.filetypes.lua" defines default configurations for the
    -- "lua" filetype
    require("formatter.filetypes.lua").stylua,

    -- You can also define your own configuration
    function()
    -- Full specification of configurations is down below and in Vim help
    -- files
    return {
      exe = "stylua",
      args = {
      "--search-parent-directories",
      "--stdin-filepath",
      util.escape_path(util.get_current_buffer_file_path()),
      "--",
      "-",
      },
      stdin = true,
    }
    end,
  },
  c = {
    function()
    return {
      exe = "clang-format",
      args = {
      '--style "{IndentWidth: 4 ,ColumnLimit: 120,SeparateDefinitionBlocks: Always}"',
      "-assume-filename",
      util.escape_path(util.get_current_buffer_file_path()),
      },
      stdin = true,
    }
    end,
  },
  cpp = {
    function()
    return {
      exe = "clang-format",
      args = {
      '--style "{IndentWidth: 4 ,ColumnLimit: 120,SeparateDefinitionBlocks: Always}"',
      "-assume-filename",
      util.escape_path(util.get_current_buffer_file_path()),
      },
      stdin = true,
    }
    end,
  },

  -- Use the special "*" filetype for defining formatter configurations on
  -- any filetype
  ["*"] = {
    -- "formatter.filetypes.any" defines default configurations for any
    -- filetype
  },
  },
}
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function() vim.cmd "FormatWrite" end,
-- - })
