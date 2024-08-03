return {
  'Exafunction/codeium.nvim',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  event = 'InsertEnter',
  config = function()
    require('codeium').setup({})
  end,
}
