local function setup_lsp()
    local capabilities = require('blink.cmp').get_lsp_capabilities({}, false)

    -- Lua
    vim.lsp.config("lua_ls", {
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
    vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        root_dir = function(bufnr, on_dir)
            local root = vim.fs.root(bufnr, { ".git" })
            on_dir(root)
        end,
    })


    -- Tailwind CSS
    vim.lsp.config("tailwindcss", {
        capabilities = capabilities,
        filetypes = {
            "html",
            "typescriptreact",
        },
    })


    -- Golang
    vim.lsp.config("gopls", {
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
    vim.lsp.config("basedpyright", {
        capabilities = capabilities,
        settings = {
            basedpyright = {
                analysis = {
                    typeCheckingMode = "standard", -- Less strict than default "recommended"

                    useLibraryCodeForTypes = true, -- If library doesn't provide type stubs, try to extract from the source
                    autoSearchPaths = true,
                    autoImportCompletions = true,
                    diagnosticMode = "openFilesOnly",
                },
            },
        },
    })

    -- Yaml
    vim.lsp.config("yamlls", {
        capabilities = capabilities,
    })

    vim.lsp.config("cssls", {
        capabilities = capabilities,
        filetypes = { "css", "scss" },
    })

    vim.lsp.enable({
        "lua_ls",
        "ts_ls",
        "tailwindcss",
        "cssls",
        "gopls",
        "basedpyright",
        "yamlls",
    })
end

return {
    -- mason-lspconfig uses mason to automatically ensure desired LSP servers are installed
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",       -- Lua
                    "ts_ls",        -- TypeScript
                    -- "jdtls",   -- Java (Eclipse)
                    "gopls",        -- Golang
                    "basedpyright", -- Python
                    "yamlls",       -- Yaml
                    "tailwindcss",  -- Tailwind
                    "cssls",        -- CSS
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
            -- Restart LSP clients for current buffer (forces servers to re-read files
            -- edited on disk by external tools, e.g. Claude Code, that nvim's file
            -- watcher missed)
            vim.keymap.set("n", "<leader>cR", "<cmd>lsp restart<cr>", { desc = "[C]ode [R]estart LSP" })
        end
    }
}
