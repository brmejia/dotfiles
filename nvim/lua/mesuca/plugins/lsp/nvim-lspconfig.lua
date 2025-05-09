return {
    "neovim/nvim-lspconfig",
    -- enabled = false,
    dependencies = {
        "rcarriga/nvim-notify",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function(_, opts)
        local lsp_lib = require("lib.lsp")
        local lspconfig = require("lspconfig")

        lsp_lib.setup_diagnostics()

        local servers = opts.servers

        local default_server_handler = function(server_name)
            local default_server_options = {
                capabilities = lsp_lib.get_default_capabilities(opts.capabilities or {}),
                on_attach = lsp_lib.on_attach,
            }
            local merged_opts = vim.tbl_deep_extend("force", default_server_options, servers[server_name] or {})

            lspconfig[server_name].setup(merged_opts)
        end

        local have_mason_lspconfig, mlsp = pcall(require, "mason-lspconfig")

        mlsp.setup_handlers({ default_server_handler })
        local to_setup_manually = {} ---@type string[]
        if have_mason_lspconfig then
            local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            -- vim.notify(vim.inspect(all_mslp_servers))

            local to_setup_with_mason = {} ---@type string[]
            for server_name, _ in pairs(servers) do
                if vim.tbl_contains(all_mslp_servers, server_name) then
                    to_setup_with_mason[#to_setup_with_mason + 1] = server_name
                else
                    to_setup_manually[#to_setup_manually + 1] = server_name
                end
            end
            mlsp.setup({ automatic_installation = true, ensure_installed = to_setup_with_mason })
        end
        if to_setup_manually then
            local mr = require("mason-registry")
            for _, server_name in pairs(to_setup_manually) do
                local p = mr.get_package(server_name)
                if p:is_installed() then
                    default_server_handler(server_name)
                end
            end
        end
    end,
}
