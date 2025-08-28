-- Gitsigns highlight configuration
local M = {}

function M.setup()
  -- Set up distinct colors for staged vs unstaged changes
  vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#10b981' })  -- Green for unstaged adds
  vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#f59e0b' })  -- Amber for unstaged changes
  vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#ef4444' })  -- Red for deletes
  
  -- Staged changes - dimmer/different colors to distinguish
  vim.api.nvim_set_hl(0, 'GitSignsStagedAdd', { fg = '#065f46' })  -- Dark green for staged adds
  vim.api.nvim_set_hl(0, 'GitSignsStagedChange', { fg = '#92400e' })  -- Dark amber for staged changes
  vim.api.nvim_set_hl(0, 'GitSignsStagedDelete', { fg = '#991b1b' })  -- Dark red for staged deletes
  
  -- Untracked files
  vim.api.nvim_set_hl(0, 'GitSignsUntracked', { fg = '#6b7280' })  -- Gray for untracked
end

return M