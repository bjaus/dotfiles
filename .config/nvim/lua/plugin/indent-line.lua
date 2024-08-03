return {
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  enabled = true,
  main = 'ibl',
  opts = {
    indent = {
      char = '┊',
    },
  },
}
