return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      injected_languages = true,
      highlight = { "Function", "Label" },
      priority = 500,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "lspinfo",
        "checkhealth",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
      },
    },
  },
}