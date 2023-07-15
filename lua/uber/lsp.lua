local M = {}

function M.setup()
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
    end)

    lsp.extend_cmp()

    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls' },
        handlers = { lsp.default_setup },
    })

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', 'G', vim.lsp.buf.hover, opts)
end

return M
