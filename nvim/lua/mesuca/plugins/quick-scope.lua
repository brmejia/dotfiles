return {
    "unblevable/quick-scope",
    init = function()
        -- Trigger a highlight in the appropriate direction when pressing these keys:
        vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end,
}
