-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim?tab=readme-ov-file#quickstart

return {
  {
    -- https://github.com/s1n7ax/nvim-window-picker
    's1n7ax/nvim-window-picker',
    enabled = true,
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
      require('window-picker').setup()
    end,
  },
  {
    -- https://github.com/nvim-neo-tree/neo-tree.nvim
    'nvim-neo-tree/neo-tree.nvim',
    enabled = true,
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim', -- optional image support in preview mode
      's1n7ax/nvim-window-picker',
    },
    cmd = 'Neotree',
    keys = require('config.keymaps').setup_neotree(),
    opts = {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      sort_case_insensitive = true,
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
      sources = {
        'buffers',
        'document_symbols',
        'filesystem',
        'git_status',
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = 'open_default',
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            '.git',
          },
        },
        window = {
          mappings = {
            ['\\'] = 'close_window',
            ['o'] = 'open',
          },
        },
      },
    },
  },
}
