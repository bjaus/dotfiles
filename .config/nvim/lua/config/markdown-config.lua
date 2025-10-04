-- Markdown-specific configuration and keymaps

local M = {}

function M.setup()
  -- Markdown-specific settings
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      -- Local settings for markdown files
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.opt_local.spell = true
      vim.opt_local.spelllang = "en_us"
      vim.opt_local.conceallevel = 2
      vim.opt_local.textwidth = 0  -- Disable automatic line breaking
      vim.opt_local.formatoptions:remove('t')  -- Remove auto-wrap text using textwidth
      vim.opt_local.formatoptions:remove('a')  -- Remove automatic paragraph formatting
      
      -- Enable folding by headers using markdown syntax
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt_local.foldlevel = 99  -- Start with all folds open
      vim.opt_local.foldenable = true  -- Enable folding
      vim.opt_local.foldtext = "v:lua.vim.treesitter.foldtext()"
      
      -- Local keymaps for markdown
      local opts = { buffer = true, noremap = true, silent = true }
      
      -- Folding keymaps
      vim.keymap.set('n', 'za', 'za', opts)  -- Toggle fold
      vim.keymap.set('n', 'zR', 'zR', opts)  -- Open all folds
      vim.keymap.set('n', 'zM', 'zM', opts)  -- Close all folds
      vim.keymap.set('n', 'zo', 'zo', opts)  -- Open fold
      vim.keymap.set('n', 'zc', 'zc', opts)  -- Close fold
      vim.keymap.set('n', 'zj', 'zj', opts)  -- Next fold
      vim.keymap.set('n', 'zk', 'zk', opts)  -- Previous fold
      
      -- Navigation keymaps
      vim.keymap.set('n', '<Tab>', ':call search("^#\\+ ", "")<CR>', opts)
      vim.keymap.set('n', '<S-Tab>', ':call search("^#\\+ ", "b")<CR>', opts)
      
      -- Quick jumps to specific header levels
      vim.keymap.set('n', 'g1', '/^# <CR>', opts)
      vim.keymap.set('n', 'g2', '/^## <CR>', opts)
      vim.keymap.set('n', 'g3', '/^### <CR>', opts)
      vim.keymap.set('n', 'g4', '/^#### <CR>', opts)
      
      -- Toggle checkboxes
      vim.keymap.set('n', '<leader>mc', ':s/\\[ \\]/[x]/e<CR>:noh<CR>', opts)
      vim.keymap.set('n', '<leader>mu', ':s/\\[x\\]/[ ]/e<CR>:noh<CR>', opts)
      
      -- Insert mode helpers
      vim.keymap.set('i', ',,', '<Esc>A<CR><CR>', opts) -- Quick new paragraph
      vim.keymap.set('i', '..', '<Esc>A  ', opts) -- Add two spaces for line break
      
      -- Create links
      vim.keymap.set('v', '<leader>ml', 'c[<C-r>"]()<Esc>i', opts)
      
      -- Bold and italic
      vim.keymap.set('v', '<leader>mb', 'c**<C-r>"**<Esc>', opts)
      vim.keymap.set('v', '<leader>mi', 'c_<C-r>"_<Esc>', opts)
      
      -- Code blocks
      vim.keymap.set('n', '<leader>m`', 'i```<CR>```<Esc>O', opts)
      vim.keymap.set('v', '<leader>m`', 'c```<CR><C-r>"```<Esc>', opts)
    end,
  })

  -- Create a command to generate a TOC manually
  vim.api.nvim_create_user_command('MarkdownTOC', function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local toc = { "## Table of Contents", "" }
    
    for i, line in ipairs(lines) do
      local level, title = line:match("^(#+)%s+(.+)$")
      if level and title then
        local indent = string.rep("  ", #level - 1)
        local link = title:lower():gsub(" ", "-"):gsub("[^%w%-]", "")
        table.insert(toc, string.format("%s- [%s](#%s)", indent, title, link))
      end
    end
    
    -- Insert at cursor position
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, toc)
  end, {})

  -- Create a floating window with TOC
  vim.api.nvim_create_user_command('MarkdownFloat', function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local toc = {}
    local line_numbers = {}
    
    for i, line in ipairs(lines) do
      local level, title = line:match("^(#+)%s+(.+)$")
      if level and title then
        local indent = string.rep("  ", #level - 1)
        table.insert(toc, string.format("%s%s", indent, title))
        table.insert(line_numbers, i)
      end
    end
    
    if #toc == 0 then
      vim.notify("No headers found in document", vim.log.levels.WARN)
      return
    end
    
    -- Create floating window
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, toc)
    
    local width = 60
    local height = math.min(#toc, 20)
    
    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      col = vim.o.columns - width - 2,
      row = 2,
      border = "rounded",
      title = " Table of Contents ",
      title_pos = "center",
    })
    
    -- Set up keymaps for the floating window
    vim.keymap.set('n', '<CR>', function()
      local idx = vim.api.nvim_win_get_cursor(win)[1]
      vim.api.nvim_win_close(win, true)
      vim.api.nvim_win_set_cursor(0, {line_numbers[idx], 0})
    end, { buffer = buf })
    
    vim.keymap.set('n', 'q', function()
      vim.api.nvim_win_close(win, true)
    end, { buffer = buf })
    
    vim.keymap.set('n', '<Esc>', function()
      vim.api.nvim_win_close(win, true)
    end, { buffer = buf })
  end, {})
end

return M