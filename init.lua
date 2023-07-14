settings_ = require("uber.settings")
mappings_ = require("uber.mappings")
telescope_ = require("uber.telescope")
treesitter_ = require("uber.treesitter")
autoclose_ = require("uber.autoclose")
nvimtree_ = require("uber.nvimtree")
todocomments_ = require("uber.todo-comments")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    { "rebelot/kanagawa.nvim" },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
                event = "VeryLazy",
            },
        },
        config = function(_, _) vim.cmd([[TSUpdate]]) end
    },
    { 'm4xshen/autoclose.nvim' },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup(nvimtree_.config)
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    }
}
local opts = {}
require("lazy").setup(plugins, opts)

settings_.setup()
mappings_.setup()
telescope_.setup()
treesitter_.setup()
autoclose_.setup()
nvimtree_.setup()
todocomments_.setup()
