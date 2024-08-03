local config = function()
  require('lspkind').init({
    mode = 'symbol_text',
  })
end

return {
  'onsails/lspkind-nvim',
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = config,
}
