return {
  "nvim-treesitter/nvim-treesitter",
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

    treesitter.setup({
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
        -- "protobuf",
        -- "todo",
        -- "wasm",
        -- "zsh",
      },
      sync_install = false,
      highlight = { enable = true },
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

    vim.keymap.set("n", "<leader>it", "<cmd>InspectTree<CR>", { desc = "Inspect AST" })
  end,
}
