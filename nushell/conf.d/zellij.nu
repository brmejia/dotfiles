alias zj = zellij
alias zjri = zellij run --in-place --

def _zj_session_exists [$session_name: string] {
    let zj_sessions = (zj ls | rg $session_name | complete)

    return ( $zj_sessions.exit_code == 0 )
}

def _zj_is_session_running [$session_name: string] {
    let zj_sessions = (zj ls | rg $session_name | complete)

    let zj_exists = $zj_sessions.exit_code == 0

    mut is_session_running = false
    if $zj_exists {
        $is_session_running = ($zj_sessions.stdout | rg --invert-match --ignore-case "exited|attach" | complete).exit_code == 0
    }
    return $is_session_running
}

def _zj_create_session [ session_name: string, layout?: string] {

    if ( $layout | describe ) != nothing {
        print $"Creating a new `( $session_name )` session with layout ($layout)"
        zj -s $session_name -n $layout
    } else {
        print $"Creating a new `( $session_name )` session"
        zj -s $session_name
    }
}

def _zj_attach_or_create_session [ session_name: string, layout?: string] {
    let session_exists = _zj_session_exists $session_name
    let is_session_running = _zj_is_session_running $session_name

    print (
        [
            $"Session ($session_name):"
            $"\texists    : ($session_exists)"
            $"\tis running: ($is_session_running)"
        ] | str join "\n"
    )

    let layout_provided = ( $layout | describe ) != nothing
    if $layout_provided {
        let layout_exists = if $layout_provided { $layout | path exists } else { false }
        print (
            [
                $"Layout: ($layout)"
                $"\tfile : ($layout | path expand)"
                $"\texists : ($layout_exists)"
            ] | str join "\n"
        )
    }

    if $is_session_running {
        print $"Attaching to session `( $session_name )` "
        zj a $session_name
        return
    }

    if not $session_exists {
        _zj_create_session $session_name $layout
        return
    }

    # From here, the session exists but it's not running

    if not $layout_provided {
        print $"Attaching to a running `( $session_name )` session"
        zj a $session_name
        return
    }

    print $"Recreating session `( $session_name )` with provided layout file ( $layout )"
    zj d $session_name
    _zj_create_session $session_name $layout
}
