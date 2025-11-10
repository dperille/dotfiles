-- Inject LSP diagnostics, enable formatters, code actions, etc.
return {
    {
        "jayp0521/mason-null-ls.nvim",
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {
                    "prettier",          -- TS/JS formatter
                    "stylua",            -- Lua formatter
                    "gofumpt",           -- stricter gofmt
                    "golines",           -- Try to shorten long lines
                    "goimports",         -- Will actually remove unused imports
                    "goimports_reviser", -- goimports, but more deterministic sorting
                    "black",             -- Python
                },
            })
        end,
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
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.stylua.with({
                        extra_args = {
                            "--column-width", "9999", -- don't reformat long lines
                            "--indent_type", "Spaces",
                            "--indent-width", "4",
                            "--call-parentheses", "Always", -- always use parentheses for function calls
                            "--quote-style", "ForceDouble",
                        },
                    }),
                    null_ls.builtins.formatting.gofumpt,
                    null_ls.builtins.formatting.goimports_reviser,
                    null_ls.builtins.formatting.goimports, -- must come second, since reviser doesn't remove unused
                    null_ls.builtins.formatting.golines,
                    null_ls.builtins.formatting.black,
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
        end,
    },
}
