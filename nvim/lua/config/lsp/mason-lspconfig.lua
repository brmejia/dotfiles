if not require "lib.utils".has_module("mason-lspconfig") then
    return
end
-- local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
-- if not status_ok then
--     return
-- end
local mason_lsp = require "mason-lspconfig"

mason_lsp.setup({
    ensure_installed = {
        "pylsp",
        "ruff_lsp",
        "lua_ls",
        "rust_analyzer",
        "taplo", -- TOML Files
        "volar",
        "tsserver",
        "denols",
        "tailwindcss",
        "eslint",
    }
})

--mason_lsp.on_server_ready(function(server)
--    local opts = {
--        on_attach = require "config.lsp.lsp-config".on_attach,
--        capabilities = require "config.lsp.lsp-config".capabilities
--    }

--    if server.name == "sumneko_lua" then
--        opts["settings"] = {
--            Lua = {
--                diagnostics = {
--                    globals = { 'vim', 'use' }
--                },
--                --workspace = {
--                -- Make the server aware of Neovim runtime files
--                --library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
--                --}
--            }
--        }
--    end

--    if server.name == "pylsp" then
--        opts["settings"] = {
--            pylsp = {
--                configurationSources = { "flake8" },
--                plugins = {
--                    pylint = { enabled = true },
--                    black = { enabled = true },
--                    yapf = { enabled = false },
--                    autopep8 = { enabled = false },
--                    flake8 = { enabled = false },
--                    pycodestyle = { enabled = false },
--                    pyflakes = { enabled = false },
--                }

--            }
--        }
--    end

--    server:setup(opts)
--end)
