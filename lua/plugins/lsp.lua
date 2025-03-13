return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require 'lspconfig'
            local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

            -- Настраиваем LSP-серверы
            lspconfig.clangd.setup { capabilities = capabilities, cmd = { "clangd", "--fallback-style=Microsoft", "--compile-commands-dir=." } } -- C/C++
            lspconfig.lua_ls.setup { capabilities = capabilities }                                                                               -- Lua
            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format()
            end, { desc = "Форматирование кода", noremap = true, silent = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function()
                    vim.lsp.buf.format()
                end
            })
        end
    }
}
