local lsp = require("lib.lsp")

return {
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
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                -- ignore = { "*" },
                -- typeCheckingMode ["off", "basic", "standard", "strict"]
                typeCheckingMode = "off",
            },
        },
    },
}
