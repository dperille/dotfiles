return {
    {
        "Mofiqul/vscode.nvim",
        config = function()
            vim.cmd.colorscheme("vscode")

            -- Brighter line numbers
            vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff", bold = false })
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#66aef2", bold = true })

            -- Cursor line
            vim.api.nvim_set_hl(0, "CursorLine", { bg = "#333355" })

            -- Float windows
            vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#37124a' })
        end
    },
}
