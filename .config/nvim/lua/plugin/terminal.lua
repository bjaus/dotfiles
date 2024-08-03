local config = function()
  local term = require 'toggleterm'

  term.setup {
    direction = 'float', -- 'horizontal', 'vertical', 'tab', 'float'
    size = function(t)
      if t.direction == 'horizontal' then
        return 20
      elseif t.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
  }

  local trim_spaces = true
  require('config.keymaps').setup_toggleterm(trim_spaces)
end

return {
  'akinsho/toggleterm.nvim',
  enabled = true,
  version = '*',
  config = config,
}
