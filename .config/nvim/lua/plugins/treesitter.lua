return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  build = ":TSUpdate",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    local tsautotag = require("nvim-ts-autotag")

    treesitter.setup({
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "css",
        "csv",
        "dart",
        "dockerfile",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "graphql",
        "html",
        "http",
        "javascript",
        "jq",
        "json",
        "jsonc",
        "jsonnet",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "nginx",
        "php",
        "printf",
        "proto",
        "python",
        "query",
        "requirements",
        "rust",
        "scala",
        "sql",
        "svelte",
        "swift",
        "thrift",
        "tsv",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      },
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { enable = true },
      autotag = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    tsautotag.setup({
      opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
    })

    vim.keymap.set("n", "<leader>it", "<cmd>InspectTree<CR>", { desc = "Inspect AST" })
  end,
}
