local M = {}

local autoclose_config = {
    keys = {
        ["("] = { escape = false, close = true, pair = "()", disabled_filetypes = {} },
        ["["] = { escape = false, close = true, pair = "[]", disabled_filetypes = {} },
        ["{"] = { escape = false, close = true, pair = "{}", disabled_filetypes = {} },

        [">"] = { escape = true, close = false, pair = "<>", disabled_filetypes = {} },
        [")"] = { escape = true, close = false, pair = "()", disabled_filetypes = {} },
        ["]"] = { escape = true, close = false, pair = "[]", disabled_filetypes = {} },
        ["}"] = { escape = true, close = false, pair = "{}", disabled_filetypes = {} },

        ['"'] = { escape = true, close = true, pair = '""', disabled_filetypes = {} },
        ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = {} },
        ["`"] = { escape = true, close = true, pair = "``", disabled_filetypes = {} },
    },
    options = {
        disabled_filetypes = { "text" },
        disable_when_touch = false,
        pair_spaces = false,
        auto_indent = true,
    },
}

function M.setup()
    require("autoclose").setup(autoclose_config)
    require("todo-comments").setup()

    local comment_config = {
        line_mapping = "<C-_><C-_>",
        operator_mapping = "<C-_>",
    }
    require('nvim_comment').setup(comment_config)
end

return M
