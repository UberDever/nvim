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

                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-k>"] = actions.preview_scrolling_up,
                    ["<C-j>"] = actions.preview_scrolling_down,
                },
                i = {
                    ["<M-s>"] = actions.select_horizontal,
                    ["<M-d>"] = actions.select_vertical,
                    ["<M-q>"] = actions.delete_buffer,

                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-k>"] = actions.preview_scrolling_up,
                    ["<C-j>"] = actions.preview_scrolling_down,
                },
            },
        },
    }

    telescope.load_extension("recent_files")
end

return M
