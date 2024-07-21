return {
  "akinsho/toggleterm.nvim",
  enabled = true,
  version = "*",
  config = function()
    term = require("toggleterm")

    term.setup({
      direction = "horizontal", -- "vertical", "tab", "float"
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    })

    local trim_spaces = true
    vim.keymap.set("v", "<leader>tv", function()
      term.send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
    end)
    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal window" })
    vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Exit termina mode" })

  end,
}
