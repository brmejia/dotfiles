export-env {
  $env.RTX_SHELL = "nu"
  $env.RTX_USE_TOML = 1

  $env.config = ($env.config | upsert hooks {
      pre_prompt: [{
      condition: {|| "RTX_SHELL" in $env }
      code: {|| rtx_hook }
      }]
      env_change: {
          PWD: [{
          condition: {|| "RTX_SHELL" in $env }
          code: {|| rtx_hook }
          }]
      }
  })
}

def "parse vars" [] {
  $in | lines | parse "{op},{name},{value}"
}

def-env rtx [command?: string, --help, ...rest: string] {
  let commands = ["shell", "deactivate"]

  if ($command == null) {
    ^"/home/andres/.cargo/bin/rtx"
  } else if ($command == "activate") {
    $env.RTX_SHELL = "nu"
  } else if ($command in $commands) {
    ^"/home/andres/.cargo/bin/rtx" $command $rest
    | parse vars
    | update-env
  } else {
    ^"/home/andres/.cargo/bin/rtx" $command $rest
  }
}

def-env "update-env" [] {
  for $var in $in {
    if $var.op == "set" {
      $env.$var.name = $"($var.value)"
    } else if $var.op == "hide" {
      hide-env $var.name
    }
  }
}

def-env rtx_hook [] {
  ^"/home/andres/.cargo/bin/rtx" hook-env -s nu
    | parse vars
    | update-env
}


