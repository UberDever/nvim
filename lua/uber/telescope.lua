local M = {}

function M.setup()
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>fp", "<cmd> Telescope find_files <CR>", opts)
    vim.keymap.set("n", "<leader>ff", "<cmd> Telescope git_files <CR>", opts)
    vim.keymap.set("n", "<leader>fs", "<cmd> Telescope live_grep <CR>", opts)

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
                    ["<C-S>"] = actions.select_horizontal,
                    ["<C-s>"] = actions.select_vertical,
                    ["<C-k>"] = actions.preview_scrolling_up,
                    ["<C-j>"] = actions.preview_scrolling_down,
                },
                i = {
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-k>"] = actions.preview_scrolling_up,
                    ["<C-j>"] = actions.preview_scrolling_down,
                },
            },
        },
    }
end

return M
