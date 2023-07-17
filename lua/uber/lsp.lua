local M = {}

function M.setup()
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', 'gi', vim.lsp.buf.hover, opts)
        end
    })

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
            })
        end,
    })
    lspconfig.lua_ls.setup { settings = { Lua = { diagnostics = { globals = { 'vim' } } } } }
end

return M
