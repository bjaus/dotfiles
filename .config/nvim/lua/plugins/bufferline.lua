return {
  "akinsho/bufferline.nvim",
  enabled = true,
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      mode = "tabs",
      diagnostics = "nvim_lsp",
      seperator_style = "slant",
      max_name_length = 25,
      tab_size = 25,
    },
  },
}
