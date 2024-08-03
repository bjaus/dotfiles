return {
  'rmagatti/auto-session',
  enabled = false,
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
  },
  config = function()
    require('auto-session').setup {
      auto_session_use_git_branch = true,
      auto_session_suppress_dirs = {
        '/',
        '~/',
        '~/Projects',
        '~/Downloads',
        '~/Downloads',
      },
    }
  end,
}
