return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local nvim_tree = require("nvim-tree")
        local api = require("nvim-tree.api")

        -- Keymaps
        vim.keymap.set('n', '<leader>eo', api.tree.open, { desc = "[E]xplorer [O]pen" })
        vim.keymap.set('n', '<leader>et', api.tree.toggle, { desc = '[E]xplorer [T]oggle' })
        vim.keymap.set(
            'n', '<leader>ef',
            function()
                -- If tree is already focused, want to find previous buf (ie file we were editing)
                local get_prev_buf_if_tree_focused = function()
                    local win_id = vim.api.nvim_get_current_win()
                    local buf = vim.api.nvim_win_get_buf(win_id)
                    local buf_name = vim.api.nvim_buf_get_name(buf)

                    if buf_name:match("NvimTree_") then
                        local prev_buf = vim.fn.bufnr('#')
                        return prev_buf
                    else
                        return buf
                    end
                end

                api.tree.find_file({
                    open = true,  -- Open tree if not already
                    focus = true, -- Focus tree
                    buf = get_prev_buf_if_tree_focused()
                })
            end,
            { desc = "[E]xplorer [F]ind current file" }
        )
        vim.keymap.set('n', '<leader>ep', api.tree.expand_all, { desc = '[E]xplorer Ex[P]and current node' })
        vim.keymap.set('n', '<leader>el', api.tree.collapse_all, { desc = '[E]xplorer Co[L]lapse all' })

        -- Setup
        nvim_tree.setup({
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
