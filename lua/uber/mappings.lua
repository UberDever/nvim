local M = {}

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local map = vim.keymap.set

function M.setup()
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- Cut \n
    map("n", "s", "J", opts)
    -- Quit current window
    map("n", "Q", ":q<CR>", opts)
    -- Save
    map("n", "S", ":w<CR>", opts)
    -- Delete current buffer
    map("n", "ZZ", ":bd<CR>", opts)

    -- Window controls
    map("n", "Ws", "<C-w>s", opts)
    map("n", "WS", "<C-w>v", opts)
    map("n", "<Tab>", "<C-w>w", opts)

    -- Tab controls
    map("n", "TT", ":tab sball<CR>", opts)
    map("n", "LL", "gt", opts)
    map("n", "HH", "gT", opts)
    map("n", "<leader>t", ":tabnew %<CR> :bprev<CR>", opts)

    -- Buffer controls
    map("n", "KK", "<cmd> bprev <CR>", {})
    map("n", "JJ", "<cmd> bnext <CR>", {})
    -- map("n", "<leader>p", ":ls<CR>:b ", {})
    map("n", "<leader>p", "<cmd> Telescope buffers <CR>", {})

    -- Go back and forth jumplist
    map("n", "<M-h>", "<C-o>", opts)
    map("n", "<M-l>", "<C-i>", opts)

    -- Leap up and down 
    map("n", "<M-j>", "<C-d>", opts)
    map("n", "<M-k>", "<C-u>", opts)

    -- Telescope
    map("n", "<leader>fp", "<cmd> Telescope find_files <CR>", opts)
    map("n", "<leader>ff", "<cmd> Telescope git_files <CR>", opts)
    map("n", "<leader>fs", "<cmd> Telescope live_grep <CR>", opts)
    -- map("n", "<leader>fs", "<cmd> Telescope grep_string <CR>", opts)

    -- Nvim-tree
    map("n", "<leader>fm", "<cmd> NvimTreeFocus <CR>", opts)
end

return M
