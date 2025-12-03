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
        },
    },
}
