return {
  {
    "stevearc/dressing.nvim",
    enabled = true,
    event = "VeryLazy",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    main = "ibl",
    opts = {
      indent = {
        char = "┊"
      },
    },
  },
}
