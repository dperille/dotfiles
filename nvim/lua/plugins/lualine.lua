return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        -- Info about the currently connected LSP
        local function lsp_status()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
                    return client.name
                end
            end
            return msg
        end

        require("lualine").setup({
            options = {
                -- Use web devicons
                icons_enabled = true,
                -- Set theme
                theme = "auto",
                -- Separate components of lua line with chevrons
                component_separators = { left = "", right = "" },
                -- Separate sections with solid triangles
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = { 'NvimTree' },
                always_divide_middle = true,
                globalStatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            -- Set up what each section will contain (starts with a on left, z on right)
            sections = {
                -- display current mode
                lualine_a = { "mode" },
                -- git information + code diagnostics
                lualine_b = { "branch", "diff", "diagnostics" },
                -- filename and current LSP
                lualine_c = {
                    { "filename", path = 1 }, -- path=1 shows relative path
                    "%=",                     -- used to center the LSP status
                    { lsp_status, icon = ' LSP:', color = { fg = '#ffffff' }, separator = { left = '', right = '' } },
                },
                -- file encoding and type
                lualine_x = {
                    "encoding",
                    { "fileformat", icons_enabled = false, fmt = string.upper },
                    "filetype" },
                -- display where cursor is in the file
                lualine_y = { "progress" },
                -- display exact cursor location
                lualine_z = { "location" },
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end
}
