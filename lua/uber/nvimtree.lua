local M = {}

function M.setup()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.keymap.set("n", "<leader>tt", ":NvimTreeFindFileToggle<CR>", {noremap = true, silent = true})
end

function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', 'J', api.tree.collapse_all, opts('Collapse all'))
    vim.keymap.del('n', '<Tab>', opts("Unmap"))
    -- vim.keymap.del('n', '<C-f>', opts("Unmap"))
    vim.keymap.set('n', '=', api.tree.change_root_to_node, opts('CD'))
end

M.config = {
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    on_attach = my_on_attach,
}

return M
