return {
    -- Adds 'surround' selections for quotes, tags, braces, etc
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function ()
            require("nvim-surround").setup({})
        end,
    },
}
