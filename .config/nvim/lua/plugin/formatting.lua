return {
  -- Autoformat
  -- https://github.com/stevearc/conform.nvim
  'stevearc/conform.nvim',
  enabled = true,
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = require('config.keymaps').setup_conform(),
  opts = {
    format_on_save = {
      timeout_ms = 5000,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      go = { 'goimports-reviser' },
      lua = { 'stylua' },
      python = { 'black', timeout_ms = 10000 },
    },
  },
  config = function(_, opts)
    local conform = require 'conform'

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        if vim.g.auto_format then
          conform.format {
            bufnr = args.buf,
            timeout_ms = 5000,
            lsp_format = 'fallback',
          }
        else
        end
      end,
    })

    -- set initial state to auto-format
    vim.g.auto_format = true
    conform.setup(opts)
  end,
}
