local Remap = require("uwu.keymaps")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspkind = require("lspkind")
local navic = require("nvim-navic")

capabilities.offsetEncoding = { "utf-16" }

-- autocomplete
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol", -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        return vim_item
      end,
    }),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }),
})

-- mappings for lsp
nnoremap("gd", function()
  vim.lsp.buf.definition()
end)
nnoremap("gD", function()
  vim.lsp.buf.declaration()
end)
nnoremap("gi", function()
  vim.lsp.buf.implementation()
end)
nnoremap("K", function()
  vim.lsp.buf.hover()
end)
nnoremap("<leader>vws", function()
  vim.lsp.buf.workspace_symbol()
end)
nnoremap("<leader>vd", function()
  vim.diagnostic.open_float()
end)
nnoremap("[d", function()
  vim.diagnostic.goto_next()
end)
nnoremap("]d", function()
  vim.diagnostic.goto_prev()
end)
nnoremap("<leader>vca", function()
  vim.lsp.buf.code_action()
end)
nnoremap("<leader>vrr", function()
  vim.lsp.buf.references()
end)
nnoremap("<leader>vrn", function()
  vim.lsp.buf.rename()
end)
inoremap("<C-h>", function()
  vim.lsp.buf.signature_help()
end)

local function attachNavic(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end
end

local function defaultAttach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      require("conform").format({ bufnr = bufnr })
    end,
  })
end

vim.lsp.enable({
  "ts_ls",
  "dockerls",
  "docker_compose_language_service",
  "pyright",
  "clangd",
  "eslint",
  "cmake",
  "prismals",
  "rust_analyzer",
  "tailwindcss",
  "bashls",
  "cssls",
})
vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = defaultAttach,
})
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  on_attach = defaultAttach,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      },
    })
  end,
  settings = {
    Lua = {},
  },
})
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
local function lspSymbol(name, icon)
  vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, numhl = "DiagnosticDefault" .. name })
end

--Enable (broadcasting) snippet capability for completion
local capabilities2 = vim.lsp.protocol.make_client_capabilities()
capabilities2.textDocument.completion.completionItem.snippetSupport = true

function printAll(inp, numSpaces)
  for key, value in pairs(inp) do
    local space = ""
    for i = 0, numSpaces do
      space = space .. " "
    end
    if type(value) == "table" then
      local out = printAll(value, numSpaces + 1)
      print(space .. key .. ":")
      print(out)
    else
      print(space .. key .. ":")
    end
  end
end

vim.lsp.config("cssls", {
  capabilities = capabilities2,
})
vim.lsp.config("eslint", {
  {
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  },
})
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    attachNavic(client, bufnr)
    nnoremap("<leader>o", function()
      local nonTsLs = {}
      -- remove non ts LSPs
      for _, lsp in pairs(vim.lsp.get_clients()) do
        if lsp.name ~= "ts_ls" then
          for _, attachedBuffs in pairs(lsp.attached_buffers) do
            if attachedBuffs == bufnr then
              table.insert(nonTsLs, lsp)
              vim.lsp.buf_detach_client(bufnr, lsp.id)
            end
          end
        end
      end
      -- run command
      vim.lsp.buf.execute_command({
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(bufnr) },
      })
      -- add back LSPs
      for _, lsp in pairs(nonTsLs) do
        vim.lsp.buf_attach_client(bufnr, lsp.id)
      end
    end)
  end,
})

vim.lsp.config("docker_compose_language_service", {
  filetypes = { "yaml" },
})

-- vim.lsp.enable("jsonls")
lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Info", "")
lspSymbol("Warning", "")
