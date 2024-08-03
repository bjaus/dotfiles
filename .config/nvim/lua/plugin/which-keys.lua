return {
  -- Useful plugin to show you pending keybindings.
  -- https://github.com/folke/which-key.nvim
  'folke/which-key.nvim',
  enabled = true,
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    local which_key = require 'which-key'
    which_key.setup()
    which_key.add(require('config.keymaps').setup_which_key())
  end,
}
