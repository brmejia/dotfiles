if not require "lib.utils".has_module("alpha") then
    return
end

require 'alpha'.setup(
    require 'alpha.themes.startify'.config
    -- require 'alpha.themes.dashboard'.config
)
