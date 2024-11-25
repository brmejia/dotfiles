return {
    {
        "mfussenegger/nvim-dap",
        config = function(_, opts)
            local dap = require("dap")

            dap.adapters.python = {
                id = "Debugpy server",
                type = "server",
                -- host = "127.0.0.1",
                port = 5678,
            }
            dap.configurations.python = {
                {
                    type = "python",
                    request = "attach",
                    name = "Attach to remote DAP server",
                    -- port = 5678,
                    -- host = "127.0.0.1",
                },
            }

            local keymap = require("lib.utils").keymap
            keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            keymap("n", "<Leader>dB", dap.set_breakpoint, { desc = "Set breakpoint" })
            keymap("n", "<leader>dc", dap.continue, { desc = "Continue" })
            keymap("n", "<leader>ds", dap.step_over, { desc = "Step over" })
            keymap("n", "<leader>dn", dap.step_over, { desc = "Step over (next)" })
            keymap("n", "<leader>dsi", dap.step_into, { desc = "Step into" })
            keymap("n", "<leader>dso", dap.step_out, { desc = "Step out" })
            keymap("n", "<leader>dd", dap.disconnect, { desc = "Disconnect" })
            keymap("n", "<Leader>dl", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end, { desc = "set log point" })
            keymap("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
            keymap("n", "<Leader>dl", dap.run_last, { desc = "Run last" })
            -- keymap({ "n", "v" }, "<M-k>", require("dap.ui.widgets").hover, { desc = "hover" })
            -- keymap({ "n", "v" }, "<Leader>dp", require("dap.ui.widgets").preview, { desc = "preview" })
            keymap("n", "<Leader>dF", function()
                local widgets = require("dap.ui.widgets")
                widgets.centered_float(widgets.frames)
            end, { desc = "float frames" })
            keymap("n", "<Leader>dS", function()
                local widgets = require("dap.ui.widgets")
                widgets.centered_float(widgets.scopes)
            end, { desc = "float scopes" })

            vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-dap-ui",
        },
        ft = "python",
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup({
                highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                virt_text_pos = "inline",
            })
        end,
    },
}
