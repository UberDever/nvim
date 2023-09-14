local settings_ = require("uber.settings")
local mappings_ = require("uber.mappings")
local telescope_ = require("uber.telescope")
local treesitter_ = require("uber.treesitter")
local util_ = require("uber.util")
local lsp_ = require("uber.lsp")
local autocomplete_ = require("uber.autocomplete")
local debug_ = require("uber.debug")

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
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
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
    {
        -- Manage LSP servers from neovim
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- LSP Support
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                { 'hrsh7th/cmp-nvim-lsp' },
            },
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                { 'L3MON4D3/LuaSnip' },
            }
        },
    },
    { 'm4xshen/autoclose.nvim' },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { 'terrortylor/nvim-comment' },

    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp' },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" }
    },

    { 'declancm/maximize.nvim' },
    { 'folke/neodev.nvim' },
    { "cbochs/portal.nvim" },

    { 'mfussenegger/nvim-dap' },
    { "rcarriga/nvim-dap-ui" },

    -- {
    --     'vifm/vifm.vim',
    --     init = function(_)
    --         vim.g.loaded_netrw = false
    --         vim.g.loaded_netrwPlugin = false
    --         vim.g.loaded_netrwSettings = false
    --         vim.g.loaded_netrwFileHandlers = false
    --         vim.g.loaded_netrw_gitignore = false
    --         vim.g["vifm_replace_netrw"] = true
    --     end
    -- },
    { 'voldikss/vim-floaterm' },
    { 'ionide/Ionide-vim' },
}
local opts = {}
require("lazy").setup(plugins, opts)

settings_.setup()
mappings_.setup()
mappings_.telescope_setup()
mappings_.portal_setup()
mappings_.comment_setup()
mappings_.maximize_setup()

telescope_.setup()
treesitter_.setup()
autocomplete_.setup()
lsp_.setup()
debug_.setup()
util_.setup()
