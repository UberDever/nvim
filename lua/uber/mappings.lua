local M = {}

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

function M.setup()
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- Cut \n
    vim.keymap.set("n", "s", "mzJ`z", opts)
    -- Quit current window
    vim.keymap.set("n", "Q", ":q<CR>", opts)
    -- Save
    vim.keymap.set("n", "S", ":w<CR>", opts)
    -- Delete current buffer
    vim.keymap.set("n", "ZZ", ":bd<CR>", opts)
    -- Undo as uppercase U
    vim.keymap.set("n", "U", "<C-r>", opts)

    -- Window controls
    vim.keymap.set("n", "Ws", "<C-w>s", opts)
    vim.keymap.set("n", "WS", "<C-w>v", opts)
    vim.keymap.set("n", "<Tab>", "<C-w>w", opts)

    -- Tab controls
    -- vim.keymap.del("n", "<C-t>", opts)
    vim.keymap.set("n", "TT", ":tab sball<CR>", opts)
    vim.keymap.set("n", "LL", "gt", opts)
    vim.keymap.set("n", "HH", "gT", opts)
    vim.keymap.set("n", "<leader>t", ":tabnew %<CR> :bprev<CR>", opts)

    -- Buffer controls
    vim.keymap.set("n", "KK", "<cmd> bprev <CR>", {})
    vim.keymap.set("n", "JJ", "<cmd> bnext <CR>", {})
    -- vim.keymap.set("n", "<leader>p", ":ls<CR>:b ", {})
    vim.keymap.set("n", "<leader>b", "<cmd> Telescope buffers <CR>", {})

    -- Go back and forth jumplist
    vim.keymap.set("n", "<M-h>", "<C-o>", opts)
    vim.keymap.set("n", "<M-l>", "<C-i>", opts)

    -- Leap up and down 
    vim.keymap.set("n", "<M-j>", "<C-d>zz", opts)
    vim.keymap.set("n", "<M-k>", "<C-u>zz", opts)
    
    -- Shift selected text up and down
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
    
    -- Stay at middle line when searching
    vim.keymap.set("n", "n", "nzzzv", opts)
    vim.keymap.set("n", "N", "Nzzzv", opts)

    -- Keep yanked word in register
    vim.keymap.set("x", "<leader>p", "\"_dP", {})

    -- Use system clipboard
    vim.keymap.set("n", "<leader>y", "\"+y")
    vim.keymap.set("n", "<leader>Y", "\"+Y")
    vim.keymap.set("v", "<leader>y", "\"+y")

    -- Delete into void
    vim.keymap.set("n", "<leader>d", "\"_d")
    vim.keymap.set("v", "<leader>d", "\"_d")

    -- Replace currently selected word and occurences
    vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
end

return M
