-- Info about available key mappings
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local which_key = require('which-key')

        which_key.setup()

        -- Register prefixes
        which_key.register({
              c = { name = "[C]ode" },
              e = { name = "[E]xplorer" },
              f = { name = "[F]ind" },
              g = { name = "[G]it" },
              J = { name = "[J]ava" },
        }, { prefix = "<leader>" })
    end
}
