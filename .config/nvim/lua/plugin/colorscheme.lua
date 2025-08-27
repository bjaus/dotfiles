return { -- To see what colorschemes are already installed: `:Telescope colorscheme`.
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    enabled = true,
    priority = 1000,
    init = function()
      vim.cmd 'colorscheme cyberdream'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}