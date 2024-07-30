return {
  'windwp/nvim-autopairs',
  enabled = true,
  event = 'InsertEnter',
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp = require 'cmp'
    local autopairs = require 'nvim-autopairs.completion.cmp'
    cmp.event:on('confirm_done', autopairs.on_confirm_done())
  end,
}
