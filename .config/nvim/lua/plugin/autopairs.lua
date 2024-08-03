return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {
      disable_filetype = {
        'TelescopePrompt',
      },
    }
    -- automatically add `(` after selecting a function or method
    local cmp = require 'cmp'
    local autopairs = require 'nvim-autopairs.completion.cmp'
    cmp.event:on('confirm_done', autopairs.on_confirm_done())
  end,
}
