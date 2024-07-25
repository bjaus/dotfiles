local function _cmd_on_matched_go_file(cmd)
  local curfile = vim.fn.expand '%:p'
  local newfile = nil

  if curfile:match '_test%.go$' then
    newfile = curfile:gsub('_test%.go', '.go')
  else
    newfile = curfile:gsub('%.go$', '_test.go')
  end

  if newfile and vim.fn.filereadable(newfile) == 1 then
    vim.cmd(cmd .. ' ' .. newfile)
  else
    print('file not found ' .. newfile)
  end
end

return {
  switch_go_test_file = function()
    _cmd_on_matched_go_file 'edit'
  end,
  vsplit_go_test_file = function()
    _cmd_on_matched_go_file 'vsplit'
  end,
}
