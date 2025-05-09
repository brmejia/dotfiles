return {
    cmd = { "ltex-ls" },
    filetypes = { "markdown", "text", "typst" },
    flags = { debounce_text_changes = 5000 },
    settings = {
        ltex = {
            checkFrequency = "save",
            additionalrules = { motherTongue = "es", enablepickyrules = true },
            language = "auto",
        },
    },
}
