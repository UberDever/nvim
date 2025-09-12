-- https://github.com/martinsione/dotfiles/blob/main/src/.config/nvim/lua/plugins/lsp.lua
local M = {}

function M.setup()
    -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
    require('neodev').setup({ library = { plugins = { "nvim-dap-ui" }, types = true }, })

    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local default_on_attach = function(client, bufnr)
        -- Format on save
        if client.server_capabilities.documentFormattingProvider then
            if client.name ~= "clangd" then
                vim.api.nvim_create_autocmd('BufWritePre', {
                    callback = function()
                        vim.lsp.buf.format { async = false }
                    end,
                    buffer = bufnr
                })
            else
                vim.api.nvim_create_autocmd('BufWritePost', {
                    callback = function(args)
                        local cwd = vim.fn.expand("~") .. "/engine/"
                        vim.cmd("silent !git-clang-format-18 --force -- " .. args.file, {})
                    end,
                    buffer = bufnr
                })
            end
        end

        if client.server_capabilities.documentHighlightProvider then
            -- Highlight symbol under cursor
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                callback = function()
                    vim.lsp.buf.document_highlight()
                end,
                buffer = bufnr
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                callback = function()
                    vim.lsp.buf.clear_references()
                end,
                buffer = bufnr
            })
        end
    end

    require('mason').setup()
    require('lspconfig')
    vim.lsp.config('lua_ls', {
        capabilities = lsp_capabilities,
        on_attach = default_on_attach,
        settings = {
            Lua = {
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true), -- Make server aware of Neovim runtime
                },
            }
        }
    })
    vim.lsp.config('pylsp', {
        capabilities = lsp_capabilities,
        on_attach = default_on_attach,
        settings = {
            pylsp = {
                plugins = {
                    pylint = {
                        enabled = true,
                        args = {}
                    },
                    autopep8 = { enabled = false, },
                    black = { enabled = true, }
                }
            }
        }
    })
    vim.lsp.config('gopls', {
        capabilities = lsp_capabilities,
        on_attach = default_on_attach,
        settings = {
            gopls = {
                -- Example: Enable all inlay hints for gopls
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true, -- Example: Also enable constant value hints
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
                -- Example: Add build tags
                -- buildFlags = { "-tags=e2e,integration" },
                -- Add other gopls specific settings here
            },
        },
        -- Example: Add a custom on_attach specifically for gopls
        -- on_attach = function(client, bufnr)
        --   print("Attaching gopls with custom settings!")
        --   -- Add gopls-specific keymaps or logic here
        -- end,
    })

    vim.lsp.enable('clangd')
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('pylsp')
    vim.lsp.enable('gopls')
    vim.lsp.enable('marksman')

    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(args)
            require("uber/mappings").lsp_mappings(args)
        end
    })

    require('treesitter-context').setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    }
end

return M
