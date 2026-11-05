-- Presents CLI tools (formatters, linters, etc.) as a single LSP
return {
    {
        "jayp0521/mason-null-ls.nvim",
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {
                    "prettier",           -- TS/JS formatter
                    "stylua",             -- Lua formatter
                    "gofumpt",            -- stricter gofmt
                    "golines",            -- Try to shorten long lines
                    "goimports",          -- Will actually remove unused imports
                    "goimports_reviser",  -- goimports, but more deterministic sorting
                    "ruff",               -- Python, removing unused imports
                    "black@25.1.0",       -- Python; pinned to match nira-data-pipeline's pre-commit
                    "google-java-format", -- Java
                },
            })
        end,
    },
    {
        "nvim-tools/none-ls.nvim",
        url = "git@github.com:nvimtools/none-ls.nvim.git",
        dependencies = { "nvimtools/none-ls-extras.nvim" },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                debug = true,
                sources = {
                    null_ls.builtins.formatting.prettier.with({
                        prefer_local = "node_modules/.bin",
                    }),
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
                    -- Use ruff only to remove unused imports (F401 rule); must come before black
                    require("none-ls.formatting.ruff").with({ extra_args = { "--select", "F401" } }),
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.google_java_format,
                },
                -- On attaching to none-ls, register autocmd to format on buffer pre-write
                -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
                -- on_attach = function(client, bufnr)
                --     if client.supports_method("textDocument/formatting") then
                --         vim.api.nvim_clear_autocmds({
                --             group = augroup,
                --             buffer = bufnr,
                --         })
                --         vim.api.nvim_create_autocmd("BufWritePre", {
                --             group = augroup,
                --             buffer = bufnr,
                --             callback = function()
                --                 vim.lsp.buf.format({ async = false })
                --             end,
                --         })
                --     end
                -- end,
            })
        end,
    },
}
