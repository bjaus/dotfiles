local dbs = require('util').safe_require 'config.db' or {}

return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    {
      'tpope/vim-dadbod',
      lazy = true,
      config = function()
        vim.g.dbs = dbs
      end,
    },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    -- {
    --   'napisani/nvim-dadbod-bg',
    --   build = './install.sh',
    --   config = function()
    --     vim.cmd [[
    --     let g:nvim_dadbod_bg_port = '4546'
    --     leg g:nvim_dadbod_bg_log_file = '/tmp/nvim-dadbod-bg.log'
    --   ]]
    --   end,
    -- },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  -- keys = require('config.keymaps').setup_dadbod(),
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    require('config.keymaps').setup_dadbod()
  end,
  lazy = true,
}
