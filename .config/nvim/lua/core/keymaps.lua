vim.g.mapleader = ";"
vim.g.maplocalleader = ","

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to the left split window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the bottom split window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the top split window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the right split window" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal size" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split window" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab"})
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
