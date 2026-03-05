# Converts a .env file into a record
# may be used like this: open .env | load-env
# works with quoted and unquoted .env files
export def "from env" []: string -> record {
  lines
    | split column '#' # remove comments
    | get column1
    | parse "{key}={value}"
    | str trim value -c '"' # unquote values
    | transpose -r -d
}
