return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    opts = {
        ensure_installed = {
            -- "rust_analyzer",
            "taplo", -- TOML Files
            "ansible-language-server",

            -- Lua
            -- ---------------------
            "stylua",
            "lua-language-server",

            -- Python
            -- ---------------------
            "python-lsp-server",
            "ruff-lsp",
            -- "black",
            -- "mypy", -- Mypy needs to be installed on virtualenvironment
            -- "ruff",

            -- Typescript/Javascript/HTML/CSS
            -- ---------------------
            "tailwindcss-language-server",
            "vue-language-server",
            -- "typescript-language-server", -- Conflict with typescript-tools nvim module
            -- "deno",
            -- "eslint-lsp",
            "prettier",
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
