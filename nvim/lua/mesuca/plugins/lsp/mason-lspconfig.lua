return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
        ensure_installed = {
            "python-lsp-server",
            "ruff-lsp",
            "lua-language-server",
            -- "mypy",
            -- "ruff",
            -- "black",
            -- "rust_analyzer",
            "taplo", -- TOML Files
            "vue-language-server",
            "typescript-language-server",
            "deno",
            "tailwindcss-language-server",
            "eslint-lsp",
            "prettierd",
            "stylua",
            "ansible-language-server",
        },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
        require("mason").setup(opts)
        local mr = require("mason-registry")
        local function ensure_installed()
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end
        if mr.refresh then
            mr.refresh(ensure_installed)
        else
            ensure_installed()
        end
    end,
}
