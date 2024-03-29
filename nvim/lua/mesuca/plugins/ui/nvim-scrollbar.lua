return {
    "petertriho/nvim-scrollbar",
    dependencies = { "kevinhwang91/nvim-hlslens" },
    -- config = lazy_config "config.nvim-scrollbar",
    config = function()
        local scrollbar = require("scrollbar")

        local setup_cfg = {}

        setup_cfg["handlers"] = {
            diagnostic = true,
            search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
        }

        if require("lib.utils").has_module("catppuccin") then
            local cp = require("catppuccin.palettes").get_palette() -- fetch colors from g:catppuccin_flavour palette
            setup_cfg["handle"] = { color = cp.surface1 }
            -- setup_cfg["narks"] = {
            --     Search = { color = cp.orange },
            --     Error = { color = cp.red },
            --     Warn = { color = cp.warning },
            --     Info = { color = cp.teal },
            --     Hint = { color = cp.hint },
            --     Misc = { color = cp.purple },
            -- }
        end

        scrollbar.setup(setup_cfg)
        require("scrollbar.handlers.gitsigns").setup()
    end,
}
