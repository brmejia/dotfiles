local _id = select(2, ...) or ...

return {
    { import = _id .. ".rust" },
    { import = _id .. ".typescript" },
}
