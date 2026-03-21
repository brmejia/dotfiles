return {
    settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            checkOnSave = true,
            procMacro = {
                enable = true,
            },
            cargo = {
                features = "all",
                -- OR use: features = "all"  to enable everything
                -- features = { "watch" }, -- enable specific feature(s)
            },
            check = {
                command = "clippy", -- use clippy instead of check
            },
        },
    },
}
