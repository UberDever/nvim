local M = {}

function M.setup()
    -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
    require('neodev').setup({ library = { plugins = { "nvim-dap-ui" }, types = true }, })

    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local default_on_attach = function(client, bufnr)
        -- Format on save
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd('BufWritePre', {
                callback = function()
                    vim.lsp.buf.format { async = false }
                end,
                buffer = bufnr
            })
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

    local lspconfig = require('lspconfig')
    local default_setup_server = function(server_name)
        lspconfig[server_name].setup {
            on_attach = default_on_attach,
            capabilities = lsp_capabilities
        }
    end

    local handlers = {
        default_setup_server,
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
                capabilities = lsp_capabilities,
                on_attach = default_on_attach,
                settings = { Lua = { diagnostics = { globals = { 'vim' } } } } }
        end,
        ["pylsp"] = function()
            lspconfig.pylsp.setup {
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
            }
        end,
        -- ["gopls"] = function()
        -- lspconfig.gopls.setup {
        --     cmd = { "gopls", "serve" },
        --     filetypes = { "go", "gomod" },
        --     root_dir = require('lspconfig/util').root_pattern("go.work", "go.mod", ".git"),
        --     capabilities = lsp_capabilities,
        --     on_attach = function(client, bufnr)
        --         default_on_attach(client, bufnr)
        --         vim.api.nvim_create_autocmd('BufWritePre', {
        --             buffer = bufnr,
        --             callback = function()
        --                 vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
        --             end,
        --         })
        --     end,
        --     settings = {
        --         gopls = {
        --             completeUnimported = true,
        --             usePlaceholders = true,
        --             analyses = {
        --                 unusedparams = true,
        --             },
        --             staticcheck = true,
        --         },
        --     },
        -- }
        -- end
    }

    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = {
            'lua_ls', 'clangd', 'cmake',
            -- 'gopls',
            'marksman', 'pylsp'
        },
        handlers = handlers,
    })

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
