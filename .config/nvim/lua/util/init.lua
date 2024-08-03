local M = {}

local function get_config_modules(excludes)
  excludes = excludes or {
    "lazy",
    "init",
  }
  local files = {}
  local expr = vim.fn.stdpath("config") .. "/lua/config/*.lua"
  for _, file in ipairs(vim.fn.glob(expr, true, true)) do
    table.insert(files, vim.fn.fnamemodify(file, ":t:r"))
  end
  files = vim.tbl_filter(function(file)
    for _, pattern in ipairs(excludes) do
      if file:match(pattern) then
        return false
      end
    end
    return true
  end, files)
  return files
end

function M.load()
  for _, file in ipairs(get_config_modules()) do
    require('config.' .. file)
  end
  require('config.lazy')
end

function M.reload_lua()
  for _, file in ipairs(get_config_modules()) do
    require('config.' .. file)
    require('util.func')
  end
  vim.cmd.nohlsearch()
end

function M.create_augroup(group, opts)
  opts = opts or { clear = true }
  return vim.api.nvim_create_augroup(group, opts)
end

function M.diag_error()
  return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) ~= 0
end

return M
