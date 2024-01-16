-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require "lualine"

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#353935',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
  neonblue = '#1F51FF'
}
local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand "%:t") ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand "%:p:h"
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    globalstatus = true,
    component_separators = "",
    section_separators = "",
    theme = "moonfly",
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
    lualine_d = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component) table.insert(config.sections.lualine_c, component) end

-- Inserts a component in lualine_x ot right section
local function ins_right(component) table.insert(config.sections.lualine_x, component) end

ins_left {
  -- mode component
  function() return "" end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [""] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  "filename",
  cond = conditions.buffer_not_empty,
  color = { fg = colors.neonblue, gui = "bold" },
}

ins_left {
  require("auto-session.lib").current_session_name,
  icon = "",
  color = { fg = colors.blue, gui = "bold" },
}

ins_left {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function() return "%=" end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = ""
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    local clientLogo =
      { rust = "", python = "", java = "", lua = "", tex = "", bash = "", clangd = "" }
    local existingClients = { "rust", "python", "java", "lua", "tex", "bash", "clangd" }
    if next(clients) == nil then return msg end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        for i, j in pairs(existingClients) do
          if string.find(client.name, j) then return clientLogo[j] end
        end
        return client.name
      end
      return msg
    end
  end,
  color = { fg = "lightblue", gui = "bold" },
}

-- Add components to right sections

ins_right {
  "branch",
  icon = "",
  color = { fg = colors.violet, gui = "bold" },
}

ins_right {
  "diff",
  -- Is it me or the symbol for modified us really weird
  symbols = { added = " ", modified = "柳 ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

-- Now don't forget to initialize lualine
lualine.setup(config)
