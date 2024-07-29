return {
    -- Useful plugin to show you pending keybindings.
    -- https://github.com/folke/which-key.nvim
    'folke/which-key.nvim',
    enabled = true,
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()
      vim.keymap.set('n', '<leader>wk', '<cmd>WhichKey<cr>', { desc = 'show which key'})
      -- require('which-key').add(require('config.keymaps').setup_which_key_keymaps())
    end,
}
