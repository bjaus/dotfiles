local opts = {
  disable_filetype = {
    'TelescopePrompt',
  },
}

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = opts,
}
