# $env.PATH = ($env.PATH | split row (char esep) | prepend "/home/andres/.config/carapace/bin")
#
# def --env get-env [name] { $env | get $name }
# def --env set-env [name, value] { load-env { $name: $value } }
# def --env unset-env [name] { hide-env $name }


# External completer example
let carapace_completer = {|spans: list<string>|
    carap $spans.0 nushell $spans
    | from json
    | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
}

let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}


# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    # overwrite
    let spans = (if $expanded_alias != null  {
        # put the first word of the expanded alias first in the span
        $spans | skip 1 | prepend ($expanded_alias | split row " ")
    } else { $spans })

    match $spans.0 {
        nu => $fish_completer
        rtx => $fish_completer
        podman => $fish_completer
        _ => $carapace_completer
    } | do $in $spans
}

mut current = (($env | default {} config).config | default {} completions)
$current.completions = ($current.completions | default {} external)
$current.completions.external = ($current.completions.external
    | default true enable
    | default $external_completer completer)

$env.config = $current
