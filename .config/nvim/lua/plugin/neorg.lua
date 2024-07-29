return {
  -- NOTE: require to `brew install luarocks`
  -- Tutorial: https://github.com/nvim-neorg/neorg/wiki/Tutorial
  -- Keybindings: https://github.com/nvim-neorg/neorg/wiki/Default-Keybinds

  -- https://github.com/nvim-neorg/neorg
  'nvim-neorg/neorg',
  enabled = false,
  lazy = false,
  version = '*',
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
            },
            default_workspace = 'notes',
          },
        },
      },
    }

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
