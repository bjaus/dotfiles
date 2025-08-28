-- Fix for Treesitter highlighting errors
-- Wraps Treesitter highlighter to handle out-of-range errors gracefully

local M = {}

function M.setup()
  -- Don't try to patch the internal highlighter, just add error recovery

  -- Add protection for the decoration provider
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("TreesitterErrorHandler", { clear = true }),
    callback = function(args)
      local buf = args.buf
      
      -- Check if buffer is valid
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      
      -- Get buffer line count
      local line_count = vim.api.nvim_buf_line_count(buf)
      
      -- Clear any invalid extmarks that might be out of range
      pcall(function()
        local ns_id = vim.api.nvim_get_namespaces()['nvim.treesitter.highlighter']
        if ns_id then
          -- Get all extmarks
          local extmarks = vim.api.nvim_buf_get_extmarks(buf, ns_id, 0, -1, {})
          for _, mark in ipairs(extmarks) do
            local _, row = unpack(mark)
            -- Remove marks that are out of range
            if row >= line_count then
              vim.api.nvim_buf_del_extmark(buf, ns_id, mark[1])
            end
          end
        end
      end)
    end,
  })
  
  -- Add command to reset treesitter if needed
  vim.api.nvim_create_user_command('TSReset', function()
    vim.cmd('TSBufDisable highlight')
    vim.cmd('TSBufEnable highlight')
    vim.notify('Treesitter highlighting reset', vim.log.levels.INFO)
  end, { desc = 'Reset Treesitter highlighting' })
  
  -- Add command to clear treesitter errors
  vim.api.nvim_create_user_command('TSClearErrors', function()
    local buf = vim.api.nvim_get_current_buf()
    local ns_id = vim.api.nvim_get_namespaces()['nvim.treesitter.highlighter']
    if ns_id then
      vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
      vim.notify('Treesitter errors cleared', vim.log.levels.INFO)
    end
  end, { desc = 'Clear Treesitter highlighting errors' })
end

return M