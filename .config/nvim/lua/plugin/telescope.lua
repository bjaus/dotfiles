-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

local config = function()
  local telescope = require 'telescope'

  telescope.setup {
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
    -- path_display = 'shorten',
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  }

  pcall(telescope.load_extension, 'fzf')
  pcall(telescope.load_extension, 'ui-select')

  require('config.keymaps').setup_telescope()
end

return {
  -- Fuzzy Finder (files, lsp, etc)
  -- https://github.com/nvim-tele
  'nvim-telescope/telescope.nvim',
  enabled = true,
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    'crusj/bookmarks.nvim',
    'ThePrimeagen/harpoon',
  },
  config = config,
}
