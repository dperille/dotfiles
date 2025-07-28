return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        vim.keymap.set('n', '<leader>e', "<cmd>NvimTreeToggle<CR>", {desc = "Toggle [E]xplorer"})
        require("nvim-tree").setup({
            view = {
                width = 50,
            },
            -- use nvim-tree instead of netrw
            hijack_netrw = true,
            -- reload file tree on writes
            auto_reload_on_write = true,
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = true,
                debounce_delay = 50,
                severity = {
                    min = vim.diagnostic.severity.WARN,
                    max = vim.diagnostic.severity.ERROR,
               }
            },
        })
    end
}
