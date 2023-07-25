local M = {}

function M.setup()
    local ok, telescope = pcall(require, "telescope")
    if not ok then
        print("Telescope not found :(")
        return
    end

    local actions = require("telescope.actions")

    telescope.setup {
        defaults = {
            prompt_prefix = " ",
            path_display = { "smart" },
            mappings = {
                n = {
                    ["<M-s>"] = actions.select_horizontal,
                    ["<M-d>"] = actions.select_vertical,
                    ["<M-q>"] = actions.delete_buffer,

                    ["<M-n>"] = actions.move_selection_next,
                    ["<M-p>"] = actions.move_selection_previous,
                    ["<M-k>"] = actions.preview_scrolling_up,
                    ["<M-j>"] = actions.preview_scrolling_down,
                },
                i = {
                    ["<M-s>"] = actions.select_horizontal,
                    ["<M-d>"] = actions.select_vertical,
                    ["<M-q>"] = actions.delete_buffer,

                    ["<M-n>"] = actions.move_selection_next,
                    ["<M-p>"] = actions.move_selection_previous,
                    ["<M-k>"] = actions.preview_scrolling_up,
                    ["<M-j>"] = actions.preview_scrolling_down,
                },
            },
        },
    }
end

return M
