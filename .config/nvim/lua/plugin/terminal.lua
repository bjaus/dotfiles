return {
  'akinsho/toggleterm.nvim',
  enabled = true,
  version = '*',
  config = function()
    local term = require 'toggleterm'

    term.setup {
      direction = 'horizontal', -- "vertical", "tab", "float"
      size = function(t)
        if t.direction == 'horizontal' then
          return 20
        elseif t.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
    }

    local trim_spaces = true
    vim.keymap.set('v', '<C-s>', function()
      term.send_lines_to_terminal('visual_lines', trim_spaces, { args = vim.v.count, desc = 'Send lines to terminal' })
    end)
    vim.keymap.set('n', '<leader>wt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle [W]indow [T]erminal' })
    vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
  end,
}
