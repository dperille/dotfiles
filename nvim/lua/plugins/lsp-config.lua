return {
    -- mason-lspconfig uses mason to automatically ensure desired LSP servers are installed
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { 
                    "lua_ls", -- Lua
                    "ts_ls", -- TypeScript
                    -- "jdtls", -- Java (Eclipse)
                    "gopls", -- Golang
                    "pyright", -- Python
                },
                automatic_enable = false,
            })
        end
    },
    -- mason-nvim-dap uses mason to automatically ensure desired debug adapters are installed 
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "java-debug-adapter", "java-test" }
            })
        end
    },
    -- plugin to configure jdtls LSP
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap",
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig = require("lspconfig")

            -- set up Lua language server
            lspconfig.lua_ls.setup({
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

            -- set up Typescript language server
            lspconfig.ts_ls.setup({
                root_dir = lspconfig.util.root_pattern('.git'), -- Use .git folder as LSP root, since subpackage package.json will be too many
            })


            -- set up Golang language server
            lspconfig.gopls.setup({
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                },
            })

            -- set up Python language server
            lspconfig.pyright.setup({})
           
            -- Diagnostic messages
            vim.diagnostic.config({
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

            -- Vim motion for <Space> + c + h to show code documentation above the cursor
            vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
            -- Vim motion for <Space> + c + d to go to definition
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
            -- Vim motion for <Space> + c + r to go to references
            vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
            -- Vim motion for <Space> + c + a to display code action suggestions for diagnostics
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
            -- Vim motion for <Space> + c + R to rename code
            vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
        end
    }
}

