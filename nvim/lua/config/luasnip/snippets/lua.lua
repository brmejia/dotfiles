return {
    s(
        "reqnvim",
        fmt([[
            if not require "lib.utils".has_module("{}") then
                return
            end

            local {} = require "{}"
            {}
        ]],
            { i(1, "NAME"), rep(1), rep(1), i(0) }
        )
    )

    --     s("vreq", {
    --         t("if not require \"lib.utils\".has_module(\""),
    --         i(1, "NAME"),
    --         t("\") then"),
    --         t { "", "" },
    --         t("\treturn"),
    --         t { "", "" },
    --         t("end"),
    --         t { "", "" },
    --         t("local "),
    --         rep(1),
    --         t(" = require \""),
    --         rep(1),
    --         t("\""),
    --     })
}
