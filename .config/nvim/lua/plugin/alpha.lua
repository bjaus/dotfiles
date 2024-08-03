local config = function()
  local alpha = require 'alpha'
  local dashboard = require 'alpha.themes.dashboard'

  vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#00FF00' })

  dashboard.section.header.val = {
    '                                                     ',
    '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
    '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
    '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
    '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
    '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
    '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
    '                                                     ',
  }

  dashboard.section.header.opts.hl = 'DashboardHeader'

  -- Set menu
  dashboard.section.buttons.val = {
    dashboard.button('n', '  > new file', '<cmd>ene<cr>'),
    dashboard.button('o', '  > open file explorer', '<cmd>Neotree source=filesystem reveal=true position=left action=focus<cr>'),
    dashboard.button('f', '󰱼  > find file', '<cmd>Telescope find_files<cr>'),
    dashboard.button('w', '  > find word', '<cmd>Telescope live_grep<cr>'),
    dashboard.button('r', '󰁯  > restore session', '<cmd>lua require("persistence").load()<cr>'),
    dashboard.button('q', '  > quit', '<cmd>qa<CR>'),
  }

  -- Send config to alpha
  alpha.setup(dashboard.opts)

  -- Disable folding on alpha buffer
  vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
end

return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = config,
}
