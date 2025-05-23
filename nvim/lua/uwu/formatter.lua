require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    bash = { "beautysh" },
    html = { "js-beautify" },
    json = { "jq" },
  },
  formatters = {
    stylua = {
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
  },
})
