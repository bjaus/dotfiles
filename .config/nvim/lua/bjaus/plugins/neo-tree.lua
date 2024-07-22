-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim?tab=readme-ov-file#quickstart

return {
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
      require('window-picker').setup()
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- '3rd/image.nvim', -- optional image support in preview mode
      's1n7ax/nvim-window-picker',
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree source=filesystem reveal=true position=left action=show toggle=true<CR>', desc = 'NeoTree reveal' },
    },
    opts = {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      sort_case_insensitive = true,
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
  },
}
