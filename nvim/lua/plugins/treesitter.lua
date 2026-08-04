return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = 'main',
    config = function()
        require("nvim-treesitter").install({
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
        })
        
        -- Enable treesitter highlighting
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
    -- Update installed Tree-sitter parsers whenever nvim-treesitter is installed or updated
    build = ":TSUpdate",
}
