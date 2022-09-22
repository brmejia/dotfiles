return {

    -- s("dbg", fmt("print(f\"{{}} = {{}}\")", { i(1, "var"), rep(1), })),
    s("dbg", {
        t("print(f\"{"),
        i(1),
        t(" = }\")"),
    }),
    s("ipdb", {
        t("import ipdb"),
        t { "", "" },
        t("ipdb.set_trace()"),
    })
}
