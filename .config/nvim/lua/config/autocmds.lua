-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local util = require 'util'
local augroup = util.create_augroup
local autocmd = vim.api.nvim_create_autocmd

M = {}

vim.api.nvim_create_autocmd({ 'BufWritePre' }, { pattern = { '*.templ' }, callback = vim.lsp.buf.format })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

function M.setup_lsp_highlight(event)
  -- The following autocommands are used to highlight references of the
  -- word under the cursor when the cursor rests there for a little while.
  -- See `:help CursorHold` for information about when this is executed
  --
  -- When you move the cursor, the highlights will be cleared.
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
    autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
      end,
    })
  end
end

-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports-and-formatting
autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format { async = false }
  end,
})

-- Lua reload
local write_source = augroup 'ConfigWritePostReload'
autocmd({ 'BufWritePost' }, {
  group = write_source,
  pattern = {
    '*/nvim/lua/config/*.lua',
    '*/nvim/lua/util/*.lua',
  },
  callback = function()
    if not util.diag_error() then
      util.reload_lua()
    end
  end,
})

return M
