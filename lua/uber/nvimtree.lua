local M = {}

function M.setup()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
end

M.config = {
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    on_attach = require("uber.mappings").nvimtree_mappings,
}

return M
