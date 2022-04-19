local api = vim.api
local fn = vim.fn
local utils = {}

utils.keymap = function(mode, lhs, rhs, opts)
    vim.api.nvim_set_keymap(
        mode,
        lhs,
        rhs,
        vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true })
    )
end

utils.buf_keymap = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        mode,
        lhs,
        rhs,
        vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true })
    )
end

utils.buf_set_options = function(bufnr, name, value)
    vim.api.nvim_buf_set_option(
        bufnr,
        name,
        value
    )
end

function utils.has_map(map, mode)
    mode = mode or "n"
    return fn.maparg(map, mode) ~= ""
end

function utils.has_module(name)
    if pcall(
        function()
            require(name)
        end
    )
    then
        return true
    else
        return false
    end
end

return utils
