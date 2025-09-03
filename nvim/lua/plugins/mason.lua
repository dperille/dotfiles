-- Used to pre-install external editing tooling rather than needing to do so manually
-- Individual config for LSPs in lsp-config, linters/formatters in null-ls
return {
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
        end
    }
}
