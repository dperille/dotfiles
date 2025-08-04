-- Inject LSP diagnostics, enable formatters, code actions, etc.
return {
    {
        "jayp0521/mason-null-ls.nvim",
        config = function()
            require('mason-null-ls').setup({
                ensure_installed = {
                    'prettier', -- TS/JS formatter
                    'eslint_d', -- TS/JS linter
                    'stylua', -- Lua formatter
                    'gopls',
                    'gofumpt',
                    'golines',
                    'goimports_reviser',
                },
            })
        end
    },
    {
        "nvim-tools/none-ls.nvim",
        url = "git@github.com:nvimtools/none-ls.nvim.git",
        config = function()
            local null_ls = require("null-ls")
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                debug = true,
                sources = {
                    null_ls.builtins.formatting.gofumpt,
                    null_ls.builtins.formatting.goimports_reviser, -- goimports, but with more deterministic sorting
                    null_ls.builtins.formatting.golines, -- Try to shorten long lines
                },
                -- On attaching to none-ls, register autocmd to format on buffer pre-write
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end
                end,
            })
        end
    }
}
