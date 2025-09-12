-- Mark files for easier navigation
return {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("harpoon").setup({
            tabline = true,
            menu = {
                width = vim.api.nvim_win_get_width(0) / 2,
            }
        })

        -- Keymaps
        local harpoon_ui = require("harpoon.ui")
        local harpoon_mark = require("harpoon.mark")

        vim.keymap.set("n", "<leader>a",
            function()
                harpoon_mark.add_file()
                vim.cmd('redrawtabline')
            end,
            { desc = "Harpoon [a]dd file" })
        vim.keymap.set("n", "<leader>h", harpoon_ui.toggle_quick_menu, { desc = "[H]arpoon quick menu" })
        vim.keymap.set("n", "<leader>1", function() harpoon_ui.nav_file(1) end)
        vim.keymap.set("n", "<leader>2", function() harpoon_ui.nav_file(2) end)
        vim.keymap.set("n", "<leader>3", function() harpoon_ui.nav_file(3) end)
        vim.keymap.set("n", "<leader>4", function() harpoon_ui.nav_file(4) end)

        -- Tabline colors
        vim.cmd('highlight! HarpoonInactive guibg=#232347 guifg=#8a8acb')
        vim.cmd('highlight! HarpoonActive guibg=#353570 guifg=#ffffff')
        vim.cmd('highlight! HarpoonNumberActive guibg=#353570 guifg=#9cdcfe')
        vim.cmd('highlight! HarpoonNumberInactive guibg=#232347 guifg=#569cd6')
        vim.cmd('highlight! TabLineFill guibg=#1e1e1e guifg=#d4d4d4')
    end,
}
