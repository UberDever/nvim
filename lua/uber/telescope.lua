local M = {}

function M.setup()
    local opts = { noremap = true, silent = true }
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


    vim.keymap.set("n", "<leader>sp", "<cmd> Telescope live_grep <CR>", opts)
    vim.keymap.set("n", "<leader>sf", function()
        local builtin = require("telescope.builtin")
        local utils = require("telescope.utils")
        local found, dir = find_git_repo()
        if found then
            builtin.live_grep({ cwd = dir })
        end
    end)
    vim.keymap.set("n", "<leader>sc", function()
        local builtin = require("telescope.builtin")
        local utils = require("telescope.utils")
        builtin.live_grep({ cwd = utils.buffer_dir() })
    end)

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
