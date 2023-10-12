-- local lspconfig = require("lspconfig")
-- local lspconfig_configs = require("lspconfig.configs")
local lspconfig_util = require("lspconfig.util")

local function on_new_config(new_config, new_root_dir)
    local function get_typescript_server_path(root_dir)
        local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
        return project_root
                and (lspconfig_util.path.join(project_root, "node_modules", "typescript", "lib", "tsserverlibrary.js"))
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

local function get_volar_root_dir(file_path)
    local options = {
        { ".nuxtrc", ".npmrc" },
        { "package.json", "yarn.lock" },
    }
    local rdir = nil
    print("get_volar_root_dir(file_path)", vim.inspect(file_path))
    for _, value in pairs(options) do
        -- print("table.unpack(value)", table.unpack(value))
        rdir = lspconfig_util.root_pattern(table.unpack(value))(file_path)
        if rdir ~= "" then
            local msg = "Found volar root dir " .. rdir .. " with " .. vim.inspect(value)
            print(msg)
            vim.notify(msg, vim.log.levels.DEBUG)
            break
        end
        local msg = "Not found volar for " .. vim.inspect(value)
        print(msg)
        vim.notify(msg, vim.log.levels.DEBUG)
    end
    return rdir
end

local config = {
    -- cmd = { "vue-language-server", "--stdio" }, -- commented in order to use the binary installed with mason
    root_dir = get_volar_root_dir,
    -- on_new_config = on_new_config,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
    init_options = {
        typescript = {
            tsdk = "",
        },
        languageFeatures = {
            implementation = true, -- new in @volar/vue-language-server v0.33
            references = true,
            definition = true,
            typeDefinition = true,
            callHierarchy = true,
            hover = true,
            rename = true,
            renameFileRefactoring = true,
            signatureHelp = true,
            codeAction = true,
            workspaceSymbol = true,
            completion = {
                defaultTagNameCase = "both",
                defaultAttrNameCase = "kebabCase",
                getDocumentNameCasesRequest = false,
                getDocumentSelectionRequest = false,
            },
        },
    },
}

return config
