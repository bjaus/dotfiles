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

return M
