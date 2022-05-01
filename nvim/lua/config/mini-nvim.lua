if require "lib.utils".has_module("mini.cursorword") then
    require("mini.cursorword").setup()
end

if require "lib.utils".has_module("mini.indentscope") then
    require("mini.indentscope").setup({
        draw = {
            -- Delay (in ms) between event and start of drawing scope indicator
            delay = 100,

            -- Animation rule for scope's first drawing. A function which, given next
            -- and total step numbers, returns wait time (in ms). See
            -- |MiniIndentscope.gen_animation()| for builtin options. To not use
            -- animation, supply `require('mini.indentscope').gen_animation('none')`.
            animation = require('mini.indentscope').gen_animation('quadraticOut', { duration = 70, unit = 'total' }),
        }
    })
end
if require "lib.utils".has_module("mini.pairs") then
    require("mini.pairs").setup()
end
if require "lib.utils".has_module("mini.trailspace") then
    require("mini.trailspace").setup()
end
if require "lib.utils".has_module("mini.sessions") then
    require("mini.sessions").setup({
        options = {
            -- Whether to read latest session if Neovim opened without file arguments
            autoread = false,

            -- Whether to write current session before quitting Neovim
            autowrite = true,

            -- Directory where global sessions are stored (use `''` to disable)
            -- directory = --<"session" subdir of user data directory from |stdpath()|>,

            -- File for local session (use `''` to disable)
            file = '.vim-session',

            -- Whether to force possibly harmful actions (meaning depends on function)
            force = { read = false, write = true, delete = false },

            -- Whether to print session path after action
            verbose = { read = false, write = true, delete = true },
        },
    })
end
