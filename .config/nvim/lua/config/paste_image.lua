local function paste_image()
  local filename = os.date 'screenshot-%Y%m%d-%H%M%S.png'
  local dir = vim.fn.expand '~/.local/share/nvim-markdown-images'
  local filepath = dir .. '/' .. filename

  vim.fn.mkdir(dir, 'p')

  local cmd = 'pngpaste ' .. filepath .. ' 2>&1'
  print('Running command: ' .. cmd)

  local handle = io.popen(cmd)
  if not handle then
    print '❌ Failed to run pngpaste.'
    return
  end

  local output = handle:read '*a'
  handle:close()

  if vim.fn.filereadable(filepath) == 1 then
    local markdown_link = string.format('![](%s)', filepath)
    vim.api.nvim_put({ markdown_link }, 'l', true, true)
    print('📸 Pasted image to ' .. filepath)
  else
    print('❌ pngpaste output: ' .. output)
    print '❌ Failed to paste image. Is there an image in the clipboard?'
  end
end

return {
  paste_image = paste_image,
}
