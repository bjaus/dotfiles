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
      dart = { 'dart_format' },
      go = { 'goimports-reviser', 'gofumpt' },
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
    -- Custom formatter for goimports-reviser
    -- Groups imports: (1) stdlib, (2) third-party, (3) company/org, (4) local project
    require('conform').formatters['goimports-reviser'] = {
      command = 'goimports-reviser',
      args = function(self, ctx)
        -- Auto-detect Go module name from go.mod
        local go_mod = vim.fs.find('go.mod', {
          upward = true,
          path = ctx.dirname,
        })[1]

        local project_name = nil
        if go_mod then
          local lines = vim.fn.readfile(go_mod)
          for _, line in ipairs(lines) do
            local module = line:match('^module%s+(.+)$')
            if module then
              project_name = module
              break
            end
          end
        end

        local args = {
          '-company-prefixes', 'github.com/rewardStyle,github.com/bjaus',
          '-output', 'file',
          '-set-alias',
          '-rm-unused',
          '-format',
        }

        if project_name then
          table.insert(args, '-project-name')
          table.insert(args, project_name)
        end

        table.insert(args, '$FILENAME')
        return args
      end,
      stdin = false,
    }

    -- Custom formatter for Dart
    require('conform').formatters['dart_format'] = {
      command = 'dart',
      args = { 'format', '$FILENAME' },
      stdin = false,
    }

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
