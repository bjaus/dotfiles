return {
  'ofirgall/open.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local open = require 'open'
    open.setup {}
    vim.keymap.set('n', 'gx', open.open_cword, { desc = 'open url' })
  end,
}
