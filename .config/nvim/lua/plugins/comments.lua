return {
  {
    "numToStr/Comment.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      -- import comment plugin safely
      local comment = require("Comment")

      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      -- enable comment
      comment.setup({
        -- for commenting tsx, jsx, svelte, html files
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    enabled = true,
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local todo = require("todo-comments")

      vim.keymap.set("n", "]t", function()
        todo.jump_next()
      end, { desc = "Next todo comment" })
      vim.keymap.set("n", "[t", function()
        todo.jump_prev()
      end, { desc = "Previous todo comment" })

      todo.setup()
    end,
  },
}
