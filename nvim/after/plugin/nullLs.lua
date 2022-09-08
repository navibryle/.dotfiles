require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.formatting.clang_format.with({
            extra_args = { "--style", "{IndentWidth: 4 ,ColumnLimit: 120,SeparateDefinitionBlocks: Always}" },
        })
    },
})
