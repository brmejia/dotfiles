# Nushell Environment Config File

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
$env.TRANSIENT_PROMPT_COMMAND = {|| " 🡆  " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
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
    $env.NU_LIB_DIRS
    | append $nu_custom_config_dir
)

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
use std "path add"
$env.PATH = ($env.PATH | split row (char esep))
path add ($env.HOME | path join .local bin)
path add ($env.HOME | path join .cargo bin)
$env.PATH = ($env.PATH | uniq)

$env.EDITOR = "nvim"
$env.VISUAl = "nvim"

# This code will add carapace nushell completions if needed
# $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
# mkdir ~/.cache/carapace
# carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

use std log

# This code will add mise config if needed
let mise_config_path = $nu_custom_config_dir | path join mise.nu
if not ($mise_config_path | path exists) {
    log info $"Creating mise config at ($mise_config_path)"
    ^mise activate nu | save $mise_config_path --force
}

# This code will add atuin config if needed
let atuin_config_path = "~/.local/share/atuin/init.nu"
if not ($atuin_config_path | path exists) {
    log info $"Creating atuin config at ($atuin_config_path)"
    ^atuin activate nu | save $atuin_config_path --force
}

# This code will add zoxide config if needed
let zoxide_config_path = $nu_custom_config_dir | path join zoxide.nu
if not ($zoxide_config_path | path exists) {
    log info $"Creating zoxide config at ($zoxide_config_path)"
    ^zoxide init nushell | save -f $zoxide_config_path
}
