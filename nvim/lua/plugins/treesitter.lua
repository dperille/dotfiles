return {
    "nvim-treesitter/nvim-treesitter",
    -- Update installed Tree-sitter parsers whenever nvim-treesitter is installed or updated
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "vim",
                "vimdoc",
                "lua",
                "java",
                "go",
                "gomod",
                "gowork",
                "python",
                "javascript",
                "typescript",
                "html",
                "css",
                "json",
                "tsx",
                "markdown",
                "markdown_inline",
                "gitignore",
            },
            highlight = {
                enable = true,
            },
        })
    end,
}
