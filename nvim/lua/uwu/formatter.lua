require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    bash = { "beautysh" },
    html = { "js-beautify" },
    json = { "jq" }
  },
})
