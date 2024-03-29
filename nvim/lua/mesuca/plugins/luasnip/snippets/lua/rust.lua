local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local function snippet_function(
    args, -- text from i(2) in this example i.e. { { "456" } }
    parent, -- parent snippet or parent node
    user_args -- user_args from opts.user_args
)
    return "[1 = " .. args[1][1] .. "] [2 = " .. args[2][1] .. "]"
end

local example_snippet = s(
    "ex",
    fmta(
        [[
            <> - i(1)
            <> - i(2)
            <> - i(3)
            <> - i(4)
        ]],
        {
            i(1),
            f(
                snippet_function, -- callback (args, parent, user_args) -> string
                { 1, 2 }, -- node indice(s) whose text is passed to fn, i.e. i(2)
                { user_args = { "ASD" } } -- opts
            ),
            c(2, { t(""), t("tokio::test") }),
            f(
                test_function_declaration,
                { 2 },
                { user_args = { "ASD" } } -- opts
            ),
        }
    )
)

local function test_function_declaration(
    args, -- text from i(2) in this example i.e. { { "456" } }
    parent, -- parent snippet or parent node
    user_args -- user_args from opts.user_args
)
    local txt = ""
    if args[1][1] == "tokio::test" then
        txt = "async "
    end
    return txt
end

return {
    s(
        "dbg",
        fmta(
            [[
                dbg!(<>);
            ]],
            {
                i(0),
            }
        )
    ),
    s(
        "fn",
        fmta(
            [[
                fn <>(<>) <>
                    <>
                }
            ]],
            {
                i(1, "name"),
                c(2, {
                    t(""),
                    sn(
                        nil,
                        fmt("{1}: {2}", {
                            i(1, "x"),
                            i(2, "usize"),
                        })
                    ),
                }),
                c(3, {
                    t("{"),
                    sn(nil, fmt("-> {1} {{", { i(1, "ResultType") })),
                }),
                i(0),
            }
        )
    ),
    s(
        "aoc_solution",
        fmta(
            [[
                use crate::solutions::{Day, DaySolution, PartResult, Solution};

                #[derive(Debug)]
                pub struct Day<3> {}

                impl Day<4> {
                    pub fn new() ->> Self {
                        Self {}
                    }
                }

                impl Day for Day<5> {
                    fn get_year(&self) ->> usize {
                        return <1>;
                    }
                    fn get_day(&self) ->> usize {
                        return <2>;
                    }
                }

                impl Solution for Day<6> {

                    fn part1(&mut self) ->> PartResult {
                        let input = self.get_input(None);
                        let lines = aoc::parse_input_lines::<<String>>(&input).unwrap();

                        // Write here your solution<8>

                        return Ok(vec!["Incomplete".to_string()]);
                    }

                    fn part2(&mut self) ->> PartResult {
                        let input = self.get_input(None);
                        let lines = aoc::parse_input_lines::<<String>>(&input).unwrap();

                        // Write here your solution

                        return Ok(vec!["Incomplete".to_string()]);
                    }
                }

                impl DaySolution for Day<7> {}
            ]],
            {
                i(1, "YEAR"),
                i(2, "D"),
                rep(2),
                rep(2),
                rep(2),
                rep(2),
                rep(2),
                i(0),
            }
        )
    ),
    s(
        "aoc_test",
        fmta(
            [[
                #[cfg(test)]
                mod tests {
                    use super::*;

                    #[test]
                    fn test_examples() {
                        let validations = vec![
                            ("<2>", <3>),
                        ];

                        for (input, expected_result) in validations.into_iter() {
                            let result = <1>(input);

                            assert_eq!(result, expected_result);
                        }
                    }
                }

            ]],
            {
                i(1, "TEST_FUNCTION"),
                i(2, "meaning of life"),
                i(3, "42"),
            }
        )
    ),
    s(
        "tmod",
        fmta(
            [[
                #[cfg(test)]
                mod <1> {
                    #![allow(unused)]
                    use super::*;
                    <2>
                }
            ]],
            {
                i(1, "tests"),
                i(0),
            }
        )
    ),
    s(
        "tfn",
        fmta(
            [[
                #[<>]
                <>fn <>(<>) <>
                    <>
                }
            ]],
            {
                c(1, {
                    t("test"),
                    t("tokio::test"),
                }),
                f(test_function_declaration, { 1 }, {}),
                i(2, "name"),
                c(3, {
                    t(""),
                    sn(
                        nil,
                        fmt("{1}: {2}", {
                            i(1, "x"),
                            i(2, "usize"),
                        })
                    ),
                }),
                c(4, {
                    t("{"),
                    sn(nil, fmt("-> {1} {{", { i(1, "ResultType") })),
                    sn(nil, fmt("-> anyhow::Result<{1}> {{", { i(1, "()") })),
                }),
                i(0),
            }
        )
    ),
}
