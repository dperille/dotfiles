return {
    -- Auto-close quotes/braces/etc
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                ts_config = {
                    lua = { "string" },
                    javascript = { "template_string" },
                    java = false,
                },
            })
        end,
    },
    -- Auto-close html tags
    {
        "windwp/nvim-ts-autotag",
        event = { "InsertEnter" },
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true, -- Auto-close tags
                    enable_rename = true, -- If renaming one tag, auto-renames matching one
                },
            })
        end,
    }
}
