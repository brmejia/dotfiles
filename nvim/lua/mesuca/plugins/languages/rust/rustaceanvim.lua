vim.g.rustaceanvim = function()
    -- local lsp_lib = require("lib.lsp")
    local cfg = require("rustaceanvim.config")

    local keymap = require("lib.utils").keymap
    keymap("n", "<leader>tt", function()
        vim.cmd.RustLsp("testables")
    end, { desc = "Run a tests" })

    keymap("n", "<leader><leader>T", function()
        vim.cmd.RustLsp({ "testables", bang = true })
    end, { desc = "Run latest test" })

    keymap("n", "<leader><leader>a", function()
        vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
    end, { desc = "Rust code actions" })

    keymap("n", "<leader>lg", function()
        vim.cmd.RustLsp("relatedDiagnostics") -- supports rust-analyzer's grouping
    end, { desc = "Go to related diagnostic" })

    -- vim.cmd.RustLsp('relatedDiagnostics')

    -- Update this path
    --
    local extension_path = vim.env.HOME
        .. "/.var/app/com.visualstudio.code/data/vscode/extensions/vadimcn.vscode-lldb-1.11.4/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb"
    local this_os = vim.uv.os_uname().sysname

    -- The path is different on Windows
    if this_os:find("Windows") then
        codelldb_path = extension_path .. "adapter\\codelldb.exe"
        liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
    else
        -- The liblldb extension is .so for Linux and .dylib for MacOS
        liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
    end

    return {
        tools = {
            test_executor = "background",
        },
        dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
    }
end

return {
    {
        "mrcjkb/rustaceanvim",
        -- enabled = false,
        version = "^6", -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    {
        "chrisgrieser/nvim-lsp-endhints",
        enabled = false,
        event = "LspAttach",
        opts = {
            icons = {
                type = "󰜁 ",
                parameter = "󰏪 ",
                -- offspec = " ", -- hint kind not defined in official LSP spec
                offspec = "", -- hint kind not defined in official LSP spec
                unknown = " ", -- hint kind is nil
            },
            label = {
                truncateAtChars = 50,
                padding = 1,
                marginLeft = 8,
                sameKindSeparator = "| ",
            },
            extmark = {
                priority = 50,
            },
            autoEnableHints = true,
        }, -- required, even if empty
    },
}
