return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.cmd 'colorscheme cyberdream'
    local colors = require('util.colors').colors

    require('lualine').setup {
      options = {
        theme = {
          normal = {
            a = { fg = colors.bg, bg = colors.blue },
            b = { fg = colors.fg, bg = colors.bg },
            c = { fg = colors.fg, bg = colors.bg },
          },
          insert = {
            a = { fg = colors.bg, bg = colors.green },
          },
          visual = {
            a = { fg = colors.bg, bg = colors.magenta },
          },
          replace = {
            a = { fg = colors.bg, bg = colors.red },
          },
          command = {
            a = { fg = colors.bg, bg = colors.yellow },
          },
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
    }
  end,
}
