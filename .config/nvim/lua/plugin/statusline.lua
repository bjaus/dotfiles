return {
  {
    'nvim-lualine/lualine.nvim',
    enabled = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      color_scheme = "cyberdream",
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      options = {
        mode = "tabs", -- only show tabpages instead of buffers
        always_show_bufferline = false,
      },
    },
  },
}
