local config = function()
  local persistence = require 'persistence'

  persistence.setup {
    -- dir = vim.fn.stdpath 'state' .. '/sessions/',
    -- minimum number of file buffers that need to be open to save
    need = 1, -- Set to 0 to always save
    branch = true, -- use git branch to save session
  }

  require('config.keymaps').setup_persistence()
end

-- https://github.com/folke/persistence.nvim?tab=readme-ov-file#-events
return {
  'folke/persistence.nvim',
  enabled = true,
  config = config,
}
