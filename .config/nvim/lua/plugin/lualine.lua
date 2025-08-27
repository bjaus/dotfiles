return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = { 
    'nvim-tree/nvim-web-devicons',
    'SmiteshP/nvim-navic',
  },
  config = function()
    vim.cmd 'colorscheme cyberdream'
    local colors = require('util.colors').colors

    -- Lightweight Go package display (cached, doesn't parse on every update)
    local go_package_cache = {}
    local go_package = function()
      if vim.bo.filetype ~= 'go' then
        return ''
      end
      
      local bufnr = vim.api.nvim_get_current_buf()
      local filepath = vim.api.nvim_buf_get_name(bufnr)
      
      -- Check cache first
      if go_package_cache[filepath] then
        return go_package_cache[filepath]
      end
      
      -- Get the first few lines of the file to find package name
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 10, false)
      for _, line in ipairs(lines) do
        local package = line:match('^package%s+(%S+)')
        if package then
          local display = '📦 ' .. package
          go_package_cache[filepath] = display
          return display
        end
      end
      
      go_package_cache[filepath] = ''
      return ''
    end
    
    -- Clear cache when buffer is saved or changed
    vim.api.nvim_create_autocmd({'BufWritePost', 'BufEnter'}, {
      pattern = '*.go',
      callback = function()
        local filepath = vim.api.nvim_buf_get_name(0)
        go_package_cache[filepath] = nil
      end
    })

    -- Breadcrumbs component using nvim-navic
    local breadcrumbs = function()
      local ok, navic = pcall(require, "nvim-navic")
      if ok and navic.is_available() then
        return navic.get_location()
      end
      return ""
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
        lualine_c = { 'filename', go_package, breadcrumbs },
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
      winbar = {
        lualine_c = { breadcrumbs },
      },
      inactive_winbar = {
        lualine_c = { 'filename' },
      },
    }
  end,
}
