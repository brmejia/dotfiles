-- local lspconfig = require("lspconfig")
-- local lspconfig_configs = require("lspconfig.configs")

local function on_new_config(new_config, new_root_dir)
    local function get_typescript_server_path(root_dir)
        local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
        return project_root
                and (lspconfig_util.path.join(
                    project_root,
                    "package.json",
                    "node_modules",
                    "typescript",
                    "lib",
                    "tsserverlibrary.js"
                ))
            or ""
    end

    if
        new_config.init_options
        and new_config.init_options.typescript
        and new_config.init_options.typescript.tsdk == ""
    then
        new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
    end
end

local function root_dir(...)
    local lspconfig_util = require("lspconfig.util")
    local rdir = lspconfig_util.root_pattern("package.json")(...)
    return rdir
end

local config = {
    cmd = { "vue-language-server", "--stdio" },
    -- root_dir = root_dir,
    -- on_new_config = on_new_config,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
}

return config
