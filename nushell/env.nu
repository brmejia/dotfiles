# Nushell Environment Config File

# See default_env.nu for more information:
# https://github.com/nushell/nushell/blob/main/crates/nu-utils/src/sample_config/default_env.nu

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
$env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "🡆  " }
$env.TRANSIENT_PROMPT_INDICATOR = {|| "❯ " }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }


# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
# $env.NU_LIB_DIRS = [
#     ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
#     ($nu.data-dir | path join 'completions') # default home for nushell completions
# ]
let nu_custom_config_dir = $nu.default-config-dir | path join conf.d
$env.NU_LIB_DIRS = (
    $env.NU_LIB_DIRS | split row (char esep)
    | append $nu_custom_config_dir
    | append ( $nu_custom_config_dir | path join local )
)

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
use std "path add"
$env.PATH = ($env.PATH | split row (char esep))
path add ($env.HOME | path join .local bin)
path add ($env.HOME | path join .cargo bin)
path add /opt/cargo/bin
$env.PATH = ($env.PATH | uniq)

$env.EDITOR = "nvim"
$env.SUDO_EDITOR = "nvim"
$env.VISUAl = "nvim"

use std log

# This code will add mise config if needed
let mise_config_path = $nu_custom_config_dir | path join mise.nu
if not ($mise_config_path | path exists) {
    log info $"Creating mise config at ($mise_config_path)"
    ^mise activate nu | save --force $mise_config_path
}

# This code will add zoxide config if needed
let zoxide_config_path = $nu_custom_config_dir | path join zoxide.nu
if not ($zoxide_config_path | path exists) {
    log info $"Creating zoxide config at ($zoxide_config_path)"
    ^zoxide init nushell | save --force $zoxide_config_path
}

# This code will add carapace nushell completions if needed
let carapace_config_path = $"($env.HOME)/.cache/carapace/init.nu"
if not ($carapace_config_path | path exists) {
    mkdir ( $carapace_config_path | path dirname )
    log info $"Creating carapace config at ($carapace_config_path)"
    ^carapace init nushell | save --force $carapace_config_path
}


let vendor_autoload_path = ($nu.data-dir | path join "vendor/autoload/")

# This code will add atuin config if needed
let atuin_config_path = ($vendor_autoload_path | path join "atuin.nu")
if not ($atuin_config_path | path exists) {
    log info $"Creating atuin config at ($atuin_config_path)"
    ^atuin init nu | save --force $atuin_config_path
}

# This code will add starship nushell configuration if needed
let starship_config_path = ($vendor_autoload_path | path join "starship.nu")
if not ($starship_config_path | path exists) {
    mkdir ( $starship_config_path | path dirname )
    log info $"Creating starship config at ($starship_config_path)"
    ^starship init nu | save --force $starship_config_path
}
