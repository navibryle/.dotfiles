require("nvim-tree").setup {
  reload_on_bufenter = false,
  sort_by = "case_sensitive",
  respect_buf_cwd = true,
  update_cwd = true,
  view = {
  relativenumber = true,
  adaptive_size = true,
  },
  update_focused_file = {
  enable = true,
  debounce_delay = 15,
  update_root = false,
  ignore_list = {},
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
