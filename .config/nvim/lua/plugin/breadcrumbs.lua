return {
  "SmiteshP/nvim-navic",
  lazy = true,
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  init = function()
    vim.g.navic_silence = true
  end,
  config = function()
    local navic = require("nvim-navic")
    navic.setup({
      icons = {
        File = "󰈙 ",
        Module = " ",
        Namespace = "󰌗 ",
        Package = " ",
        Class = "󰌗 ",
        Method = "󰆧 ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = "󰕘",
        Interface = "󰕘",
        Function = "󰊕 ",
        Variable = "󰆧 ",
        Constant = "󰏿 ",
        String = " ",
        Number = "󰎠 ",
        Boolean = "◩ ",
        Array = "󰅪 ",
        Object = "󰅩 ",
        Key = "󰌋 ",
        Null = "󰟢 ",
        EnumMember = " ",
        Struct = "󰌗 ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
      },
      lsp = {
        auto_attach = false, -- We'll attach manually for better control
        preference = nil,
      },
      highlight = false,
      separator = " > ",
      depth_limit = 3, -- Limit depth for performance
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update = true, -- Update less frequently
    })

    -- Attach navic to LSP servers
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.documentSymbolProvider then
          navic.attach(client, args.buf)
        end
      end,
    })
  end,
}