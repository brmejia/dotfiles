local lsp = require("lib.lsp")

return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = lsp.get_server_root_dir_fn("Pyright", {
        {
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "Pipfile",
            "requirements.txt",
            "requirements.lock",
            "requirements-dev.lock",
            "pyrightconfig.json",
        },
        { "*.py" },
        { ".git" },
    }),
    -- root_markers = { "pyproject.toml", "setup.py", ".git" },
    settings = {
        basedpyright = {
            typeCheckingMode = "off", -- disable errors, let ty handle those
            analysis = {
                useLibraryCodeForTypes = true,
            },
        },
    },
}
