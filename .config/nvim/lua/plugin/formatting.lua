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
      go = { 'goimports', 'gofumpt' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      html = { 'prettier' },
      markdown = { 'prettier' },
      yaml = { 'prettier' },
      toml = { 'taplo' },
      lua = { 'stylua' },
      python = { 'ruff_format', 'ruff_organize_imports' },
      rust = { 'rustfmt' },
    },
  },
  config = function(_, opts)
    local conform = require 'conform'

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        if vim.g.auto_format then
          -- Get available formatters for this filetype
          local formatters = conform.list_formatters(args.buf)
          
          -- Only try to format if formatters are available
          if #formatters > 0 then
            local ok, err = pcall(conform.format, {
              bufnr = args.buf,
              timeout_ms = 5000,
              lsp_format = 'fallback',
            })
            
            if not ok then
              vim.notify("Formatter error: " .. tostring(err), vim.log.levels.WARN)
            end
          else
            -- Fallback to LSP formatting if available
            vim.lsp.buf.format({ 
              bufnr = args.buf, 
              timeout_ms = 5000,
              filter = function(client)
                return client.supports_method("textDocument/formatting")
              end
            })
          end
        end
      end,
    })

    -- set initial state to auto-format
    vim.g.auto_format = true
    conform.setup(opts)
    
    -- Add user commands for formatting control
    vim.api.nvim_create_user_command('FormatToggle', function()
      vim.g.auto_format = not vim.g.auto_format
      vim.notify("Auto-format " .. (vim.g.auto_format and "enabled" or "disabled"))
    end, { desc = "Toggle auto-formatting" })
    
    vim.api.nvim_create_user_command('FormatStatus', function()
      local status = vim.g.auto_format and "enabled" or "disabled"
      local formatters = conform.list_formatters()
      local available = {}
      for _, formatter in ipairs(formatters) do
        if formatter.available then
          table.insert(available, formatter.name)
        end
      end
      
      vim.notify("Auto-format: " .. status .. "\nAvailable formatters: " .. table.concat(available, ", "))
    end, { desc = "Show formatting status" })
  end,
}
