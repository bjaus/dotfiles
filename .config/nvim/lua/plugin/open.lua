local config = function()
  local open = require 'open'
  open.setup {}
  require('config.keymaps').setup_open(open)
end

return {
  'ofirgall/open.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = config,
}
