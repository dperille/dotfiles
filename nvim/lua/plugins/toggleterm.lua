return {
    {
        "akinsho/toggleterm.nvim",
        config = function()
            -- Keymaps
            vim.keymap.set('n', '<leader>tt', ':ToggleTermToggleAll<CR>')
            vim.keymap.set('n', '<leader>tn', ':TermNew<CR>', { desc = "[T]erminal [N]ew" })
            vim.keymap.set('n', '<leader>ts', ':TermSelect<CR>', { desc = "[T]erminal [S]elect" })
            vim.keymap.set('t', '<C-space>', '<C-\\><C-n>:ToggleTermToggleAll<CR>') -- Exiting terminal mode and toggle off

            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then
                        return 15
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.4
                    else
                        return 20
                    end
                end,
                hide_numbers = true, -- hide the number column
                start_in_insert = true,
                persist_mode = true,
                persist_size = true,
                direction = "horizontal", -- vertical, horizontal, tab, float
            })
        end,
    }
}
