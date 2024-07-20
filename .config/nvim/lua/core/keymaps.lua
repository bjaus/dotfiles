vim.g.mapleader = ";"
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to the left split window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the bottom split window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the top split window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the right split window" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal size" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split window" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab"})
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
