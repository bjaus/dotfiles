return {
  { -- Useful plugin to show you pending keybindings.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()
      require('which-key').add(require('config.keymaps').setup_which_key_keymaps())
    end,
  },
}
