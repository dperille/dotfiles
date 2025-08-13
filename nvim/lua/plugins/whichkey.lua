-- Info about available key mappings
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local which_key = require('which-key')

        which_key.setup()

        -- Register prefixes
        which_key.add({
            { "<leader>g", group = "[G]it" },
            { "<leader>f", group = "[F]ind" },
            { "<leader>e", group = "[E]xplorer" },
            { "<leader>c", group = "[C]ode" },
            { "<leader>h", group = "[H]arpoon" },
            { "<leader>w", group = "[W]indow" },
            { "<leader>t", group = "[T]erminal" },
        })
    end
}
