local M = {}

M.setup = function(mappings)
    require("oil").setup({
        columns = {
            "icon",
            "permissions",
            "size",
            "mtime",
        },
        keymaps = mappings,
        use_default_keymaps = false,
    })
    vim.api.nvim_create_user_command('Ex', 'Oil', {})
end

return M
