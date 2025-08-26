return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.cmd 'colorscheme cyberdream'
    local colors = require('util.colors').colors
    -- Custom component to show Go package name
    local go_package = function()
      if vim.bo.filetype ~= 'go' then
        return ''
      end
      
      -- Get the first line of the file to find package name
      local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
      for _, line in ipairs(lines) do
        local package = line:match('^package%s+(%S+)')
        if package then
          return '📦 ' .. package
        end
      end
      return ''
    end

    -- Custom component to show current function name
    local current_function = function()
      if vim.bo.filetype ~= 'go' then
        return ''
      end
      
      local ok, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
      if not ok then
        return ''
      end
      
      local node = ts_utils.get_node_at_cursor()
      while node do
        if node:type() == 'function_declaration' or node:type() == 'method_declaration' then
          local name_node = node:field('name')[1]
          if name_node then
            local func_name = vim.treesitter.get_node_text(name_node, 0)
            -- For methods, try to get receiver type
            if node:type() == 'method_declaration' then
              local recv_node = node:field('receiver')[1]
              if recv_node then
                local params = recv_node:field('parameters')[1]
                if params and params:child_count() > 0 then
                  local type_node = params:child(0):field('type')[1]
                  if type_node then
                    local recv_type = vim.treesitter.get_node_text(type_node, 0):gsub('*', '')
                    return '🔧 ' .. recv_type .. '.' .. func_name .. '()'
                  end
                end
              end
            end
            return '🔧 ' .. func_name .. '()'
          end
        end
        node = node:parent()
      end
      return ''
    end

    require('lualine').setup {
      options = {
        theme = {
          normal = {
            a = { fg = colors.bg, bg = colors.blue },
            b = { fg = colors.fg, bg = colors.bg },
            c = { fg = colors.fg, bg = colors.bg },
          },
          insert = {
            a = { fg = colors.bg, bg = colors.green },
          },
          visual = {
            a = { fg = colors.bg, bg = colors.magenta },
          },
          replace = {
            a = { fg = colors.bg, bg = colors.red },
          },
          command = {
            a = { fg = colors.bg, bg = colors.yellow },
          },
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 
          'filename',
          go_package,  -- Shows package name for Go files
          current_function,  -- Shows current function
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename', go_package },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
    }
  end,
}
