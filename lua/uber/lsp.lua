local M = {}

function M.setup()
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
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

            -- Format on save
            vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

            if client.supports_method('textDocument/documentHighlight') then
                -- Highlight symbol under cursor
                vim.cmd [[autocmd CursorHold  * lua vim.lsp.buf.document_highlight()]]
                vim.cmd [[autocmd CursorHoldI * lua vim.lsp.buf.document_highlight()]]
                vim.cmd [[autocmd CursorMoved * lua vim.lsp.buf.clear_references()]]
            end
        end
    })

    -- Save without formatting
    vim.api.nvim_create_user_command('SaveWithoutFormatting', ':noautocmd w', { nargs = 0 })

    -- vim.api.nvim_create_autocmd('InsertLeave', {
    --     callback = function(_)
    --         local config = { open = false, severity = vim.diagnostic.severity.ERROR }
    --         vim.diagnostic.setqflist(config)
    --     end,
    -- })

    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = {
            'lua_ls', 'clangd', 'cmake', 'gopls', 'marksman', 'pylsp'
        }
    })

    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('mason-lspconfig').setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = lsp_capabilities,
                -- handlers = handlers,
            })
        end,
    })

    -- Lua
    lspconfig.lua_ls.setup {
        capabilities = lsp_capabilities,
        settings = { Lua = { diagnostics = { globals = { 'vim' } } } } }

    -- Golang
    lspconfig.gopls.setup {
        cmd = { "gopls", "serve" },
        filetypes = { "go", "gomod" },
        root_dir = require('lspconfig/util').root_pattern("go.work", "go.mod", ".git"),
        capabilities = lsp_capabilities,
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
    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
            vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
        end
    })
end

return M
