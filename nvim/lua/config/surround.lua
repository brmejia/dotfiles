
local status_ok, surround = pcall(require, 'surround')
if not status_ok then
    return
end

surround.setup {
    prefix = "s",
    mappings_style = "sandwich",
}
