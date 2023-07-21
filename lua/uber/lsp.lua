local M = {}

function M.setup()
    -- Save without formatting
    vim.api.nvim_create_user_command('SaveWithoutFormatting', ':noautocmd w', { nargs = 0 })

    -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
    require('neodev').setup({ library = { plugins = { "nvim-dap-ui" }, types = true }, })

    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local default_on_attach = function(client, bufnr)
        -- Format on save
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd('BufWritePre', {
                callback = function()
                    vim.lsp.buf.format()
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
            vim.api.nvim_create_autocmd('CursorHold', {
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
        ["gopls"] = function()
            lspconfig.gopls.setup {
                cmd = { "gopls", "serve" },
                filetypes = { "go", "gomod" },
                root_dir = require('lspconfig/util').root_pattern("go.work", "go.mod", ".git"),
                capabilities = lsp_capabilities,
                on_attach = function(client, bufnr)
                    default_on_attach(client, bufnr)
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
                        end,
                    })
                end,
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            }
        end
    }

    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = {
            'lua_ls', 'clangd', 'cmake', 'gopls', 'marksman', 'pylsp'
        },
        handlers = handlers,
    })

    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gg', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gd', '<cmd> Telescope lsp_definitions <CR>', opts)
            vim.keymap.set('n', 'gi', '<cmd> Telescope lsp_implementations <CR>', opts)
            vim.keymap.set('n', 'gr', '<cmd> Telescope lsp_references <CR>', opts)
            vim.keymap.set('n', 'gt', '<cmd> Telescope lsp_type_definitions <CR>', opts)
            vim.keymap.set('n', 'ga', '<cmd> Telescope lsp_document_symbols <CR>', opts)
            vim.keymap.set('n', 'ge', '<cmd> Telescope diagnostics <CR>', opts)
            vim.keymap.set('n', 'gn', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', 'gc', vim.lsp.buf.rename, opts)
        end
    })
end

return M
