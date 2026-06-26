local function setup_lsp()
    local lspconfig = require('lspconfig')
    local capabilities = require('blink.cmp').get_lsp_capabilities({}, false)

    -- Lua
    lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    -- Register that "require" and "vim" are special global variables, to avoid warnings from language server
                    globals = {
                        'vim',
                        'require',
                    },
                },
            },
        },
    })

    -- Typescript
    lspconfig.ts_ls.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('.git'), -- Use .git folder as LSP root, since subpackage package.json will be too many
    })


    -- Tailwind CSS
    lspconfig.tailwindcss.setup({
        filetypes = {
            "html",
            "typescriptreact",
        },
    })


    -- Golang
    lspconfig.gopls.setup({
        capabilities = capabilities,
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = false,
                analyses = {
                    unusedparams = true,
                },
            },
        },
    })

    -- Python
    lspconfig.pyright.setup({
        capabilities = capabilities,
    })

    -- Yaml
    lspconfig.yamlls.setup({
        capabilities = capabilities,
    })
end

return {
    -- mason-lspconfig uses mason to automatically ensure desired LSP servers are installed
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",      -- Lua
                    "ts_ls",       -- TypeScript
                    -- "jdtls",   -- Java (Eclipse)
                    "gopls",       -- Golang
                    "pyright",     -- Python
                    "yamlls",      -- Yaml
                    "tailwindcss", -- Tailwind
                },
                automatic_enable = false,
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            setup_lsp()

            -- Diagnostic messages
            vim.diagnostic.config({
                float = {
                    source = "if_many",
                    border = "rounded",
                },
                virtual_text = {
                    enabled = true, -- Inline diagnostic messages,
                    spacing = 4, -- Spacing between text and virtual text
                    source = "if_many",
                    prefix = "●", -- Prefix for virtual text

                },
                underline = true,
                update_in_insert = false, -- update diagnostics while inserting
                severity_sort = true,
            })
            -- Jump prev/next diagnostics with float window
            vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
            vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
            -- Show documentation
            vim.keymap.set("n", "<leader>ch", function() vim.lsp.buf.hover({ border = "rounded" }) end,
                { desc = "[C]ode [H]over Documentation" })
            -- Go to definition
            vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, { desc = "Goto [D]efinition" })
            -- Show references
            -- NOTE: won't work when "git" is anywhere on file path
            -- https://github.com/nvim-telescope/telescope.nvim/issues/3437
            vim.keymap.set("n", "<leader>r", require("telescope.builtin").lsp_references,
                { desc = "Code [R]eferences" })
            vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations,
                { desc = "[C]ode Show [I]mplementations" })
            -- Code actions
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
            -- Rename
            vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
        end
    }
}
