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
}

return utils
