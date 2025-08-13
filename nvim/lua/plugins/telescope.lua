return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            -- general purpose plugin used to build user interfaces in neovim plugins
            "nvim-lua/plenary.nvim",
            -- gives fzf-style fuzzy searching
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            -- makes telescope the backend for Nvim's builtin ui selection/inputs
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")

            -- Find by file name
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
            -- Live grep for contents
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
            -- Search for recent files
            vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })

            require("telescope").setup({
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
                defaults = {
                    path_display = { "smart" },
                    layout_config = {
                        horizontal = { width = 0.9, preview_cutoff = 120 },
                        vertical = { width = 0.8 },
                    },
                    file_ignore_patterns = { "node_modules", ".git/", "dist", "build" },
                    selection_caret = "  ",
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        },
                        n = {
                            ["<esc>"] = actions.close,
                            ["j"] = actions.move_selection_next,
                            ["k"] = actions.move_selection_previous,
                        },
                    },
                },
            })
        end,
    },
}
