-- Manual reload configuration
-- No automatic polling to preserve performance

-- Enable autoread so files CAN be reloaded when we manually check
vim.o.autoread = true

-- Manual reload keybindings
vim.keymap.set("n", "<leader>rr", ":checktime<CR>", { desc = "Reload buffer if changed" })
vim.keymap.set("n", "<leader>r!", ":e!<CR>", { desc = "Force reload buffer" })
vim.keymap.set("n", "<leader>ra", ":checktime<CR>:bufdo checktime<CR>", { desc = "Reload all buffers" })

-- Quick refresh with F5 (common refresh key)
vim.keymap.set("n", "<F5>", ":checktime<CR>", { desc = "Check for file changes" })

-- Optional: Show a message when a file is reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File reloaded from disk", vim.log.levels.INFO)
  end,
})