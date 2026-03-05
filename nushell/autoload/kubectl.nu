export alias k = kubectl

def kctl [...args: any] {
    print $"k ($args | str join ' ') \n"
    k ...$args
}
#
# set default namespace
export alias kns = k config set-context --current --namespace
export alias kg = k get
export alias kd = k describe
export alias krm = k delete
export alias kgn = kg namespace
export alias kga = k get all
export alias kgpo = k get pod

# get 'real' all
# def kgworld [...args: string] = {
#     let resources = (k api-resources --verbs=list --namespaced -o name | lines | str join ',')
#     echo "$resources"
#     kctl get $resources
# }

export def kgworld [...args: string] {
    let resources = (k api-resources --verbs=list --namespaced -o name )
    $resources | lines | par-each { |r|
        # print "-------------------------"
        let kout = k get $r | complete
        # print $r
        let kout_stats = $kout.stdout | str trim | str stats
        if ( $kout_stats.words > 0 ) {
            print (
                [
                    "\n",
                    $r,
                    "-----------------------",
                    ( $kout.stdout | str trim )
                ] | str join "\n"
            )
        }
    };
}

# start a debug pod (including lots of troubleshooting tools)
export def kdebug-ns [namespace: string = 'default'] {
    k -n $namespace run $"debug-($env.USER | str replace _ -)" --rm -it --tty --image leodotcloud/swiss-army-knife:v0.12 --image-pull-policy=IfNotPresent -- bash
}

export def kdebug [pod: string, target: string, --namespace (-n): string, ...args: any] {
    mut ns = $namespace
    if $ns == null {
        let current_context = (k config view | from yaml | select current-context | get current-context)
        let current_namespace = (k config view -o jsonpath=$"{.contexts[?\(@.name == '($current_context)'\)].context.namespace}")
        $ns = $current_namespace
    }
    let image = 'busybox'
    let image = 'leodotcloud/swiss-army-knife'
    print $"image:     ($image)"
    print $"namespace: ($ns)"
    print $"pod:       ($pod)"
    print $"target:    ($target)"

    k -n $ns debug -it  $pod --target=($target) --image=($image) -- ...$args
}
