return {
    {
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
}
