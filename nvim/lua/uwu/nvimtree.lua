
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
