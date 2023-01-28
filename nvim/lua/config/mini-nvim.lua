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
            animation = require('mini.indentscope').gen_animation.quadratic({
                easing = "out",
                duration = 100,
                unit = 'total'
            }),
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
if require "lib.utils".has_module("mini.ai") then
    local mini_ai = require "mini.ai"
    mini_ai.setup({
        -- Table with textobject id as fields, textobject specification as values.
        -- Also use this to disable builtin textobjects. See |MiniAi.config|.
        custom_textobjects = nil,

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            -- Main textobject prefixes
            around = 'a',
            inside = 'i',

            -- Next/last variants
            around_next = 'an',
            inside_next = 'in',
            around_last = 'al',
            inside_last = 'il',

            -- Move cursor to corresponding edge of `a` textobject
            goto_left = 'g[',
            goto_right = 'g]',
        },

        -- Number of lines within which textobject is searched
        n_lines = 250,

        -- How to search for object (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
        search_method = 'cover_or_next',
    })
end


if require "lib.utils".has_module("mini.surround") then
    require("mini.surround").setup({
        -- Add custom surroundings to be used on top of builtin ones. For more
        -- information with examples, see `:h MiniSurround.config`.
        custom_surroundings = nil,
        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            add = 'sa', -- Add surrounding in Normal and Visual modes
            delete = 'sd', -- Delete surrounding
            find = 'sf', -- Find surrounding (to the right)
            find_left = 'sF', -- Find surrounding (to the left)
            highlight = 'sh', -- Highlight surrounding
            replace = 'sr', -- Replace surrounding
            update_n_lines = 'sn', -- Update `n_lines`
        },
        -- Number of lines within which surrounding is searched
        n_lines = 50,
        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest'. For more details, see `:h MiniSurround.config`.
        search_method = 'cover',
    })
end
