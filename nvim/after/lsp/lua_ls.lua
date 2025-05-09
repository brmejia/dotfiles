return {
    settings = {
        Lua = {
            format = {
                enable = false, -- Replaced by null_ls stylua plugin
            },
            diagnostics = {
                globals = { "vim", "use" },
            },
            workspace = {
                checkThirdParty = false,
            },
            completion = {
                callSnippet = "Replace",
            },
        },
    },
}
