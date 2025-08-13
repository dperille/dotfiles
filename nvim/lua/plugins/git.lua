return {
    {
        "tpope/vim-fugitive",
        config = function()
            -- <Space> + g + b to git blame
            vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { desc = "[G]it [B]lame" })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
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
        end,
    },
}
