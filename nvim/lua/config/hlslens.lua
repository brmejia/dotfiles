if not require"lib.utils".has_module("hlslens") then
    return
end

require('hlslens').setup({
    calm_down = true,
    nearest_only = true,
    nearest_float_when = 'always'
})
