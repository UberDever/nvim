local ok, telescope = pcall(require, "telescope")
if not ok then
    print("Telescope not found :(")
    return
end

local actions = require("telescope.actions")

telescope.setup{
    defaults = {
        prompt_prefix = " ",
        path_display = { "smart" },
        mappings = {
            n = {
                ["<C-S>"] = actions.select_horizontal,
                ["<C-s>"] = actions.select_vertical,
                ["<C-j>"] = actions.preview_scrolling_up,
                ["<C-k>"] = actions.preview_scrolling_down,
            },
            i = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.preview_scrolling_up,
                ["<C-k>"] = actions.preview_scrolling_down,
            },
        },
    },
}

