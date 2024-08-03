local config = function()
  local harpoon = require 'harpoon'
  ---@diagnostic disable-next-line
  harpoon.setup {
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  }
  require('config.keymaps').setup_harpoon(harpoon)
end

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = config,
}
