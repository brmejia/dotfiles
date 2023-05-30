return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" , },
    opts = {
        ensure_installed = {
            "pylsp",
            "ruff_lsp",
            "lua_ls",
            -- "rust_analyzer",
            "taplo", -- TOML Files
            "volar",
            "tsserver",
            "denols",
            "tailwindcss",
            "eslint",
        }
    }
}
