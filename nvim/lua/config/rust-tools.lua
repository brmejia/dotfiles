if not require "lib.utils".has_module("rust-tools") then
    return
end

local rt = require "rust-tools"
local lsp = require("config.lsp.lsp-config")

rt.setup({
    server = {
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }
            }
        }
    }
})
