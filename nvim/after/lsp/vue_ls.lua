local lsp = require("lib.lsp")

return {
    -- cmd = { "vue-language-server", "--stdio" }, -- commented in order to use the binary installed with mason
    root_dir = lsp.get_server_root_dir_fn("vue_ls", {
        { ".nuxtrc", ".npmrc", "package.json", "yarn.lock" },
    }),
    -- on_new_config = on_new_config,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
    init_options = {
        typescript = {
            tsdk = "",
        },
        languageFeatures = {
            implementation = true, -- new in @vue_ls/vue-language-server v0.33
            references = true,
            definition = true,
            typeDefinition = true,
            callHierarchy = true,
            hover = true,
            rename = true,
            renameFileRefactoring = true,
            signatureHelp = true,
            codeAction = true,
            workspaceSymbol = true,
            completion = {
                defaultTagNameCase = "both",
                defaultAttrNameCase = "kebabCase",
                getDocumentNameCasesRequest = false,
                getDocumentSelectionRequest = false,
            },
        },
    },
}
