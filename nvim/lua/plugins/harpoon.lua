-- Mark files for easier navigation
return {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local harpoon_ui = require("harpoon.ui")
        local harpoon_mark = require("harpoon.mark")

        vim.keymap.set("n", "<leader>a", harpoon_mark.add_file, { desc = "Harpoon [a]dd file" })
        vim.keymap.set("n", "<leader>h", harpoon_ui.toggle_quick_menu, { desc = "[H]arpoon quick menu" })

        -- Jump to files 1-4
        vim.keymap.set("n", "<leader>1", function() harpoon_ui.nav_file(1) end)
        vim.keymap.set("n", "<leader>2", function() harpoon_ui.nav_file(2) end)
        vim.keymap.set("n", "<leader>3", function() harpoon_ui.nav_file(3) end)
        vim.keymap.set("n", "<leader>4", function() harpoon_ui.nav_file(4) end)
    end,
}
