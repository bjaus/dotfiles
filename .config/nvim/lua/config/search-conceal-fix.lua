-- Fix concealed text showing during search
local M = {}

function M.setup()
  -- Store original conceal level
  local original_conceallevel = vim.o.conceallevel
  local original_concealcursor = vim.o.concealcursor

  -- Temporarily disable concealment during search
  vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = "/,?",
    callback = function()
      vim.o.conceallevel = 0
    end,
    group = vim.api.nvim_create_augroup("SearchConcealFix", { clear = true }),
  })

  -- Restore concealment after search
  vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = "/,?",
    callback = function()
      -- Small delay to let search highlighting complete
      vim.defer_fn(function()
        vim.o.conceallevel = original_conceallevel
      end, 50)
    end,
    group = vim.api.nvim_create_augroup("SearchConcealFix", { clear = false }),
  })

  -- Alternative: Set concealcursor to not conceal in normal mode during search
  vim.opt.concealcursor = "ic"  -- Only conceal in insert and command mode
end

return M