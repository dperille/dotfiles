return {
    {
        "saghen/blink.cmp",
        opts = {
            fuzzy = {
                -- Use rust implementation over Lua
                implementation = "prefer_rust_with_warning",
                prebuilt_binaries = { -- Use pre-built binary instead of setting up manually
                    force_version = "v1.6.0",
                },
            },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                        semantic_token_resolution = {
                            enabled = false,
                        }
                    },
                },
                documentation = {
                    auto_show = true
                },
                list = {
                    selection = {
                        preselect = true,    -- Start on first item in list
                        auto_insert = false, -- Don't insert text while scrolling list (ie, until actually selected)
                    },
                },
            },
            keymap = {
                preset = 'none',

                ['<Tab>'] = {
                    function(cmp)
                        return cmp.select_and_accept()
                    end
                },
                ['<C-j>'] = { 'select_next' },
                ['<C-k>'] = { 'select_prev' },
            }
        },
    }
}
