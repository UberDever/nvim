local M = {}

local opts = { noremap = true, silent = true }

M.lsp_mappings = function(args)
    -- local bufnr = args.buf
    -- local client = vim.lsp.get_client_by_id(args.data.client_id)
    vim.keymap.set('n', '<leader>j', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>d', '<cmd> Telescope lsp_definitions <CR>', opts)
    vim.keymap.set('n', '<leader>i', '<cmd> Telescope lsp_implementations <CR>', opts)
    vim.keymap.set('n', '<leader>r', '<cmd> Telescope lsp_references <CR>', opts)
    vim.keymap.set('n', '<leader>t', '<cmd> Telescope lsp_type_definitions <CR>', opts)
    vim.keymap.set('n', '<leader>s', '<cmd> Telescope lsp_document_symbols <CR>', opts)
    vim.keymap.set('n', '<leader>a', '<cmd> Telescope diagnostics <CR>', opts)
    vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>p', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>c', vim.lsp.buf.rename, opts)
end

M.portal_setup = function()
    -- Go back and forth jumplist (Through portal)
    vim.keymap.set("n", "<C-h>", "<cmd>Portal jumplist backward<CR>", opts)
    vim.keymap.set("n", "<C-l>", "<cmd>Portal jumplist forward<CR>", opts)
end

M.comment_setup = function()
    local comment_config = {
        line_mapping = "<C-_><C-_>",
        operator_mapping = "<C-_>",
    }
    require('nvim_comment').setup(comment_config)
end

M.maximize_setup = function()
    local maximize = require('maximize')
    maximize.setup()
    vim.keymap.set('n', '<M-w>', maximize.toggle, { noremap = true, silent = true })
end

M.nvimtree_setup = function()
    vim.keymap.set("n", "<Tab>", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true })
end

M.nvimtree_mappings = function(bufnr)
    local api = require "nvim-tree.api"

    local function options(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)
    -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, options('Help'))
    vim.keymap.set('n', 'J', api.tree.collapse_all, options('Collapse all'))
    vim.keymap.del('n', '<Tab>', options("Unmap"))
    vim.keymap.set('n', '=', api.tree.change_root_to_node, options('CD'))
end

M.telescope_setup = function()
    local find_git_repo = function()
        local dirs = vim.fs.find('.git', {
            upward = true,
            stop = vim.loop.os_homedir(),
            path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
        })
        local dir = vim.fn.fnamemodify(dirs[0], ":p:h")
        return #dirs ~= 0, dir
    end

    vim.keymap.set("n", "<leader>fp", "<cmd> Telescope find_files <CR>", opts)
    vim.keymap.set("n", "<leader>ff", function()
        local builtin = require("telescope.builtin")
        local utils = require("telescope.utils")
        local found, dir = find_git_repo()
        if found then
            builtin.find_files({ cwd = dir })
        end
    end)
    vim.keymap.set("n", "<leader>fc", function()
        local builtin = require("telescope.builtin")
        local utils = require("telescope.utils")
        builtin.find_files({ cwd = utils.buffer_dir() })
    end)

    vim.keymap.set("n", "<leader>gp", "<cmd> Telescope live_grep <CR>", opts)
    vim.keymap.set("n", "<leader>gf", function()
        local builtin = require("telescope.builtin")
        local utils = require("telescope.utils")
        local found, dir = find_git_repo()
        if found then
            builtin.live_grep({ cwd = dir })
        end
    end)
    vim.keymap.set("n", "<leader>gc", function()
        local builtin = require("telescope.builtin")
        local utils = require("telescope.utils")
        builtin.live_grep({ cwd = utils.buffer_dir() })
    end)
end

function M.setup()
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
    -- Basic intuition about combinations:
    -- Less mnemonics => more accessibility
    -- Fundamental vim motions are preserved
    -- Shift - for basic vim movement + most useful commands
    -- Alt - for managing workspace (hence `meta` name)
    -- Control - for more sophisticated movement/less useful commands
    -- Space - for plugins and their stuff

    -- Help for symbol under cursor
    vim.keymap.set("n", "<leader>?", "K", opts)

    -- Basic movement
    vim.keymap.set("n", "J", "}", opts)
    vim.keymap.set("n", "K", "{", opts)
    vim.keymap.set("n", "L", "w", opts)
    vim.keymap.set("n", "H", "b", opts)
    vim.keymap.set("n", "<C-j>", "<C-d>zz", opts)
    vim.keymap.set("n", "<C-k>", "<C-u>zz", opts)


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
    vim.keymap.set("n", "<M-s>", "<C-w>s", opts)
    vim.keymap.set("n", "<M-d>", "<C-w>v", opts)
    vim.keymap.set("n", "<M-f>", ":tabnew %<CR> :bprev<CR>", opts)
    vim.keymap.set("n", "<M-w>", ":tab sball<CR>", opts)
    vim.keymap.set("n", "<M-n>", "<C-w>w", opts)
    vim.keymap.set("n", "<M-p>", "<C-w>W", opts)
    vim.keymap.set("n", "<M-k>", "<cmd> bprev <CR>", opts)
    vim.keymap.set("n", "<M-j>", "<cmd> bnext <CR>", opts)
    vim.keymap.set("n", "<M-l>", "gt", opts)
    vim.keymap.set("n", "<M-h>", "gT", opts)
    vim.keymap.set("n", "<M-g>", "<cmd> Telescope buffers <CR>", {})
    vim.keymap.set("n", "<M-q>", "<cmd> bp|bd # <CR>", {})

    -- Stay at middle line when searching
    vim.keymap.set("n", "n", "nzzzv", opts)
    vim.keymap.set("n", "N", "Nzzzv", opts)

    -- Clipboard stuff
    vim.keymap.set("x", "<M-v>", "\"_dP")
    vim.keymap.set("n", "<M-v>", "\"*p")
    vim.keymap.set("n", "<M-c>", "\"*y")
    vim.keymap.set("n", "<M-x>", "\"_d")

    -- Replace word under cursor
    vim.keymap.set("n", "<C-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

    -- VISUAL

    -- Shift selected text up and down
    -- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
    -- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

    -- Clipboard stuff
    vim.keymap.set("v", "<M-c>", "\"*y")
    vim.keymap.set("v", "<M-v>", "\"*p")
    vim.keymap.set("v", "<M-x>", "\"_d")

    vim.keymap.set("v", "gj", "G", opts)
    vim.keymap.set("v", "gk", "gg", opts)
    vim.keymap.set("v", "gl", "$", opts)
    vim.keymap.set("v", "gh", "^", opts)
end

return M
