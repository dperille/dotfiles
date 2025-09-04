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
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            local builtin = require("telescope.builtin")
            local fb_actions = require("telescope._extensions.file_browser.actions")
            local themes = require("telescope.themes")

            -- Utility to first use telescope to select directory, then execute the search action confined to that directory
            telescope.load_extension("file_browser")
            local function select_dir_then_search(telescope_action)
                -- Get the current buffer's directory (fallback to cwd if no file)
                local buf_dir = vim.fn.expand('%:p:h') -- Path, stopping at directory (head)
                if buf_dir == '' or not vim.fn.isdirectory(buf_dir) then
                    buf_dir = vim.fn.getcwd()
                end

                telescope.extensions.file_browser.file_browser({
                    path = buf_dir,
                    cwd_to_path = true, -- Launch from current path, not root dir
                    select_buffer = false,
                    hidden = false,
                    respect_gitignore = true,
                    -- Instead of default file browser behavior, open search task with selection instead
                    attach_mappings = function(prompt_bufnr, map)
                        actions.select_default:replace(function()
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            if selection and selection.cwd then
                                telescope_action({ cwd = selection.cwd })
                            end
                        end)

                        -- Enable directory navigation -- h to step out, l to step in
                        map("i", "<C-h>", fb_actions.goto_parent_dir)
                        map("n", "h", fb_actions.goto_parent_dir)
                        map("i", "<C-l>", function()
                            local selection = action_state.get_selected_entry()
                            if selection and vim.fn.isdirectory(selection.path) then
                                fb_actions.change_cwd(prompt_bufnr)
                            end
                        end)
                        map("n", "l", function()
                            local selection = action_state.get_selected_entry()
                            if selection and vim.fn.isdirectory(selection.path) then
                                fb_actions.change_cwd(prompt_bufnr)
                            end
                        end)

                        return true
                    end,
                })
            end

            -- Find by file name
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
            vim.keymap.set("n", "<leader>fif", function() select_dir_then_search(builtin.find_files) end,
                { desc = "[F]ind [I]n-directory [F]iles" })

            -- Live grep for contents
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
            vim.keymap.set("n", "<leader>fig", function() select_dir_then_search(builtin.live_grep) end,
                { desc = "[F]ind [I]n-directory by [G]rep" })

            -- Search for recent files
            vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })

            telescope.setup({
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    ["ui-select"] = {
                        -- Use cursor-centered list to display options
                        themes.get_cursor {}
                    },
                },
                defaults = {
                    -- Path display in file picker
                    path_display = { "smart" },

                    -- Show file path from root alongside code preview
                    dynamic_preview_title = true,
                    preview_title = function(_, bufnr)
                        local path = vim.api.nvim_buf_get_name(bufnr)
                        return vim.fn.fnamemodify(path, ":p")
                    end,

                    layout_config = {
                        horizontal = { width = 0.9, preview_cutoff = 120 },
                        vertical = { width = 0.8 },
                    },
                    file_ignore_patterns = { "node_modules/", ".git/", "/dist/", "/build/" },
                    selection_caret = "  ",

                    -- Cycling through file picker
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

            -- Actually enable the ui-select extension (above just sets settings) to use telescope for selections
            require("telescope").load_extension("ui-select")
        end,
    },
}
