return { -- To see what colorschemes are already installed: `:Telescope colorscheme`.
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    enabled = false,
    priority = 1000,
  },
  { -- https://github.com/scottmckendry/cyberdream.nvim
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    enabled = false,
    priority = 1000,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.opt.background = 'dark' -- set this to dark or light
      vim.cmd 'colorscheme oxocarbon'
      vim.cmd.hi 'Comment gui=none'
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    enabled = true,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'catppuccin/nvim',
    lazy = false,
    enabled = false,
    priority = 1000,
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
