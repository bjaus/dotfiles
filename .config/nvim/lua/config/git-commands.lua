-- Git helper commands for debugging staging issues
local M = {}

function M.setup()
  -- Manual refresh command
  vim.api.nvim_create_user_command('GitRefresh', function()
    require('gitsigns').refresh()
    vim.cmd('checktime')
    vim.notify('Git signs refreshed', vim.log.levels.INFO)
  end, { desc = 'Manually refresh git signs' })
  
  -- Check git index status
  vim.api.nvim_create_user_command('GitIndexStatus', function()
    local handle = io.popen('git diff --cached --stat')
    if handle then
      local result = handle:read("*a")
      handle:close()
      if result and result ~= "" then
        vim.notify("Staged changes:\n" .. result, vim.log.levels.INFO)
      else
        vim.notify("No staged changes", vim.log.levels.INFO)
      end
    end
  end, { desc = 'Show git index status' })
  
  -- Debug gitsigns status
  vim.api.nvim_create_user_command('GitSignsDebug', function()
    local gs_cache = require('gitsigns.cache').cache
    local bufnr = vim.api.nvim_get_current_buf()
    
    if gs_cache[bufnr] then
      local cache = gs_cache[bufnr]
      vim.notify(string.format(
        "GitSigns Cache Debug:\n" ..
        "File: %s\n" ..
        "Git root: %s\n" ..
        "Staged: %s\n" ..
        "Compare text: %s lines",
        cache.file or "unknown",
        cache.git_obj.repo.gitdir or "unknown",
        vim.inspect(cache.staged),
        cache.compare_text and #cache.compare_text or 0
      ), vim.log.levels.INFO)
    else
      vim.notify("No GitSigns cache for current buffer", vim.log.levels.WARN)
    end
  end, { desc = 'Debug GitSigns cache' })
  
  -- Force re-attach gitsigns
  vim.api.nvim_create_user_command('GitSignsReattach', function()
    require('gitsigns').detach()
    vim.defer_fn(function()
      require('gitsigns').attach()
      vim.notify('GitSigns reattached', vim.log.levels.INFO)
    end, 100)
  end, { desc = 'Force reattach GitSigns' })
end

return M