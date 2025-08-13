return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        -- ts-autotag utilizes treesitter to understand the code structure to automatically close tsx tags
        "windwp/nvim-ts-autotag"
    },
    -- when the plugin builds run the TSUpdate command to ensure all our servers are installed and updated
    build = ':TSUpdate',
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"vim", "vimdoc", "lua", "java", "javascript", "typescript", "html", "css", "json", "tsx", "markdown", "markdown_inline", "gitignore"},
            highlight = {enable = true},
            -- Auto-close TSX tags
            autotag = {
                enable = true
            }
        })
    end
}

