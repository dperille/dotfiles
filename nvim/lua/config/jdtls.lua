-- Get installed JDTLS information
local function get_jdtls()
    -- Get the full file path to where Mason downloaded JDTLS binaries
    local jdtls_path = vim.fn.expand("$MASON/packages/jdtls")
    -- Within JDTLS download, find the jar which actually runs the language server
    local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    -- Declare operating system (windows = win, macos = mac, linux = linux)
    local SYSTEM = "mac"
    -- Find the JDTLS config files for this specific OS
    local config = jdtls_path .. "/config_" .. SYSTEM

    return launcher, config
end

-- Set up debugging & testing
local function get_bundles()
    local bundles = {}
    local java_debug_jars = vim.fn.globpath("$MASON/share/java-debug-adapter", "*.jar", true, true)
    vim.list_extend(bundles, java_debug_jars)

    local java_test_jars = vim.fn.globpath("$MASON/share/java-test", "*.jar", true, true)
    vim.list_extend(bundles, java_test_jars)

    return bundles
end

-- Sets up JDTLS workspace
-- TODO: modify this to create in the project root, similar to the .idea folder
local function get_workspace()
    -- Get home directory
    local home = os.getenv "HOME"
    -- Declare directory to store project info
    local workspace_path = home .. "/.cache/nvim/nvim-jdtls/"
    -- Determine project name
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")


    local workspace_dir = workspace_path .. project_name
    return workspace_dir
end

-- Set up keymaps
-- TODO: go through these
local function java_keymaps()
    -- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
    vim.keymap.set('n', '<leader>Jo', "<Cmd> lua require('jdtls').organize_imports()<CR>",
        { desc = "[J]ava [O]rganize Imports" })
    -- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
    vim.keymap.set('n', '<leader>Jv', "<Cmd> lua require('jdtls').extract_variable()<CR>",
        { desc = "[J]ava Extract [V]ariable" })
    -- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
    vim.keymap.set('v', '<leader>Jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>",
        { desc = "[J]ava Extract [V]ariable" })
    -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
    vim.keymap.set('n', '<leader>JC', "<Cmd> lua require('jdtls').extract_constant()<CR>",
        { desc = "[J]ava Extract [C]onstant" })
    -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
    vim.keymap.set('v', '<leader>JC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>",
        { desc = "[J]ava Extract [C]onstant" })
    -- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
    vim.keymap.set('n', '<leader>Jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>",
        { desc = "[J]ava [T]est Method" })
    -- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
    vim.keymap.set('v', '<leader>Jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>",
        { desc = "[J]ava [T]est Method" })
    -- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
    vim.keymap.set('n', '<leader>JT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "[J]ava [T]est Class" })
end

-- Actually set up & run JDTLS
local function setup_jdtls()
    local jdtls = require("jdtls")
    local launcher, os_config = get_jdtls()
    local workspace_dir = get_workspace()
    local bundles = get_bundles()

    -- Determine project root via specific markers
    local root_dir = jdtls.setup.find_root({ '.git', 'gradlew', 'pom.xml' });

    -- Tell JDTLS language features it's capable of
    local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                snippetSupport = false
            }
        }
    }

    -- Get default capabilities from completion plugin & merge with above
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    for k, v in pairs(lsp_capabilities) do capabilities[k] = v end

    -- Allow JDTLS to do more complex operations
    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    -- Set the command to actually start the language server
    local cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx8g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        launcher,
        '-configuration',
        os_config,
        '-data',
        workspace_dir
    }

    -- Configure settings in the JDTLS server
    local settings = {
        java = {
            signatureHelp = {
                enabled = true
            },
            -- completion options
            completion = {
                -- When using unimported static method, rank possible places to import it from
                favoriteStaticMembers = {
                    "org.assertj.core.api.Assertions.*",
                    "org.mockito.Mockito.*",
                },
            },
            lens = {
                implementations = {
                    enabled = true,
                },
                references = {
                    enabled = true,
                },
            },
            -- enable inlay hints for parameter names
            inlayHints = {
                parameterNames = {
                    enabled = "all",
                },
            },
            eclipse = {
                downloadSources = true,
            },
            contentProvider = {
                preferred = 'fernflower',
            },
        },
    }

    -- Create table to pass bundles w/ debug & testing jar, and client capabilities
    local init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
    }

    -- Function to run once the language server is attached
    local on_attach = function(_, bufnr)
        -- Set up Java-specific keymaps
        java_keymaps()

        -- Set up the Java debug adapter of JDTLS server
        require("jdtls.dap").setup_dap()

        -- Enable JDTLS commands to be used in Neovim
        require("jdtls.setup").add_commands()

        -- Refresh codelens: enables method reference/implementation counts, etc.
        vim.lsp.codelens.refresh()

        -- Refresh codelens when java file is saved
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.java" },
            callback = function()
                local _, _ = pcall(vim.lsp.codelens.refresh)
            end
        })
    end

    local flags = {
        allow_incremental_sync = true,
    }

    -- Create configuration for start/attach function
    local config = {
        cmd = cmd,
        root_dir = root_dir,
        settings = settings,
        flags = flags,
        capabilities = capabilities,
        init_options = init_options,
        on_attach = on_attach,
    }

    -- Start the JDTLS server
    require('jdtls').start_or_attach(config)
end

return {
    setup_jdtls = setup_jdtls,
}
