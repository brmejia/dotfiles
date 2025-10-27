return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    opts = {
        ensure_installed = {
            "ansible-lint",
            "ltex-ls",
            "vue-language-server",
            -- Lua
            -- ---------------------
            "stylua",
            "lua-language-server",

            -- Python
            -- ---------------------
            -- "black", -- Replaced by ruff
            -- "mypy",
            "debugpy",

            -- Typescript/Javascript/HTML/CSS
            -- ---------------------
            "biome",
            "prettierd",
            "prettier",
            "vacuum",
        },
    },

    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
        local mason = require("mason")

        local function install_mason_packages(tools)
            local mr = require("mason-registry")
            if mr.refresh then
                mr.refresh()
            end
            for _, tool in pairs(tools) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end

        mason.setup()
        install_mason_packages(opts.ensure_installed)
    end,
}
