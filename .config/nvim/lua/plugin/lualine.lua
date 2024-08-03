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
    }
  end,
}
