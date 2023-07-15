local M = {}

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

function M.setup()
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
    
    -- Basic movement
    vim.keymap.set("n", "J", "}", opts)
    vim.keymap.set("n", "K", "{", opts)
    vim.keymap.set("n", "L", "w", opts)
    vim.keymap.set("n", "H", "b", opts)
    vim.keymap.set("n", "<M-j>", "<C-d>zz", opts)
    vim.keymap.set("n", "<M-k>", "<C-u>zz", opts)

    vim.keymap.set("n", "gj", "G", opts)
    vim.keymap.set("n", "gk", "gg", opts)
    vim.keymap.set("n", "gl", "$", opts)
    vim.keymap.set("n", "gh", "^", opts)

    -- Save
    vim.keymap.set("n", "S", ":w<CR>", opts)
    -- Undo as uppercase U
    vim.keymap.set("n", "U", "<C-r>", opts)
    -- Cut \n
    vim.keymap.set("n", "Z", "mzJ`z", opts)
    -- Quit current window
    vim.keymap.set("n", "Q", ":q<CR>", opts)

    -- Windows, tabs, buffers
    vim.keymap.set("n", "<M-w>", "<C-w>w", opts)
    vim.keymap.set("n", "<M-s>", "<C-w>s", opts)
    vim.keymap.set("n", "<M-v>", "<C-w>v", opts)
    vim.keymap.set("n", "<M-t>", ":tabnew %<CR> :bprev<CR>", opts)
    vim.keymap.set("n", "<M-e>", ":tab sball<CR>", opts)
    vim.keymap.set("n", "<M-p>", "<cmd> bprev <CR>", opts)
    vim.keymap.set("n", "<M-n>", "<cmd> bnext <CR>", opts)
    vim.keymap.set("n", "<M-l>", "gt", opts)
    vim.keymap.set("n", "<M-h>", "gT", opts)
    vim.keymap.set("n", "<M-b>", "<cmd> Telescope buffers <CR>", {})

    -- Stay at middle line when searching
    vim.keymap.set("n", "n", "nzzzv", opts)
    vim.keymap.set("n", "N", "Nzzzv", opts)

    -- Go back and forth jumplist
    vim.keymap.set("n", "<M-.>", "<C-i>", opts)
    vim.keymap.set("n", "<M-,>", "<C-o>", opts)

    -- Clipboard stuff
    vim.keymap.set("x", "<C-p>", "\"_dP", {})
    vim.keymap.set("n", "<C-y>", "\"+y")
    vim.keymap.set("n", "<C-d>", "\"_d")

    -- Replace word under cursor
    vim.keymap.set("n", "<C-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
    
    -- VISUAL
    -- Shift selected text up and down
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

    -- Clipboard stuff
    vim.keymap.set("v", "<C-y>", "\"+y")
    vim.keymap.set("v", "<C-d>", "\"_d")
end

return M
