return {
  {
    priority = 1000, -- Make sure to load this before all the other start plugins.
    'nyoom-engineering/oxocarbon.nvim',
    enabled = false,
    config = function()
      vim.opt.background = 'dark' -- set this to dark or light
      vim.cmd 'colorscheme oxocarbon'
      vim.cmd.hi 'Comment gui=none'
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end,
  },
  {
    priority = 1000, -- Make sure to load this before all the other start plugins.
    'folke/tokyonight.nvim',
    enabled = true,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    -- To see what colorschemes are already installed: `:Telescope colorscheme`.
    priority = 1000, -- Make sure to load this before all the other start plugins.
    enabled = false,
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha, auto
      background = { -- :h background
        light = 'latte',
        dark = 'mocha',
      },
    },
  },
}
