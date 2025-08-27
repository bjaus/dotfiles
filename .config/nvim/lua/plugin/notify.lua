return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    render = "compact",
    stages = "slide",
  },
  config = function(_, opts)
    require("notify").setup(opts)
    
    -- Create a wrapper around vim.notify to filter out annoying messages
    local notify = require("notify")
    vim.notify = function(msg, level, opts)
      -- Filter out golangci-lint exit code messages
      if msg and msg:match("golangci%-lint.*exited with code") then
        return -- Suppress this notification
      end
      -- Pass through all other notifications
      return notify(msg, level, opts)
    end
  end,
}
