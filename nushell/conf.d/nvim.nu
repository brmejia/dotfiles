def nvim-server [port: int, scope: string = "./" ] {
    let busy_port = (ss -tuln | rg $":($port)" | lines | length) > 0
    if $busy_port {
        error make {
            msg: $"Port ($port) is already in use",
            label: {
                text: $"This port is busy",
                span: ( metadata $port ).span
            }
        }
    }

    let scope_exists = $scope | path exists
    if not $scope_exists  {
        error make {
            msg: $"Provided scope path ($scope) does not exist",
            label: {
                text: "This path does not exist",
                span: ( metadata $scope ).span
            }
        }
    }

    let listen = $"0.0.0.0:($port)"
    mut working_dir = $scope | path expand
    if ( $scope | path type ) == "file" {
        $working_dir = $scope | path dirname
    }
    cd $working_dir

    let now = ( date now | format date "%F %X" )
    print $"[($now)] Running nvim server listening on ($listen): ($working_dir)"
    nvim --listen $listen --headless ($scope)
}
