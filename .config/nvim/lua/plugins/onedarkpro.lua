return {
  "olimorris/onedarkpro.nvim",
  enabled = true,
  lazy = false,
  name = "onedarkpro",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme onedark_dark")
  end,
}
