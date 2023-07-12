local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "Ws", "<C-w>s", opts)
map("n", "WS", "<C-w>v", opts)
map("n", "<Tab>", "<C-w>w", opts)

map("n", "LL", "gt", opts)
map("n", "HH", "gT", opts)

map("n", "<M-j>", "<C-d>", opts)
map("n", "<M-k>", "<C-u>", opts)

-- Telescope
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", opts)
map("n", "<leader>fp", "<cmd> Telescope git_files <CR>", opts)
map("n", "<leader>fs", "<cmd> Telescope live_grep <CR>", opts)

