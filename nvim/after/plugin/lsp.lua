local Remap = require "uwu.keymaps"
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local sumneko_root_path = "/opt/luaLs"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp = require "cmp"
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspkind = require "lspkind"
local navic = require "nvim-navic"
capabilities.offsetEncoding = { "utf-16" }
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup {
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol", -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item) return vim_item end,
    },
  },
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-y>"] = cmp.mapping.confirm { select = true },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  },
}
nnoremap("gd", function() vim.lsp.buf.definition() end)
nnoremap("K", function() vim.lsp.buf.hover() end)
nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
nnoremap("[d", function() vim.diagnostic.goto_next() end)
nnoremap("]d", function() vim.diagnostic.goto_prev() end)
nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)

-- Setup lspconfig.
require("lspconfig").sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
        vim.cmd "FormatWrite"
      end,
    })
  end,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "Lua 5.4",
        -- Setup your lua path
        path = "/usr/bin/lua",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          "/usr/share/lua/5.4/re.lua",
        },
      },
    },
  },
}
require("lspconfig").vimls.setup {
  capabilities = capabilities,
  on_attach = require("aerial").on_attach,
}
require("lspconfig")["pyright"].setup {
  capabilities = capabilities,
}
require("lspconfig").clangd.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        -- require("lint").try_lint()
        vim.cmd "FormatWrite"
      end,
    })
  end,
}
require("lspconfig").texlab.setup {
  settings = {
    texlab = {
      diagnosticsDelay = 100,
      build = {
        onSave = true,
        args = {
          "-synctex=1",
          "-interaction=nonstopmode",
          "-file-line-error",
          "-pdf",
          "-outdir=build",
          "%f",
        },
      },
    },
  },
  capabilities = capabilities,
}
require("lspconfig").cmake.setup {}
require("lspconfig").rust_analyzer.setup {
  on_attach = function(client, bufnr) end,
}
require("lspconfig").bashls.setup {
  on_attach = function(client, bufnr) end,
}
