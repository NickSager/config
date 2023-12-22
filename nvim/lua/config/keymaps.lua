-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Screen Down, Center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Screen Up, Center" })
vim.keymap.set("n", "n", "nzz", { desc = "Find Next, Center" })
-- vim.keymap.set('n', '<leader>fw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace All Word' })

-- Move Lines
-- TODO: Not working with A or M
-- vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
-- vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Function that toggles backround between light and dark
-- for themes like 'gruvbox' or 'catppuccin' that include both
local Util = require("lazyvim.util")
vim.keymap.set("n", "<leader>ub", function() Util.toggle("background", false, {"light", "dark"}) end, { desc = "Toggle Background" })
