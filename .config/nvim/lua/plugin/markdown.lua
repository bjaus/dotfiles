local config = function()
  local peek = require 'peek'

  peek.setup {
    auto_load = true, -- whether to automatically load preview when entering another markdown buffer
    close_on_bdelete = false, -- keep browser tab open when buffer is deleted
    syntax = true, -- enable syntax highlighting, affects performance
    theme = 'dark', -- 'dark' or 'light'
    update_on_change = true,
    app = 'browser', -- 'webview', 'browser', string or a table of strings
    filetype = { 'markdown' }, -- list of filetypes to recognize as markdown
    -- relevant if update_on_change is true
    throttle_at = 200000, -- start throttling when file exceeds this
    -- amount of bytes in size
    throttle_time = 'auto', -- minimum amount of time in milliseconds
  }

  local function toggle()
    if not peek.is_open() and vim.bo[vim.api.nvim_get_current_buf()].filetype == 'markdown' then
      peek.open()
    else
      peek.close()
    end
  end

  require('config.keymaps').setup_peek(toggle)

  vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
  vim.api.nvim_create_user_command('PeekClose', peek.close, {})
  vim.api.nvim_create_user_command('PeekToggle', toggle, {})
  
  -- Prevent peek from closing when switching buffers or closing files
  vim.api.nvim_create_autocmd({"BufWinLeave", "BufDelete", "BufWipeout"}, {
    pattern = "*.md",
    callback = function()
      -- Override the default close behavior
      return true
    end,
  })
end

return {
  {
    'toppair/peek.nvim',
    enabled = true,
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = config,
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    enabled = true,
    event = { 'VeryLazy' },
    main = 'render-markdown',
    name = 'render-markdown',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('render-markdown').setup()
      require('config.keymaps').setup_render_markdown()
    end,
  },
}
