local api = vim.api
local fn = vim.fn
local utils = {}

utils.keymap = function(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("keep", opts or {}, { noremap = true, silent = true }))
end

utils.buf_keymap = function(bufnr, mode, lhs, rhs, opts)
    vim.keymap.set(
        mode,
        lhs,
        rhs,
        vim.tbl_extend("keep", opts or {}, { noremap = true, silent = true, buffer = bufnr })
    )
end

utils.buf_set_options = function(bufnr, name, value)
    vim.api.nvim_buf_set_option(bufnr, name, value)
end

function utils.has_map(map, mode)
    mode = mode or "n"
    return fn.maparg(map, mode) ~= ""
end

function utils.has_module(name)
    if pcall(function()
        require(name)
    end) then
        return true
    else
        return false
    end
end

-- find more here: https://www.nerdfonts.com/cheat-sheet
utils.kind_icons = {
    Array = "",
    Boolean = "",
    Class = "",
    Color = "󰏘",
    Constant = "",
    Constructor = "",
    Component = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "󰜢",
    File = "󰈙",
    Fragment = "",
    Folder = "󰉋",
    Function = "󰊕",
    Interface = " ",
    Keyword = "󰌋",
    Method = "󰡱",
    Module = "",
    Namespace = "",
    Null = "󰟢",
    Number = "󰎠",
    Object = "",
    Operator = "󰆕",
    Package = "",
    Property = "",
    Reference = "󰈇",
    Snippet = "",
    String = "󰀬",
    Struct = "󰙅",
    Text = "󰉿",
    TypeParameter = "𝙏",
    Unit = "󰑭",
    Value = "󰎠",
    Variable = "󰫧",
    Codeium = "",
}

function utils.copy_relative_path(opts)
    opts = opts or {}
    local relative_path

    if opts.visual then
        local file = vim.fn.expand("<afile>")
        if file == "" then
            vim.notify("No file selected", vim.log.levels.WARN)
            return
        end
        relative_path = vim.fn.fnamemodify(file, ":.")
    else
        local buf_path = vim.api.nvim_buf_get_name(0)
        if buf_path == "" then
            vim.notify("No file in buffer", vim.log.levels.WARN)
            return
        end
        relative_path = vim.fn.fnamemodify(buf_path, ":.")
    end

    local ok, err = pcall(function()
        vim.cmd(string.format("let @+ = %q", relative_path))
    end)
    if not ok then
        vim.notify("Failed to copy: " .. err, vim.log.levels.ERROR)
        return
    end
    vim.notify("Copied: " .. relative_path, vim.log.levels.INFO)
end

return utils
