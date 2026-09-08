return {
    {
        -- Gitsigns for in-buffer git diff viewing, git blame, etc -- for regular editing
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")

            gitsigns.setup({
                word_diff = false, -- Whether to highglight individual changes within line
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 1000,
                    ignore_whitespace = false,
                    use_focus = true,
                },
                update_debounce = 100,
                max_file_length = 40000,
            })

            -- Gitsigns
            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk_inline<CR>", { desc = "[G]it [P]review Hunk" })
            vim.keymap.set("n", "<leader>gu", ":Gitsigns reset_hunk<CR>", { desc = "[G]it [U]ndo Hunk" })
            vim.keymap.set("n", "]g",
                function()
                    gitsigns.nav_hunk("next", { wrap = true, preview = true, greedy = false })
                end,
                { desc = "[G]it [N]ext Hunk" })
            vim.keymap.set("n", "[g",
                function()
                    gitsigns.nav_hunk("prev", { wrap = true, preview = true, greedy = false })
                end,
                { desc = "[G]it [N]ext Hunk" })

            -- Telescope git commands
            vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", { desc = "[G]it [S]tatus" })     -- <Tab> to stage/unstage
            vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "[G]it [B]ranches" }) -- <CR> to checkout, <C-y> to merge
            vim.keymap.set("n", "<leader>gm", ":Telescope git_bcommits<CR>",
                { desc = "[G]it co[M]mits for current buffer" })
        end,
    },
    {
        -- Diffviewer for whole-changeset review/staging
        "sindrets/diffview.nvim",
        config = function()
            local actions = require("diffview.actions")

            require("diffview").setup({
                watch_index = true,      -- Update views and index buffers when the git index changes.
                enhanced_diff_hl = true, -- Highlight only word/chars, not whole line
                keymaps = {
                    disable_defaults = true,
                    view = {
                        -- Active in diff buffers
                        { "n", "<C-j>",      actions.select_next_entry, { desc = "Open the diff for the next file" } },
                        { "n", "<C-k>",      actions.select_prev_entry, { desc = "Open the diff for the previous file" } },

                        { "n", "<leader>et", actions.toggle_files,      { desc = "Toggle the file panel" } },
                        { "n", "<leader>ef", actions.focus_files,       { desc = "Focus the file panel" } },
                    },
                    file_panel = {
                        -- Navigation
                        { "n", "j",     actions.next_entry,         { desc = "Next file" } },
                        { "n", "<C-j>", actions.select_next_entry,  { desc = "Open the diff for the next file" } },
                        { "n", "k",     actions.prev_entry,         { desc = "Previous file" } },
                        { "n", "<C-k>", actions.select_prev_entry,  { desc = "Open the diff for the previous file" } },

                        -- Staging
                        { "n", "<cr>",  actions.select_entry,       { desc = "Open diff for entry" } },
                        { "n", "s",     actions.toggle_stage_entry, { desc = "Stage/unstage entry" } },
                        { "n", "S",     actions.stage_all,          { desc = "Stage all" } },
                        { "n", "U",     actions.unstage_all,        { desc = "Unstage all" } },
                        { "n", "R",     actions.restore_entry,      { desc = "Restore file" } },
                    }
                }
            })

            vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "[G]it [D]iffview open" })
            vim.keymap.set("n", "<leader>gq", ":DiffviewClose<CR>", { desc = "[G]it diffview [Q]uit" })

            -- Actual diff keymaps are same as Vimdiff - right side is source file buffer on disk
            -- Hunks: ]c (next hunk), [c (prev hunk)
            -- Resolving: do (take hunk from Other side), dp (Put the changes from current window in other)
            -- Folds: zo (open), zc (close), za (toggle), zR (open all), zM (close all)
        end,
    },
}
