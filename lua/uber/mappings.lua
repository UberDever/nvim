local M = {}

local opts = { noremap = true, silent = true }

function M.setup()
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
    -- Basic intuition about combinations:
    -- Two key combinations - for very useful/coherent commands
    -- Shift - for basic vim movement + most useful commands
    -- Alt - for managing workspace (hence `meta` name)
    -- Control - for more sophisticated movement/less useful commands
    -- Space - for plugins and their stuff

    -- Help for symbol under cursor
    vim.keymap.set("n", "g?", "K", opts)

    -- Basic movement
    vim.keymap.set("n", "J", "}", opts)
    vim.keymap.set("n", "K", "{", opts)
    vim.keymap.set("n", "L", "w", opts)
    vim.keymap.set("n", "H", "b", opts)
    vim.keymap.set("n", "<C-j>", "<C-d>zz", opts)
    vim.keymap.set("n", "<C-k>", "<C-u>zz", opts)
    -- Go back and forth jumplist (use default ones)
    -- vim.keymap.set("n", "<C-.>", "<C-i>", opts)
    -- vim.keymap.set("n", "<C-,>", "<C-o>", opts)
    -- Go back and forth quickfix list (don't use it)
    -- vim.keymap.set("n", "<C-n>", ":cn<CR>", opts)
    -- vim.keymap.set("n", "<C-p>", ":cp<CR>", opts)

    -- Goto movements
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
    vim.keymap.set("n", "<M-j>", "<C-w>w", opts)
    vim.keymap.set("n", "<M-k>", "<C-w>W", opts)
    vim.keymap.set("n", "<M-s>", "<C-w>s", opts)
    vim.keymap.set("n", "<M-v>", "<C-w>v", opts)
    vim.keymap.set("n", "<M-t>", ":tabnew %<CR> :bprev<CR>", opts)
    vim.keymap.set("n", "<M-e>", ":tab sball<CR>", opts)
    vim.keymap.set("n", "<M-p>", "<cmd> bprev <CR>", opts)
    vim.keymap.set("n", "<M-n>", "<cmd> bnext <CR>", opts)
    vim.keymap.set("n", "<M-l>", "gt", opts)
    vim.keymap.set("n", "<M-h>", "gT", opts)
    vim.keymap.set("n", "<M-b>", "<cmd> Telescope buffers <CR>", {})
    vim.keymap.set("n", "<M-q>", "<cmd> bdelete <CR>", {})

    -- Stay at middle line when searching
    vim.keymap.set("n", "n", "nzzzv", opts)
    vim.keymap.set("n", "N", "Nzzzv", opts)

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
